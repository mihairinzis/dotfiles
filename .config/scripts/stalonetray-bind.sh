#!/bin/sh

if [ "$(pidof stalonetray)" ]
then
    killall stalonetray
else
    stalonetray
    # stalonetray --background '#3f3f3f' --icon-size 18 --transparent --sticky &
fi
