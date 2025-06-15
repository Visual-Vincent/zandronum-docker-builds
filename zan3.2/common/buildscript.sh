#!/bin/bash
set -e

cd /zandronum

# Run pre-build script
/zandronum/prebuild.sh

# Clone the source code
hg clone https://foss.heptapod.net/zandronum/zandronum-stable build
mkdir -pv build/buildclient build/buildserver /zandronum/bin/client /zandronum/bin/server

# Download FMOD
wget -nc https://zandronum.com/essentials/fmod/fmodapi44464linux.tar.gz
tar -xvzf fmodapi44464linux.tar.gz -C build
rm -f fmodapi44464linux.tar.gz

# Checkout the relevant Zandronum version
cd /zandronum/build
hg update ZA_3.2
#hg update -c $(hg log -l1 -k 'changed the version string to' --template '{node}\n') # Trick to pick the latest stable version

# Remove gl/api/glext.h import as it causes problems with newer versions of GLEW
sed -i '/"gl\/api\/glext.h"/d' /zandronum/build/src/gl/system/gl_system.h

if [ "${ZAN_BUILD_CLIENT:-0}" == "1" ]; then

    # Compile client executable
    a='' && [ "$(uname -m)" = x86_64 ] && a=64
    c="$(lscpu -p | grep -v '#' | sort -u -t , -k 2,4 | wc -l)" ; [ "$c" -eq 0 ] && c=1
    cd /zandronum/build/buildclient &&
    rm -f output_sdl/liboutput_sdl.so &&
    if [ -d "../fmodapi44464linux" ]; then
    f="-DFMOD_LIBRARY=../fmodapi44464linux/api/lib/libfmodex${a}-4.44.64.so \
    -DFMOD_INCLUDE_DIR=../fmodapi44464linux/api/inc"; else
    f='-UFMOD_LIBRARY -UFMOD_INCLUDE_DIR'; fi &&
    cmake .. -DCMAKE_BUILD_TYPE=Release -DSERVERONLY=OFF -DRELEASE_WITH_DEBUG_FILE=OFF $f &&
    make -j$c

    # Copy to output directory
    /zandronum/copy-output.sh client $a

fi

# Compile server executable
c="$(lscpu -p | grep -v '#' | sort -u -t , -k 2,4 | wc -l)" ; [ "$c" -eq 0 ] && c=1
cd /zandronum/build/buildserver &&
cmake .. -DCMAKE_BUILD_TYPE=Release -DSERVERONLY=ON -DRELEASE_WITH_DEBUG_FILE=OFF &&
make -j$c

# Copy to output directory
/zandronum/copy-output.sh server

# Run post-build script
/zandronum/postbuild.sh

set +e
