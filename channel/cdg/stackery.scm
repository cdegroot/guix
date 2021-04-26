(define-module (cdg stackery)
  #:use-module (guix packages)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module ((nonguix licenses) #:prefix license:)
  #:use-module (guix build-system copy)
  #:use-module (guix download))

(define-public stackery
  (package
    (name "stackery")
    (version "5.0.2")
    (source
     (origin
       (method url-fetch/executable)
       (uri (string-append "https://ga.cli.stackery.io/linux/stackery"))
       (file-name "stackery.gz")
       (sha256
        (base32 "0samjfj2y6hhv6xvf8fc1lbb32f4p149rs0df87scdav29k2gw4g"))))
    (build-system copy-build-system)
    (arguments
     '(#:install-plan '(("stackery" "bin/"))
       #:phases (modify-phases %standard-phases
                  (replace 'unpack (lambda* (#:key source #:allow-other-keys)
                                      (invoke "bash" "-c" (string-append "zcat <" source " >stackery"))
                                      (invoke "chmod" "+x" "stackery")
                                      #t)))))
    (inputs `(("bash" ,bash)
              ("gzip" ,gzip)))
    (synopsis "Stackery CLI")
    (description "The stackery.io CLI tool")
    (license (license:nonfree "https://docs.stackery.io/docs/using-stackery/cli"))
    (home-page "https://docs.stackery.io/docs/using-stackery/cli")
  ))
