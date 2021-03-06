#!/bin/bash

# Credits go to moljac024 (https://github.com/moljac024)
# I added zenburn2, below option and terminu font

#-------------------------\
# Dmenu run launcher, by moljac024
#-------------------------
# Configuration:
#-------------------------

if [[ "$#" > 0 ]]; then
    THEME="$1"
else
    THEME="zenburn2"
fi

case "$THEME" in
    "solarized")
        # Solarized colors:
        NORMAL_BACKGROUND='#fdf6e3'
        NORMAL_FOREGROUND='#657b83'
        SELECTED_BACKGROUND='#eee8d5'
        SELECTED_FOREGROUND='#657b83'
        ;;
    "zenburn")
        # Zenburn colors:
        NORMAL_BACKGROUND='#3f3f3f'
        NORMAL_FOREGROUND='#e5e5e5'
        SELECTED_BACKGROUND='#7f9f7f'
        SELECTED_FOREGROUND='#e5e5e5'
        ;;
    "zenburn2")
        # Zenburn colors:
        NORMAL_BACKGROUND='#3f3f3f'
        NORMAL_FOREGROUND='#dcdccc'
        SELECTED_BACKGROUND='#dcdccc'
        SELECTED_FOREGROUND='#151617'
        ;;
    "ubuntu")
        # Ubuntu colors:
        NORMAL_BACKGROUND='#3c3637'
        NORMAL_FOREGROUND='#e5e5e5'
        SELECTED_BACKGROUND='#e96e3b'
        SELECTED_FOREGROUND='#e5e5e5'
        ;;
    "default")
        # Ubuntu colors:
        NORMAL_BACKGROUND='#000000'
        NORMAL_FOREGROUND='#e5e5e5'
        SELECTED_BACKGROUND='#285577'
        SELECTED_FOREGROUND='#e5e5e5'
        ;;
    *)
        exit 1
        ;;
esac

# Run dmenu:
dmenu_run -i -b -p "Run:" \
    -nb $NORMAL_BACKGROUND \
    -nf $NORMAL_FOREGROUND \
    -sb $SELECTED_BACKGROUND \
    -sf $SELECTED_FOREGROUND \
    -fn '-xos4-terminus-medium-r-*-*-18-*'
# -fn '-*-*-*-r-*-*-18-*-*-*-*-*-*-*'
