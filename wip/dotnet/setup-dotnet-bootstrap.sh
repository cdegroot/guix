#!/usr/bin/env bash
set -euo pipefail

# Dotnet build starts with setting up a bootstrap.
# TODO uncomment at one point ;-). Too much hassle to download the world every time.
#eng/common/dotnet-install.sh

# Fix the downloaded executable
patchelf --set-interpreter $(patchelf --print-interpreter $(readlink f $(which sh))) .dotnet/dotnet
patchelf --set-rpath $(patchelf --print-rpath $(readlink f $(which sh))) .dotnet/dotnet
