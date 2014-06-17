#!/bin/bash

# disable bell
xset -b
# eval `/usr/bin/ssh-agent`

# merge settings
xrdb -merge $HOME/.Xresources
#xmodmap ~/.Xmodmap

# set keymap
# setxkbmap -layout gb -option ctrl:nocaps

# start xscreensaver
/usr/bin/xscreensaver -no-splash &

# turn CapsLock into Control
#xmodmap -e "clear lock"; xmodmap -e "keycode 66 = Control_R"; xmodmap -e "add Control = Control_R"
exec /usr/bin/setxkbmap -option caps:ctrl_modifier &

# set wallpaper
# feh --bg-scale ~/pics/velvet-noise.jgp
# sh ~/.fehbg &
nitrogen --restore &

# start redshift
# redshift -l 41.8:-88.0 &

# start conky
(sleep 5 && conky) &

# start emacs daemon
emacs-snapshot --daemon &

# start urxvt daemon
urxvtd -q -f -o &

#start pytyle3
# (sleep 5 && pytyle3) &

# start clipboard manager
clipit &

# start unclutter
unclutter -idle 5 &

# start composite manager
# compton --config ~/.compton.conf -b

# start gnome policykit and keyring
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# start nm-applet
# (sleep 3 && /usr/bin/nm-applet --sm-disable) &

#start udisks-glue
#udisks-glue &

exec ck-launch-session dbus-launch openbox-session
#exec ck-launch-session dbus-launch openbox
#exec openbox
