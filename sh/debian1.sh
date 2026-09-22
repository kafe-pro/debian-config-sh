#!/usr/bin/env sh

# config dark-theme
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# enable flatpak
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# enable ufw
sudo apt install --no-install-recommends -y ufw
sudo ufw enable
sudo ufw allow 53317

