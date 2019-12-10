
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S st-luke-git
touch /home/thnikk/.xinitrc
echo "i3" > /home/thnikk/.xinitrc
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
