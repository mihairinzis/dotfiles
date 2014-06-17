#!/bin/bash
# colorize_cpu.sh

COOL=65
WARM=80

if [[ $1 < $COOL ]] then
    echo "\${color5}"$1    # COOL
elif [[ $1 > $WARM ]] then
    echo "\${color6}"$1  # HOT
else
    echo "\${color8}"$1                        # WARM
fi

exit 0
