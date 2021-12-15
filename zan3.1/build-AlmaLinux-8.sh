#!/bin/bash
dir=AlmaLinux-8

set -e
common/generate-dockerfile.sh "$dir" almalinux:8
cd $dir
set +e

docker build --rm --progress=plain -t zandronum:3.1 .
rm -f Dockerfile build.sh
