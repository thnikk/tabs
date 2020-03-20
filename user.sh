#!/bin/bash
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install aur packages
yay -S flat-remix flat-remix-gtk polybar ttf-material-design-icons antigen-git mimeo xdg-utils-mimeo
# Install dotfiles
cd ~
git clone https://github.com/thnikk/dotfiles.git
rm -rf dotfiles/.git
cp -r dotfiles/. .
# Not working as system needs to reboot before services can be enabled
#systemctl --user enable mpd.service
