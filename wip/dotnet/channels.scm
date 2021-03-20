;; This channel file can be passed to 'guix pull -C' or to
;; 'guix time-machine -C' to obtain the Guix revision that was
;; used to populate this profile.

(list
     ;; Note: these other commits were also used to install some of the packages in this profile:
     ;;   "15423d38c57d04bc1bbc70c7bd79eaf8cf82d513"
     (channel
       (name 'guix)
       (url "https://git.savannah.gnu.org/git/guix.git")
       (commit
         "d4e29f3628ad0c7576d7cab659d7fcc19d21999a")
       (introduction
         (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
     (channel
       (name 'flat)
       (url "https://github.com/flatwhatson/guix-channel.git")
       (commit
         "ea111f6020e290a6dc87e3c993f6c17633961aa2")
       (introduction
         (make-channel-introduction
           "33f86a4b48205c0dc19d7c036c85393f0766f806"
           (openpgp-fingerprint
             "736A C00E 1254 378B A982  7AF6 9DBE 8265 81B6 4490"))))
     (channel
       (name 'nonguix)
       (url "https://gitlab.com/nonguix/nonguix")
       (commit
         "54b83587669b5df5fe36bce058f4f2cf34d8a63c")
       (introduction
         (make-channel-introduction
           "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
           (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
)
