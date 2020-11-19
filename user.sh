#!/bin/bash
# Install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
# Install aur packages
paru -S --noconfirm polybar breeze-snow-cursor-theme autotiling shellcheck-bin picom-ibhagwan-git mpv-git flat-remix
# Install through pip to reduce dependencies
pip install fontawesome

# Download fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget "https://thnikk.moe/files/fonts.zip"
unzip fonts.zip
fc-cache -f

# Install dotfiles
cd ~
git clone --recursive https://github.com/thnikk/dotfiles.git .dot
cd .dot
# Stow all
chmod +x stowAll.sh
./stowAll.sh
# Return home
cd ~
# Cleanup
rm -rf paru

# Make some folders
mkdir -p ~/.cache
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Videos
mkdir -p ~/Documents
mkdir -p ~/.local/bin

# Add anthy to engines
gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng', 'anthy']"
# (this one may be unnecessary)
gsettings set org.freedesktop.ibus.general engines-order "['xkb:us::eng', 'anthy']"
# Remove keybind
gsettings set org.freedesktop.ibus.general.hotkey next-engine "[]"
# Change default input mode to hiragana
gsettings set org.freedesktop.ibus.engine.anthy.common input-mode 0
# Disable tray icon (preferences still accessible as application)
gsettings set org.freedesktop.ibus.panel show-icon-on-systray false
