#!/bin/bash
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install aur packages
yay -S flat-remix polybar ttf-material-design-icons oh-my-zsh
# Create xinitrc
touch /home/thnikk/.xinitrc
echo "exec bspwm" > /home/thnikk/.xinitrc
# Just in case
echo "#exec i3" >> /home/thnikk/.xinitrc
# Install dotfiles
git clone https://github.com/thnikk/dotfiles.git
cp -r dotfiles/. .
