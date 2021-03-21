# Building .NET Core

The code here is prep work for a Guix .NET Core package (or, rather, two - 3.1 and 5.0).

    ./clone.sh
    ./start-container.sh

to start an environment (wrap it with `guix time-machine --channels channels.scm` to get my
environment). Then, in the container:

    /build/setup-dotnet-bootstrap.sh

To download and patch the bootstrap binary, and

    /build/build-dotnet.sh

To build dotnet.

* TODO: the build script starts downloading the binaries again, so the order now is "setup", "build",
  "setup", "build". Figure out the proper steps.

I'm building against the `release/5.0` branch, commit id `c13177f2205e4eb8e19e08ac45889b793edc9a2d`

The dotnet source repo is checked out under `~/tmp` by default, which is a totally non-standard
path I like, so feel free to add an argument to point it where you want it :)
