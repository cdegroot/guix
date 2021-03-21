#!/usr/bin/env bash
set -euo pipefail

sourcedir=${1-$HOME/tmp/source-build}
git clone https://github.com/dotnet/source-build $sourcedir
cd $sourcedir
git checkout -b guix/5.0 c13177f2205e4eb8e19e08ac45889b793edc9a2d
