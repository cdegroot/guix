# Building .NET Core

The code here is prep work for a Guix .NET Core package (or, rather, two - 3.1 and 5.0).

    start-container.sh

to start an environment (wrap it with `guix time-machine --channels channels.scm` to get my
environment). Then, in the container:

    setup-dotnet-bootstrap.sh

To download and patch the bootstrap binary, and

    build-dotnet.sh

To build dotnet.
