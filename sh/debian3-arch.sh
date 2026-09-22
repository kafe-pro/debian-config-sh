#!/usr/bin/env sh

sudo pacman -S extra/blender extra/torbrowser-launcher extra/veracrypt extra/yt-dlp
distrobox-export --app extra/blender
distrobox-export --app extra/torbrowser-launcher
distrobox-export --app veracrypt
exit
