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
#guix package -f $tmpfile
