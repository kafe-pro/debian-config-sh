#!/usr/bin/env sh

# +manual
# +mullvad-browser
# https://mullvad.net/download/browser/linux
# ./start-mullvad-browser.desktop --register-app
# xdg-settings set default-web-browser start-mullvad-browser.desktop
# tor-browser
# https://torproject.org
# +veracrypy
# https://veracrypt.io/en/Downloads.html
# sudo apt install --no-install-recommends -y libfuse2t64
# sudo apt install --no-install-recommends -y libgtk2.0-bin

# +docker-openwebui
#docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
# +docker searxng
#mkdir -p ./searxng/config/ ./searxng/data/
#docker pull docker.io/searxng/searxng:latest
#docker run --name searxng -d \
#-p 8888:8080 \
#-v "./config/:/etc/searxng/" \
#-v "./data/:/var/cache/searxng/" \
#--restart always \
#docker.io/searxng/searxng:latest

# +distrobox
# distrobox enter arch
# sudo pacman -S extra/blender extra/torbrowser-launcher extra/veracrypt extra/yt-dlp
# distrobox-export --app extra/blender
# distrobox-export --app extra/torbrowser-launcher
# distrobox-export --app veracrypt
# exit
