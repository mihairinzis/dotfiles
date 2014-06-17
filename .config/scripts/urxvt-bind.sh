#!/bin/sh

if [ "$(pidof urxvtd)" ];
then
    # if [ !"$(ps ax | grep -w urxvtd | grep 'Z')" ]
    # then
    #     # we got a zombie urxvtd, start another one
    #     urxvtd -q -f -o;
    #     urxvtc -name "$1";
    #     return
    # fi
    urxvtc -name "$1" -depth 32 -bg rgba:3f00/3f00/3f00/dddd;
else
    urxvtd -q -f -o;
    urxvtc -name "$1" -depth 32 -bg rgba:3f00/3f00/3f00/dddd;
fi
