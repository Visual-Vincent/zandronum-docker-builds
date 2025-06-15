#!/bin/bash
dir=AlmaLinux-9-10
tag=almalinux9

set -e
common/generate-dockerfile.sh "$dir" almalinux:9
cd $dir/build
set +e

docker build --rm --no-cache --progress=plain -t zandronum:3.2-$tag \
    --build-arg ZAN_BUILD_CLIENT=${ZAN_BUILD_CLIENT:-0} .

# Cleanup
cd ..
rm -rf build
