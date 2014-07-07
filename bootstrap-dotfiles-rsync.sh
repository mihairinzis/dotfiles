#!/bin/bash

rsync --exclude ".git/" \
    --exclude "bootstrap-dotfiles-rsync.sh" \
    --exclude "backup.sh" \
    --exclude "whiptails-debinstall.sh" \
    --exclude ".emacs.d" \
    --exclude "packages" \
    --exclude "README.md"  \
    -avh --no-perms . ~;
