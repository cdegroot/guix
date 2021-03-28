(define-module (cdg eve)
  #:use-module (ice-9 match)
  #:use-module (guix build utils)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (nonguix build-system binary)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages wine)
  #:use-module (nongnu packages game-development))

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
           ;;(,,(find-files "." "\\.so[0-9.]*$"))
           )
         #:install-plan
         `(("evelauncher" "."))
         #:phases
         (modify-phases %standard-phases
           (add-before 'install 'delete-bundled-libs
             (lambda _
               (for-each delete-file (find-files "evelauncher" "libQt5.*"))
               (for-each delete-file (find-files "evelauncher" "libicu.*"))
               (for-each delete-file (find-files "evelauncher" "libpng.*"))
               (for-each delete-file (find-files "evelauncher" "libxcb.*"))
               ))
           (add-before 'patchelf 'patchelf-writable
             (lambda _
               (for-each make-file-writable (find-files ".")))))))
      (inputs
       `(("gcc:lib" ,gcc "lib")
         ("glibc" ,glibc)
         ("zlib" ,zlib)
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
