#!/bin/bash

whiptail --title "Enable Services" --checklist --separate-output "Pick the ones you need:" 20 25 15 \
    "Emacs" "" off \
    "Redshift" "" off \
    "Syncthing" "" off \
    "Autorandr" "" off \
    "Syncthing" "" off \
    "Dunst" "" off 2>results

while read choice
do
    case $choice in
        Emacs)
            systemctl --user enable emacs
            systemctl --user start emacs
            ;;
        Redshit)
            systemctl --user enable redshift
            systemctl --user start redshift
            ;;
        Syncthing)
            systemctl --user enable syncthing
            systemctl --user start syncthing
            ;;
        Dunst)
            systemctl --user enable dunst
            systemctl --user start dunst
            ;;
        *)
            ;;
    esac
done < results
