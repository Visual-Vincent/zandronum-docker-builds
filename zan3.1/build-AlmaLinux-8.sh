#!/bin/bash
dir=AlmaLinux-8

set -e
common/generate-dockerfile.sh "$dir" almalinux:8
cd $dir/build
set +e

docker build --rm --no-cache --progress=plain -t zandronum:3.1 \
    --build-arg ZAN_BUILD_CLIENT=${ZAN_BUILD_CLIENT:-0} .

# Cleanup
rm -rf build
