set -e
cd ~/OpenSource/dotnet-source-build
rm -f .guix-gc-root
guix environment --container --network --root=.guix-gc-root \
    --pure \
    --expose=$GUIX_PROFILE/bin/env=/usr/bin/env \
    --ad-hoc -e '(@ (gnu) %base-packages))' \
              git curl openssl wget nss-certs patchelf gcc-toolchain \
    -- bash

# Notes. First, install .dotnet.
# eng/common/dotnet-install.sh
# Then, patch dotnet executable
#
