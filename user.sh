#!/bin/bash
# Install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
# Install aur packages
paru -S --noconfirm polybar breeze-snow-cursor-theme autotiling lf shellcheck-bin
# Install dotfiles
cd ~
git clone --recursive https://github.com/thnikk/dotfiles.git .dot
cd .dot
# Replace all references to Operator Mono with Firacode
sed -i 's/Operator Mono Medium/Fira Code Medium/g' polybar/.config/polybar/config
sed -i 's/Operator Mono Lig Book/Fira Code Medium/g' kitty/.config/kitty/kitty.conf
sed -i 's/Operator Mono Book/Fira Code Medium/g' i3/.config/i3/config
# Stow all
chmod +x stowAll.sh
./stowAll.sh
# Return home
cd ~
# Cleanup
rm -rf paru
