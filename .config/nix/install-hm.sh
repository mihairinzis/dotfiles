#! /bin/bash

export NIX_CONFIG="experimental-features = nix-command flakes"
sudo nix-channel --add https://github.com/nix-community/home-manager/master home-manager;
sudo nix-channel --update;
nix-shell '<home-manager>' -A install
cp /etc/nixos/hardware-configuration.nix .

sudo nixos-rebuild --upgrade switch --flake .#rmi
home-manager switch --flake .#mihai

# npm set prefix ~/.npm-global
