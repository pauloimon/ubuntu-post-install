#!/usr/bin/bash

# Update package list
sudo apt update

# Install utility packages from official repositories
sudo apt install -y \
    dconf-editor \
    fonts-jetbrains-mono \
    git \
    git-flow \
    gnome-sushi \
    gnome-tweaks \
    piper \
    tilix

# Bring back cedilla on US Intl. Alt. keyboards
echo -e "\n# ---\n# cedilla module\n# ---" >> ~/.profile
echo "GTK_IM_MODULE=cedilla" >> ~/.profile

# Install asdf CLI app from GitHub repository
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch master
echo -e "\n# ---\n# asdf\n# ---" >> ~/.bashrc
echo ". \"\$HOME/.asdf/asdf.sh\"" >> ~/.bashrc
echo ". \"\$HOME/.asdf/completions/asdf.bash\"" >> ~/.bashrc

sudo snap install \
    beekeeper-studio \
    bitwarden \
    brave \
    code \
    spotify

# Upgrade system and remove unused packages
sudo apt dist-upgrade -y
sudo apt autoclean && sudo apt autoremove -y

# Enable system firewall
sudo ufw enable

# Customize Gnome Shell settings
gsettings set org.gnome.desktop.background picture-options "none"
gsettings set org.gnome.desktop.background primary-color "#000000"
gsettings set org.gnome.desktop.default-applications.terminal exec "tilix"
gsettings set org.gnome.desktop.interface clock-show-weekday "true"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.desktop.interface locate-pointer "true"
gsettings set org.gnome.desktop.interface show-battery-percentage "true"
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll "true"
gsettings set org.gnome.desktop.privacy remember-recent-files "false"
gsettings set org.gnome.desktop.privacy remove-old-temp-files "true"
gsettings set org.gnome.desktop.privacy remove-old-trash-files "true"
gsettings set org.gnome.desktop.screensaver lock-enabled "false"
gsettings set org.gnome.desktop.search-providers disable-external "true"
gsettings set org.gnome.desktop.session idle-delay "0"
gsettings set org.gnome.desktop.wm.keybindings switch-panels "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward "[]"
gsettings set org.gnome.gedit.preferences.editor scheme "Yaru-dark"
gsettings set org.gnome.mutter center-new-windows "true"
gsettings set org.gnome.nautilus.preferences default-folder-viewer "list-view"
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover "true"
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action "nothing"
gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action "nothing"
gsettings set org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery "false"
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type "nothing"
gsettings set org.gnome.shell.extensions.dash-to-dock click-action "minimize"
gsettings set org.gnome.shell.extensions.ding show-home "false"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Control><Alt>Tab']"
gsettings set org.gtk.Settings.FileChooser sort-directories-first "true"

# Customize Tilix settings
gsettings set com.gexperts.Tilix.Settings terminal-title-style "none"

echo "Done!"
