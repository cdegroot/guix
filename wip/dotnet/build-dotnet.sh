#!/usr/bin/env bash
set -euo pipefail

export GUIX_LOCPATH=$GUIX_ENVIRONMENT/lib/locale

# Has hardcoded paths that potentially point to the
# wrong profile. The build is too long to worry anyway.
# Note that this is only an issue when the build fails and
# you restart it halfway through, a clean build won't need this.
find . -name CMakeCache.txt | xargs rm -f

# Avoids .NET wanting and failing to find ICU lib
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true
# Helps in .NET finding libssl. Without it, it fails.
export LD_LIBRARY_PATH=$GUIX_ENVIRONMENT/lib
./build.sh
