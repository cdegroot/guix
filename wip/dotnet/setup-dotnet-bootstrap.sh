#!/usr/bin/env bash
set -euo pipefail

# Dotnet build starts with setting up a bootstrap.
eng/common/dotnet-install.sh

# Fix the downloaded executable
patchelf --set-interpreter $(patchelf --print-interpreter $(readlink f $(which sh))) .dotnet/dotnet
patchelf --set-rpath $(patchelf --print-rpath $(readlink f $(which sh))) .dotnet/dotnet
