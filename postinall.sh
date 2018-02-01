#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "You must be a root user" 2>&1
    exit 1
fi


whiptail --title "Packages" --checklist --separate-output "Pick the ones you need:" 20 25 15 \
    "Chrome" "" off \
    "Firefox" "" off \
    "Youtube-Dl" "" off \
    "Syncthing" "" off \
    "Docker" "" off \
    "Fish" "" off \
    "NodeJs" "" off 2>results

to_install=()
while read choice
do
    case $choice in
        Chrome)
            curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
            echo "deb https://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list
            to_install+=("google-chrome-stable")
            ;;
        Firefox)
            wget -O FirefoxDev.tar.bz2 'https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US'
            tar xvjf FirefoxDev.tar.bz2 -C /opt
            rm FirefoxDev.tar.bz2
            ln -s /opt/firefox/firefox /usr/bin/firefox
            ;;
        Youtube-Dl)
            curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
            chmod a+rx /usr/local/bin/youtube-dl
            ;;
        Syncthing)
            curl -s https://syncthing.net/release-key.txt | apt-key add -
            echo "deb https://apt.syncthing.net/ syncthing stable" | tee /etc/apt/sources.list.d/syncthing.list
            to_install+=("syncthing")
            ;;
        Docker)
            curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
            add-apt-repository \
                "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
                $(lsb_release -cs) \
                stable"
            to_install+=("apt-transport-https ca-certificates curl software-properties-common docker-ce")
            ;;
        Fish)
            apt --force-yes --yes install fish
            chsh -s `which fish`
            curl -L https://get.oh-my.fish | fish
            ;;
        NodeJs)
            curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
            to_install+=("nodejs")
            ;;
        *)
            ;;
    esac
done < results

if [ ${#to_install[@]} -gt 0 ]; then
    apt update
    for package in ${to_install[@]} ; do
        package_string="$package_string $package"
    done
    package_string=`echo $package_string | tr -d '\"'`
    apt --force-yes --yes --ignore-missing install $package_string
fi
