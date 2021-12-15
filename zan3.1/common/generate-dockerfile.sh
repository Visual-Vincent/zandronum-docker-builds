#!/bin/bash
dir=$1
dockerimg=$2

mkdir ./$dir/build

cp ./common/buildscript.sh ./$dir/build/build.sh
cp ./common/copy-output.sh ./$dir/build/copy-output.sh
cp ./$dir/prebuild.sh ./$dir/build/prebuild.sh
cp ./$dir/postbuild.sh ./$dir/build/postbuild.sh

sed -e 's/\$\$IMAGE\$\$/'$dockerimg'/' ./common/Dockerfile.template > ./$dir/build/Dockerfile
