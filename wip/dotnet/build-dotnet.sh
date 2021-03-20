#!/usr/bin/env bash
set -euo pipefail

# Avoids .NET wanting and failing to find ICU lib
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true
# Helps in .NET finding libssl. Without it, it fails.
export LD_LIBRARY_PATH=$GUIX_ENVIRONMENT/lib
./build.sh
