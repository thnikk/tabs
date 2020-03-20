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
sed -i 's/Operator Mono Medium/Fira Code Medium/g' dotfiles/.config/polybar/config
sed -i 's/Operator Mono Medium/Fira Code Medium/g' dotfiles/.config/kitty/kitty.conf
sed -i 's/Operator Mono Book/Fira Code Medium/g' dotfiles/.config/i3/config
cp -r dotfiles/. .
# Cleanup
rm -rf dotfiles yay
