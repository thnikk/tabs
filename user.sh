#!/bin/bash
# Install paru
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
# Install aur packages
#paru -S --noconfirm polybar breeze-snow-cursor-theme autotiling shellcheck-bin picom-ibhagwan-git mpv-git flat-remix flat-remix-gtk
paru -S --noconfirm breeze-snow-cursor-theme autotiling shellcheck-bin mpv-git flat-remix flat-remix-gtk
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
chmod +x stow_all.sh
./stow_all.sh
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
