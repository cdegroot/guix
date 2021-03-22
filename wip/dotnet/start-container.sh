#!/bin/sh
#
sourcedir=${1-$HOME/tmp/source-build}
set -e
scriptdir=$(cd $(dirname $0); pwd)
cd $sourcedir
rm -f .guix-gc-root
#guix time-machine -C $scriptdir/channels.scm --
guix environment --container --network --link-profile \
    --root=.guix-gc-root \
    --pure \
    --expose=$GUIX_PROFILE/bin/env=/usr/bin/env \
    --expose=$GUIX_PROFILE/bin/bash=/bin/bash \
    --expose=$scriptdir=/build \
    --ad-hoc -e '(@ (gnu) %base-packages))' -e '(list (@ (gnu packages gcc) gcc-10) "lib")'\
              cmake make clang-toolchain python glibc-utf8-locales git curl \
                bash openssl wget nss-certs patchelf mit-krb5 \
              glibc icu4c libunwind liburcu lttng-ust linux-libre-headers \
    -- bash
