#!/bin/bash
subdir=$1
architecture=$2

FILES="brightmaps.pk3
../fmodapi44464linux/api/lib/libfmodex${architecture}-4.44.64.so
output_sdl/liboutput_sdl.so
skulltag_actors.pk3
zandronum
zandronum.pk3
zandronum-server"

for file in $FILES; do
    if [ -f $file ]; then
        filename=$(basename "$file")
        cp "$file" "/zandronum/bin/$subdir/$filename"
    fi
done
