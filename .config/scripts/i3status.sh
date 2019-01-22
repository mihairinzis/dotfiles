#!/bin/bash

weather=$(python3 ~/.config/scripts/conky/openweathermap.py)
i3status | while :
do
    read status
    freemem=$(free -m | awk '/^Mem:/{print ($2-$7)*100/$2}')
    minutes=$(date +%M)
    fortune=$(fortune -o -n 80 -s | fold -w66 | tr '\n' ' ')
    if [[ "$minutes" = "00" ]]; then
        weather=$(python3 ~/.config/scripts/conky/openweathermap.py)
    fi
    echo " $fortune |  $weather |  $freemem | $status" || exit 1
done
