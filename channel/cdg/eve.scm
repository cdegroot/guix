;; Work in progress. While it installs and starts, it doesn't actually run yet.
;; Todo once it runs:
;; - install everything in libexec or something
;; - wrapper script in bin
;; - Gnome desktop entry
(define-module (cdg eve)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages wine)
  #:use-module (gnu packages xorg)
  #:use-module (guix build utils)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (ice-9 match)
  #:use-module (nongnu packages game-development)
  #:use-module (nonguix build-system binary))

(define-public eve-online
  (package
    (name "eve-online")
      (version "1747682")
      (source
       (origin
         (method url-fetch/tarbomb)
         (uri
          (string-append "https://binaries.eveonline.com/evelauncher-"
                         version ".tar.gz"))
         (sha256
          (base32
           "1jhbd9n87rrz0ssgrqw962kr45cjc567c7s6jr4bfzrdjfwz9k4q"))))
      (build-system binary-build-system)
      (arguments
       `(#:patchelf-plan
         `(("evelauncher/evelauncher"
            ("gcc:lib" "glibc" "zlib" "qtbase" "libxcb" "qtwebengine" "qtwebchannel" "qtwebsockets"))
           ("evelauncher/libprotobuf.so.16" ("zlib"))
           ;Gives some strange messages, leave out for now.
           ;("evelauncher/libgrpc.so.6" ("openssl-1.0"))
           )
         #:install-plan
         `(("evelauncher" "evelauncher"))
         #:phases
         (modify-phases %standard-phases
           (add-before 'install 'fix-qt-settings
             (lambda _
               (substitute* "evelauncher/evelauncher.sh"
                           (("export QT.*$") ""))))
           (add-before 'install 'delete-bundled-libs
             (lambda _
               (delete-file-recursively "evelauncher/plugins")
               (delete-file "evelauncher/QtWebEngineProcess")
               (delete-file "evelauncher/qt.conf")
               ;(for-each delete-file (find-files "evelauncher" "libssl.*"))
               ;(for-each delete-file (find-files "evelauncher" "libcrypto.*"))
               (for-each delete-file (find-files "evelauncher" "libQt5.*"))
               (for-each delete-file (find-files "evelauncher" "libicu.*"))
               (for-each delete-file (find-files "evelauncher" "libpng.*"))
               (for-each delete-file (find-files "evelauncher" "libxcb.*"))))
           (add-after 'install 'install-wrapper-script
             (lambda* (#:key outputs #:allow-other-keys)
               (let* ((out (assoc-ref outputs "out"))
                      (real-script (string-append out "/evelauncher/evelauncher.sh"))
                      (bin-dir (string-append out "/bin"))
                      (wrapper (string-append bin-dir "/evelauncher")))
                 (mkdir-p bin-dir)
                 (call-with-output-file wrapper
                   (lambda (p)
                     (format p "\
#!~a
if [ -f ~~/.config/CCP/EVE.conf ]
then
  echo
  echo ~~/.config/CCP/EVE.conf already exists, not overwriting.
  echo
  echo Please make sure you use current wine, the launcher comes with a pretty old version.
  echo
  echo Wine path could be ~a
  echo '                or' $GUIX_PROFILE/bin/wine
  echo
else
  mkdir -p ~~/.config/CCP
  cat >~~/.config/CCP/EVE.conf <<EOF
[General]
UseCustomWine=true
CustomWinePath=~a
EOF
fi
export QT_PLUGIN_PATH=~a
export QTWEBENGINEPROCESS_PATH=~a
exec ~a
"
                           (which "bash")
                           (which "wine") (which "wine")
                           (getenv "QT_PLUGIN_PATH")
                           (getenv "QTWEBENGINEPROCESS_PATH")
                           real-script)))
                 (chmod wrapper #o555))))
           (add-before 'patchelf 'patchelf-writable
             (lambda _
               (for-each make-file-writable (find-files ".")))))))
      (inputs
       `(("gcc:lib" ,gcc "lib")
         ("glibc" ,glibc)
         ("zlib" ,zlib)
         ("openssl-1.0" ,openssl-1.0)
         ("qtbase" ,qtbase)
         ("qtwebengine" ,qtwebengine)
         ("qtwebchannel" ,qtwebchannel)
         ("qtwebsockets" ,qtwebsockets)
         ("libxcb" ,libxcb)
         ("wine64" ,wine64)))
      (home-page "https://forums.eveonline.com/t/linux-launcher-key-details/159751/3")
      (supported-systems '("x86_64-linux"))
      (synopsis "Linux version of the EVE launcher")
      (description "EVE Online is a massively multiplayer online space spreadsheet program")
      (license license:expat)))
