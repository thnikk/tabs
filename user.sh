#!/bin/bash
# Install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
# Install aur packages
paru -S --noconfirm polybar breeze-snow-cursor-theme autotiling lf shellcheck-bin picom-ibhagwan-git
# Install through pip to reduce dependencies
pip install fontawesome

# Replace all references to Operator Mono with Firacode
#sed -i 's/Operator Mono Medium/Fira Code Medium/g' polybar/.config/polybar/config
#sed -i 's/Operator Mono Lig Book/Fira Code Medium/g' kitty/.config/kitty/kitty.conf
#sed -i 's/Operator Mono Book/Fira Code Medium/g' i3/.config/i3/config
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget "https://thnikk.moe/fonts/FuturaBookBT.ttf"
wget "https://thnikk.moe/fonts/Gotham-Rounded-Book.ttf"
wget "https://thnikk.moe/fonts/Gotham-Rounded-Light.ttf"
wget "https://thnikk.moe/fonts/Operator Mono Book Italic.otf"
wget "https://thnikk.moe/fonts/OperatorMonoLig-Book.otf"
wget "https://thnikk.moe/fonts/Operator Mono Medium Regular.otf"

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
