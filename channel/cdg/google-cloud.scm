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

(define-public kubectl
  (package
    (name "kubectl")
    (version "v1.12.9")
    (source
     (origin
       (method url-fetch/executable)
       (uri (string-append "https://dl.k8s.io/release/"
                           version
                           "/bin/linux/amd64/kubectl"))
       (file-name "kubectl")
       (sha256
        (base32 "07sgj5qj0xp6jrasqz2q1abgabb4mb4d3wcril747d65hfjyz82k"))))
    (build-system copy-build-system)
    (arguments
     '(#:install-plan '(("kubectl" "bin/"))
       #:phases (modify-phases %standard-phases
                  (replace 'unpack (lambda* (#:key source #:allow-other-keys)
                                      (invoke "cp" source "kubectl")
                                      #t)))))
    (inputs '())
    (synopsis "Kubernetes kubectl")
    (description "The kubectl command line utility from Kubernetes")
    (license license:asl2.0)
    (home-page "https://github.com/kubernetes/kubernetes/")
  ))
