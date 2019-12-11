
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S st-luke-git flat-remix polybar ttf-material-design-icons
touch /home/thnikk/.xinitrc
echo "exec i3" > /home/thnikk/.xinitrc
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
