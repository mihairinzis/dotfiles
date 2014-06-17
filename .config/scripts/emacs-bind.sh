#!/bin/sh

if [ "$(pidof emacs-snapshot)" ] || [ "$(pidof emacs24)" ] ;
then
    # emacs --daemon;
    emacsclient -c
    # emacsclient -c;
else
    emacs-snapshot --daemon
    emacs24 --daemon
    emacsclient -c
fi
