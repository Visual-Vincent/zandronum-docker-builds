#!/bin/bash
#
# Description:
#   Extracts a directory from a Docker image
#

dockerimg=$1
srcdir=$2
destdir=$3

if [ -z "$dockerimg" ] || [ -z "$srcdir" ] || [ -z "$destdir" ]; then
    echo \
"Extracts a directory from a Docker image.
Usage:
    docker-extract-dir <docker-image> <src-dir> <dst-dir>"

    return 2>/dev/null
    exit
fi

id=$(docker create "$dockerimg")

if [ "${EXTRACT_TAR:-0}" == "1" ]; then
    docker cp "$id:$srcdir" - > "$destdir"
else
    docker cp "$id:$srcdir" "$destdir"
fi

docker rm -v $id