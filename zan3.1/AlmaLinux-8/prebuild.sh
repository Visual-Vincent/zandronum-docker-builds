#!/bin/bash

# Install required dependencies
dnf -y update
dnf -y install epel-release dnf-plugins-core make wget python3
dnf config-manager --set-enabled powertools
dnf -y install gcc-c++ make cmake SDL-devel mercurial zlib-devel \
bzip2-devel libjpeg-turbo-devel fluidsynth-devel gtk2-devel nasm \
mesa-libGL-devel openssl-devel tar glew-devel

# Download TiMidity++ source code
mkdir -pv timidity
wget -nc https://downloads.sourceforge.net/project/timidity/TiMidity%2B%2B/TiMidity%2B%2B-2.15.0/TiMidity%2B%2B-2.15.0.tar.gz
tar -xvzf TiMidity++-2.15.0.tar.gz -C timidity

# Build and install TiMidity++
cd timidity/TiMidity++-2.15.0
./configure
make
make install
cd ../..

rm -f TiMidity++-2.15.0.tar.gz
