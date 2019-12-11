#!/bin/bash
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install aur packages
yay -S --no-confirm flat-remix polybar ttf-material-design-icons
# Install oh my zsh
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --unattended
# Create xinitrc
echo "exec bspwm" > /home/thnikk/.xinitrc
# Just in case
echo "#exec i3" >> /home/thnikk/.xinitrc
# Install dotfiles
git clone https://github.com/thnikk/dotfiles.git
cp -r dotfiles/. .
rm -rf dotfiles
