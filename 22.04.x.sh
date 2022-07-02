#!/usr/bin/bash

# ---
# DECLARATIONS
# ---

function get_latest_release_url_from_github() {
    curl -s "https://api.github.com/repos/${1}/releases/latest" | \
        jq '.assets[].browser_download_url | match("^(.*)(amd64)(.*).deb$") | .string' | \
        tr -d '"'
}

function add_external_repository() {
    wget -q -O - "${1}" | sudo apt-key add -

    echo "${2}" | sudo tee "/etc/apt/sources.list.d/${3}"
}

# ---
# INITIALIZE SCRIPT STEPS
# ---

cd "${HOME}/Downloads"

# ---
# 1) Install the dependencies
# ---
sudo apt update && sudo apt install -y jq
# ---

# ---
# 2) Setup external repositories
# ---
add_external_repository "https://deb.beekeeperstudio.io/beekeeper.key" \
    "deb https://deb.beekeeperstudio.io stable main" \
    beekeeper-studio-app.list

add_external_repository "https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg" \
    "deb http://repository.spotify.com stable non-free" \
    spotify.list
# ---

# ---
# 3) Setup PPAs
# ---
# TODO: Add PPAs here
# ---

# ---
# 4) Manually download additional packages
# ---
wget -q $(get_latest_release_url_from_github "bitwarden/clients") -O ./bitwarden.deb
wget -q "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O ./code.deb
wget -q "https://discord.com/api/download?platform=linux&format=deb" -O ./discord.deb
wget -q "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ./google-chrome.deb
# ---

# ---
# 5) Install additional packages
# ---
sudo apt install -y \
    ./bitwarden.deb \
    ./code.deb \
    ./discord.deb \
    ./google-chrome.deb \
    beekeeper-studio \
    chrome-gnome-shell \
    dconf-editor \
    fonts-firacode \
    git-flow \
    gnome-sushi \
    gnome-tweaks \
    piper \
    spotify-client
# ---

# ---
# 6) Remove Firefox
# ---
# TODO: Add commands to remove Firefox here
# ---

# ---
# 7) Remove Snap support and preinstalled snaps
# ---
# TODO: Add commands to remove Snap support and preinstalled snaps here
# ---

# ---
# 8) Update system
# ---
sudo apt update && sudo apt dist-upgrade -y
# ---

# ---
# 9) Clean and remove unused packages remaing
# ---
sudo apt autoclean && sudo apt autoremove -y
# ---

# ---
# 10) Enable the firewall
# ---
sudo ufw enable
# ---

echo "Done!"
