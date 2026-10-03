#!/usr/bin/env sh

sudo pacman -S extra/alsa-lib extra/blender extra/torbrowser-launcher extra/veracrypt extra/yt-dlp
distrobox-export --app extra/blender
distrobox-export --app veracrypt
distrobox-export --app torbrowser-launcher
exit
exit