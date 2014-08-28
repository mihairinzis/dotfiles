#!/bin/bash

ignore=('..' '.' '.git' '.config' '.emacs.d')

function symfile {
    if [[ ${ignore[*]} =~ $file ]]; then
        continue
    fi
    if [ -d "$LINK" ]; then
        rm -rf "$LINK"
    fi
    ln -sfvn $ACTUAL $LINK
}

for file in .*; do
    ACTUAL="$(pwd)/$file"
    LINK="$HOME/$file"
    symfile $ACTUAL $LINK
done

for file in .config/*; do
    ACTUAL="$(pwd)/$file"
    LINK="$HOME/$file"
    symfile $ACTUAL $LINK
done
