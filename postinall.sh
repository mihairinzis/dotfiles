#!/bin/bash

whiptail --title "Packages" --checklist --separate-output "Pick the ones you need:" 20 25 15 \
         "Chrome" "" off \
         "Firefox" "" off \
         "Youtube-Dl" "" off \
         "Autorandr" "" off \
         "Syncthing" "" off \
         "Docker" "" off \
         "Prezto" "" off \
         "Prelude" "" off \
         "NodeJs" "" off \
         "Yarn" "" off \
         "Flatpack" "" off 2>results

to_install=()
while read choice
do
    case $choice in
        Chrome)
            curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            echo "deb https://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list
            to_install+=("google-chrome-stable")
            ;;
        Firefox)
            wget -O FirefoxDev.tar.bz2 'https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US'
            tar xvjf FirefoxDev.tar.bz2 -C /opt
            rm FirefoxDev.tar.bz2
            sudo ln -fs /opt/firefox/firefox /usr/bin/firefox
            ;;
        Youtube-Dl)
            sudo apt --force-yes --yes install python3-pip
            sudo pip3 install --upgrade youtube_dl
            ;;
        Autorandr)
            sudo apt --force-yes --yes install python3-pip
            sudo pip3 install --upgrade autorandr
            ;;
        Syncthing)
            curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
            echo "deb https://apt.syncthing.net/ syncthing stable" | tee /etc/apt/sources.list.d/syncthing.list
            to_install+=("syncthing")
            ;;
        Docker)
            curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
            sudo add-apt-repository \
                "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
                $(lsb_release -cs) \
                stable"
            to_install+=("apt-transport-https ca-certificates curl software-properties-common docker-ce")
            ;;
        Prezto)
            zsh
            git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
            setopt EXTENDED_GLOB
            for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md; do
                ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
            done
            chsh -s /bin/zsh
            ;;
        Prelude)
            export PRELUDE_URL="https://github.com/mihairinzis/prelude.git"
            curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh
            ;;
        NodeJs)
            curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
            to_install+=("nodejs")
            ;;
        Yarn)
            curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo sudo apt-key add -
            echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
            sudo apt update && sudo apt --force-yes --yes install yarn
            sudo yarn global add tern js-beautify eslint typescript tslint ts-server
            ;;
        Flatpack)
            sudo apt --force-yes --yes install flatpack
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak install flathub org.gnu.emacs
            ;;
        *)
            ;;
    esac
done < results

if [ ${#to_install[@]} -gt 0 ]; then
    sudo apt update
    for package in ${to_install[@]} ; do
        package_string="$package_string $package"
    done
    package_string=`echo $package_string | tr -d '\"'`
    sudo apt --force-yes --yes --ignore-missing install $package_string
fi
