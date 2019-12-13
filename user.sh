#!/bin/bash
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install aur packages
yay -S flat-remix polybar ttf-material-design-icons antigen-git python-i3-py
# Create xinitrc
echo "exec i3
#exec bspwm" > /home/thnikk/.xinitrc
# Install dotfiles
git clone https://github.com/olemartinorg/i3-alternating-layout.git
mkdir -p ~/.local/bin
cp i3-alternating-layout/alternating_layouts.py ~/.local/bin
rm -rf i3-alternating-layout
git clone https://github.com/thnikk/dotfiles.git
rm -rf dotfiles/.git
cp -r dotfiles/. .
# Enable mpd
systemctl --user enable mpd
