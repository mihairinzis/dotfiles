#!/bin/bash

ignore=('..' '.' '.git' '.config' '.emacs.d' '.gnupg')
home_dirs=('.config' '.gnupg')

function symfile {
    if [ -d "$LINK" ]; then
        rm -rf "$LINK"
    fi
    ln -sfvn $ACTUAL $LINK
}

for file in .*; do
    if [[ ${ignore[*]} =~ $file ]]; then
        continue
    fi
    ACTUAL="$(pwd)/$file"
    LINK="$HOME/$file"
    symfile $ACTUAL $LINK
done


for dir in "${home_dirs[@]}"; do
    if [ ! -d "$HOME/$dir" ]; then
        mkdir -v "$HOME/$dir"
    fi
    for file in $dir/*; do
        ACTUAL="$(pwd)/$file"
        LINK="$HOME/$file"
        symfile $ACTUAL $LINK
    done
done
