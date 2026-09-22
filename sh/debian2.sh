#!/usr/bin/env sh

# install mullvad browser
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable stable main" | sudo tee /etc/apt/sources.list.d/mullvad.list
sudo apt update
sudo apt install mullvad-browser

# install apt
sudo apt install --no-install-recommends -y alacritty
sudo apt install --no-install-recommends -y audacity
sudo apt install --no-install-recommends -y calc
sudo apt install --no-install-recommends -y distrobox
sudo apt install --no-install-recommends -y docker-cli
sudo apt install --no-install-recommends -y docker-compose
sudo apt install --no-install-recommends -y docker.io
sudo apt install --no-install-recommends -y dvipng
sudo apt install --no-install-recommends -y emacs
sudo apt install --no-install-recommends -y feh
sudo apt install --no-install-recommends -y ffmpeg
sudo apt install --no-install-recommends -y firefox-esr
sudo apt install --no-install-recommends -y fish
sudo apt install --no-install-recommends -y git
sudo apt install --no-install-recommends -y gnome-video-trimmer
sudo apt install --no-install-recommends -y imagemagick
sudo apt install --no-install-recommends -y metadata-cleaner
sudo apt install --no-install-recommends -y micro
sudo apt install --no-install-recommends -y mpv
sudo apt install --no-install-recommends -y ripgrep
sudo apt install --no-install-recommends -y syncthing
sudo apt install --no-install-recommends -y texlive-formats-extra
sudo apt install --no-install-recommends -y yt-dlp
sudo apt install --no-install-recommends -y wget
sudo apt install --no-install-recommends -y wl-clipboard

# install flatpak
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub io.frama.tractor.carburetor -y
flatpak install flathub io.freetubeapp.FreeTube -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub org.kde.kdenlive -y
flatpak install flathub org.keepassxc.KeePassXC -y
flatpak install flathub org.libreoffice.LibreOffice -y
flatpak install flathub io.gitlab.librewolf-community -y
flatpak install flathub org.localsend.localsend_app -y
flatpak install flathub dev.ters.LocalTranslate -y
flatpak install flathub org.onionshare.OnionShare -y
flatpak install flathub org.upscayl.Upscayl -y

# enable syncthing on boot
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

# font nerdfont
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
cd ~/

# font font-monospace
mkdir -p ~/.config/fontconfig/conf.d/
echo "<?xml version=\"1.0\"?>
<!DOCTYPE fontconfig SYSTEM \"fonts.dtd\">
<fontconfig>
 <alias>
   <family>sans-serif</family>
   <prefer>
     <family>Noto Sans</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
     <family>DejaVu Sans</family>
   </prefer> 
 </alias>

 <alias>
   <family>serif</family>
   <prefer>
     <family>Noto Serif</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
     <family>DejaVu Serif</family>
   </prefer>
 </alias>

 <alias>
  <family>monospace</family>
  <prefer>
    <family>Noto Mono</family>
    <family>Noto Color Emoji</family>
    <family>Noto Emoji</family>
   </prefer>
 </alias>
</fontconfig>" > /home/$USER/.config/fontconfig/conf.d/01-emoji.conf

# install doom-emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync -u

# config alias-fish
mkdir ~/.config/fish
echo "
fish
" >> ~/.bashrc
echo "
# ALIAS - DISTROBOX
alias arch=\"distrobox enter arch\"

# ALIAS - DOOM
alias doom=\"~/.config/emacs/bin/doom\"
alias doom-run=\"~/.config/emacs/bin/doom run --no-window-system\"
alias doom-sync=\"~/.config/emacs/bin/doom sync\"
alias doom-doctor=\"~/.config/emacs/bin/doom doctor\"

# ALIAS - MPV
alias mpv-yt480p=\"mpv --ytdl-format='bv[height<=720]+ba/b[height<=720]'\"

# ALIAS - OLLAMA
alias ollama=\"docker exec -it ollama ollama\"

# ALIAS - UPDATE
alias update=\"sudo apt update ;; distrobox-upgrade --all ;; sudo apt upgrade -y ;; flatpak update -y\"

# ALIAS - YT-DLP
alias yt-dlp-a.mp3=\"yt-dlp --extract-audio --audio-format mp3 --audio-quality 0\"
alias yt-dlp-a.mp3+date=\"yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 -o '%(upload_date>%Y-%m-%d)s %(title)+.100U [%(id)s]'\"
alias yt-dlp-a.mp3+last10=\"yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 -o '%(upload_date>%Y-%m-%d)s %(title)+.100U [%(id)s]' --playlist-items '1-10'\"
alias yt-dlp-a.mp3+last50=\"yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 -o '%(upload_date>%Y-%m-%d)s %(title)+.100U [%(id)s]' --playlist-items '1-50'\"
alias yt-dlp-plmp3=\"yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 -o '%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'\"
alias yt-dlp-plmp4=\"yt-dlp -f 'bv[height<=720]+ba/b[height<=720]' -o '%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'\"
alias yt-dlp-thumb=\"yt-dlp --write-thumbnail --skip-download\"
alias yt-dlp-v720p=\"yt-dlp -f 'bv[height<=720]+ba/b[height<=720]'\"
alias yt-dlp-v720p+date=\"yt-dlp -f 'bv[height<=720]+ba/b[height<=720]' -o '%(upload_date>%Y-%m-%d)s %(title)+.100U [%(id)s]'\"
alias yt-dlp-v360p=\"yt-dlp -f 'bv[height<=360]+ba/b[height<=360]'\"
alias yt-dlp-v360p+date=\"yt-dlp -f 'bv[height<=360]+ba/b[height<=360]' -o '%(upload_date>%Y-%m-%d)s %(title)+.100U [%(id)s]'\"

# EXPORT - TEXT EDITOR
export EDITOR='micro'

# FISH - WITHOUT INITIATION MESSAGE
set fish_greeting
" > ~/.config/fish/config.fish

# config mpv
mkdir ~/.config/mpv
echo "
demuxer-max-bytes=1000000KiB
keep-open
" > ~/.config/mpv/mpv.conf

# config docker
sudo systemctl enable --now docker docker.socket containerd
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# install docker-ollama
docker pull ollama/ollama
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama --restart always ollama/ollama

# config distrobox-arch
mkdir -p distrobox/arch
distrobox-create --pull --image archlinux --home ~/distrobox/arch/ --name arch
