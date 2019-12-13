#!/bin/bash
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install aur packages
yay -S flat-remix polybar ttf-material-design-icons antigen-git
# Install dotfiles
git clone https://github.com/thnikk/dotfiles.git
rm -rf dotfiles/.git
cp -r dotfiles/. .
# Enable mpd
systemctl --user enable mpd
