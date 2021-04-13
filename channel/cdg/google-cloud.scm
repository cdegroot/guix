(define-module (cdg google-cloud)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system copy)
  #:use-module (guix download)
  #:use-module (gnu packages python))

(define-public google-cloud-sdk
  (package
   (name "google-cloud-sdk")
   (version "335.0.0")
   (source
    (origin
     (method url-fetch/tarbomb)
        (uri (string-append "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-"
                            version
                            "-linux-x86_64.tar.gz"))
        (sha256
         (base32 "12vbzi863x9p611548q0j7lnp0f2mjnp86sam21w63f77dv39hlw"))))
   (build-system copy-build-system)
   (arguments
    '(#:install-plan '(("google-cloud-sdk/" "/" #:exclude-regexp ("/test/" "/tests/")))))
   (inputs
    `(("python3" ,python)))
   (synopsis "Google Cloud SDK")
   (description "Google Cloud SDK, including the cloud CLI")
   (license license:asl2.0)
   (home-page "https://https://cloud.google.com/sdk/docs/install")))
