;; TODO: actually be selective instead of copy the whole thing over
;; TODO: patch scripts so plugins are under asdf_dir instead of asdf_data_dir
;; TODO: add plugins. They should all land under a common directory
;;       that is added to GUIX_PROFILE. Probably using a common function it
;;       can be super quick.
(define-module (cdg asdf-vm)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system copy)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages version-control))

(define-public asdf-vm
  (let ((commit "c6145d08d01691a6e16c990e7d1c8778733e8c76")
        (revision "1"))
    (package
      (name "asdf-vm")
      (version (git-version "v0.8.0" revision commit))
      (source
       (origin
        (method git-fetch)
        (file-name (git-file-name name version))
        (uri (git-reference
              (url "https://github.com/asdf-vm/asdf")
              (commit commit)))
        (sha256
         (base32 "07pn23dazjglwadaqczmw0zwlmfvw8r8zmlvraqjlkq8hkvqv28k"))))
      (build-system copy-build-system)
      (native-search-paths
       (list (search-path-specification
              (variable "ASDF_DIR")
              (separator #f)
              (files '(".")))))
      (inputs
       `(("bash" ,bash)
         ("git" ,git)))
      (synopsis "Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more ")
      (description "asdf is a CLI tool that can manage multiple language runtime versions
on a per-project basis. It is like gvm, nvm, rbenv & pyenv (and more) all in one.")
      (license license:expat)
      (home-page "https://asdf-vm.com"))))
