#!/bin/bash

ignore=('..' '.' '.git' '.config')
home_dirs=('.config')

function symfile {
    ACTUAL="$(pwd)/$file"
    LINK="$HOME/$file"
    if [ -d "$LINK" ]; then
        rm -rf "$LINK"
    fi
    ln -sfvn $ACTUAL $LINK
}

for file in .*; do
    if [[ ${ignore[*]} =~ $file ]]; then
        continue
    fi
    symfile $file
done


for dir in "${home_dirs[@]}"; do
    if [ ! -d "$HOME/$dir" ]; then
        mkdir -v "$HOME/$dir"
    fi
    for file in $dir/*; do
        symfile $file
    done
done
