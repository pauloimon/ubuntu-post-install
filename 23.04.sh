#!/usr/bin/bash

# Remove pre-installed Firefox app
sudo snap remove firefox
rm -rf ~/snap/firefox

# Update package list
sudo apt update

# Install utility packages from official repositories
sudo apt install -y \
    chrome-gnome-shell \
    curl \
    dconf-editor \
    fonts-firacode \
    fonts-jetbrains-mono \
    git \
    git-flow \
    gnome-shell-extension-ubuntu-tiling-assistant \
    gnome-sushi \
    gnome-tweaks \
    nautilus-image-converter \
    piper \
    tilix \
    wget

# Install asdf CLI app from GitHub repository
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch master
echo -e "\n# ---\n# asdf\n# ---" >> ~/.bashrc
echo ". \"\$HOME/.asdf/asdf.sh\"" >> ~/.bashrc
echo ". \"\$HOME/.asdf/completions/asdf.bash\"" >> ~/.bashrc

# Install Beekeeper Studio app from third-party repository
wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo apt-key add -
echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list
sudo apt update && sudo apt install -y beekeeper-studio

# Install Bitwarden app from GitHub releases
wget -q "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb" -O /tmp/bitwarden.deb
sudo apt install -y /tmp/bitwarden.deb

# Install Brave app from third-party repository
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo apt install -y brave-browser

# Install Discord app from official website
wget -q "https://discord.com/api/download?platform=linux&format=deb" -O /tmp/discord.deb
sudo apt install -y /tmp/discord.deb

# Install NordVPN CLI app from third-party repository
wget -q "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb" -O /tmp/nordvpn-repository.deb
sudo apt install -y /tmp/nordvpn-repository.deb
sudo apt update && sudo apt install -y nordvpn

# Install ONLYOFFICE app from official website
wget -q "https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb" -O /tmp/onlyoffice.deb
sudo apt install -y /tmp/onlyoffice.deb

# Install Raspberry Pi Imager app from official website
wget -q "https://downloads.raspberrypi.org/imager/imager_latest_amd64.deb" -O /tmp/raspberry-pi-imager.deb
sudo apt install -y /tmp/raspberry-pi-imager.deb

# Install Spotify app from third-party repository
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install -y spotify-client

# Install Ulauncher app from third-party repository
sudo add-apt-repository -y ppa:agornostal/ulauncher
sudo apt install -y ulauncher

# Install Visual Studio Code app from official website
wget -q "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O /tmp/code.deb
sudo apt install -y /tmp/code.deb

# Install Zoom app from official website
wget -q "https://zoom.us/client/5.15.2.4260/zoom_amd64.deb" -O /tmp/zoom.deb
sudo apt install -y /tmp/zoom.deb

# Upgrade system and remove unused packages
sudo apt dist-upgrade -y
sudo apt autoclean && sudo apt autoremove -y

# Enable system firewall
sudo ufw enable

# Disable connectivity checking
sudo sed -i "s/^\.set\.enabled=true$/.set.enabled=false/" /var/lib/NetworkManager/NetworkManager-intern.conf
sudo service NetworkManager restart

# Configure NordVPN
nordvpn set analytics disabled
nordvpn set notify enabled
nordvpn set threatprotectionlite enabled
nordvpn whitelist add subnet 192.168.100.0/24

# Customize Gnome Shell settings
gsettings set org.gnome.desktop.background picture-options "none"
gsettings set org.gnome.desktop.background primary-color "#000000"
gsettings set org.gnome.desktop.default-applications.terminal exec "tilix"
gsettings set org.gnome.desktop.interface clock-show-weekday "true"
gsettings set org.gnome.desktop.interface locate-pointer "true"
gsettings set org.gnome.desktop.interface show-battery-percentage "true"
gsettings set org.gnome.desktop.wm.keybindings switch-panels "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward "[]"
gsettings set org.gnome.mutter center-new-windows "true"
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover "true"
gsettings set org.gnome.shell.extensions.dash-to-dock click-action "minimize"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Control><Alt>Tab']"

# Customize Tilix settings
gsettings set com.gexperts.Tilix.Settings terminal-title-style "none"

echo "Done!"
