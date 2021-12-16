#!/bin/bash
#
# Description:
#   Extracts the compiled Zandronum binaries from a Docker image into an uncompressed tarball.
#

bintype=$1
dockerimg=$2
destfile=$3

if [ -z "$bintype" ] || [ -z "$dockerimg" ] || [ -z "$destfile" ]; then
    echo \
"Extracts the compiled Zandronum binaries from a Docker image into an uncompressed tarball.
Usage:
    extract-bin <server|client> <docker-image> <dst-file>"

    return 2>/dev/null
    exit
fi

dir=""

case "$bintype" in
    client)
        dir="/zandronum"
        ;;
    server)
        dir="/zandronum-server"
        ;;
esac

if [ -z "$dir" ]; then
    echo "Invalid type \"$bintype\""
    return 2>/dev/null
    exit
fi

# Thanks to: https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

EXTRACT_TAR=${EXTRACT_TAR:-1} "$SCRIPT_DIR/docker-extract-dir.sh" "$dockerimg" "$dir" "$destfile"