#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]
then
    echo "Usage: $0 file package"
    exit 1
fi

tmpfile=`mktemp`
(cat $1; echo; echo $2) >$tmpfile
guix build -K -f $tmpfile
echo "Use 'guix package -f $tmpfile' to install as a package"
