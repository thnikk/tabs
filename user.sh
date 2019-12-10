git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../
git clone https://github.com/LukeSmithxyz/st.git
makepkg -si
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
touch /home/thnikk/.xinitrc
echo "i3" > /home/thnikk/.xinitrc
