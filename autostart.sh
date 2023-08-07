#!/bin/bash

whiptail --title "Enable Services" --checklist --separate-output "Pick the ones you need:" 20 25 15 \
    "Redshift" "" off \
    "Syncthing" "" off \
    "Feh-Bing" "" off 2>results

while read choice
do
    case $choice in
        Redshit)
            systemctl --user enable redshift
            systemctl --user start redshift
            ;;
        Syncthing)
            systemctl --user enable syncthing
            systemctl --user start syncthing
            ;;
        Feh-Bing)
            systemctl --user enable feh-bing.service
            systemctl --user start feh-bing.service
            systemctl --user enable feh-bing.timer
            ;;
        *)
            ;;
    esac
done < results
