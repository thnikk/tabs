#!/bin/bash
# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Install aur packages
yay -S --noconfirm polybar ttf-material-design-icons i3lock-fancy-rapid-git breeze-snow-cursor-theme autotiling gohufont lf
# Install dotfiles
cd ~
git clone https://github.com/thnikk/dotfiles.git .dot
cd .dot
# Replace all references to Operator Mono with Firacode
sed -i 's/Operator Mono Book/Fira Code Medium/g' polybar/.config/polybar/config
sed -i 's/Operator Mono Lig Book/Fira Code Medium/g' kitty/.config/kitty/kitty.conf
sed -i 's/Operator Mono Book/Fira Code Medium/g' i3/.config/i3/config
# Stow all
chmod +x stowAll.sh
./stowAll.sh
# Return home
cd ~
# Cleanup
rm -rf yay
