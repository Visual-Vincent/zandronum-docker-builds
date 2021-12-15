#!/bin/bash
#
# Description:
#   Extracts the compiled server binaries from a Docker image into an uncompressed tarball.
#

dockerimg=$1
destfile=$2

# Thanks to: https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ -z "$dockerimg" ] || [ -z "$destfile" ]; then
    echo \
"Extracts the compiled server binaries from a Docker image into an uncompressed tarball.
Usage:
    extract-server <docker-image> <dst-file>"

    return 2>/dev/null
    exit
fi

EXTRACT_TAR=${EXTRACT_TAR:-1} "$SCRIPT_DIR/docker-extract-dir.sh" "$dockerimg" /zandronum-server "$destfile"