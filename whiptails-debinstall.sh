#!/bin/bash

function install_package {
    apt-get --force-yes --yes install $package_string
}

function install_packages {
    for package in ${packages[@]} ; do
        package_string="$package_string $package"
    done
    package_string=`echo $package_string | tr -d '\"'`
    install_package $package_string
}

function read_packages {
    while read -r line; do
        [[ "$line" =~ ^#.*$ ]] && continue
        for package in $line ; do
            packages+=($package)
        done
    done < "$packages_file"
}

function package_installed {
    return $(dpkg-query -W -f='${Status}' \
        $1 2>/dev/null | grep -c "ok installed")
}

function whip_packages {
    whipped=()
    for package in ${packages[@]} ; do
        if package_installed $package; then
            installed="OFF"
        else
            installed="ON"
        fi
        whipped+=("$package" "" "$installed")
    done
    packages=()
    packages=$(whiptail \
        --title "Packages" \
        --checklist "Pick the ones you need:" \
        20 45 15 \
        "${whipped[@]}" \
        3>&1 1>&2 2>&3)
}

function deb_install {
    if [[ $EUID -ne 0 ]]; then
        echo "You must be a root user" 2>&1
        exit 1
    else
        packages_file="./packages"
        if [ ! -f $packages_file ]; then
            echo "Packages file is not present"
            exit 1
        fi
        # apt-get update
        packages=()
        read_packages $packages_file $packages
        whip_packages $packages
        if [ $? -eq 0 ] ; then
            install_packages $packages
        fi
    fi
}

deb_install
