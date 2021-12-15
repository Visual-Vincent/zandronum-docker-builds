#!/bin/bash
dir=$1
dockerimg=$2
sed -e 's/\$\$IMAGE\$\$/'$dockerimg'/' ./common/Dockerfile.template > ./$dir/Dockerfile
cp ./common/buildscript.sh ./$dir/build.sh
