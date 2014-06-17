#/bin/bash

if [ "$(pidof mocp)" ]; then
    state=`exec mocp -Q %state`;
    if [ "$state" = "STOP" ]; then
        mocp -p;
    else
        mocp -G;
    fi
else
    mocp --server;
    mocp -p;
fi
