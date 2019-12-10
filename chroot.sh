#!/bin/bash
ROOT=$1

passwd
useradd -mg users -G wheel,storage,power -s /usr/bin/zsh thnikk
passwd thnikk
visudo
echo "archvm" > /etc/hostname
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
locale-gen 
export LANG=en_US.UTF-8
ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc --utc

systemctl enable NetworkManager
systemctl enable dhcpcd
echo "i3" > /home/thnikk/.xinitrc

bootctl --path=/boot install

touch /boot/loader/loader.conf
echo "default arch" > /boot/loader/loader.conf
echo "timeout 1" >> /boot/loader/loader.conf
echo "editor 0" >> /boot/loader/loader.conf

touch /boot/loader/entries/arch.conf
echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options root=PARTUUID=" >> /boot/loader/entries/arch.conf
blkid -s PARTUUID -o value $ROOT | tr -d '\n' >> /boot/loader/entries/arch.conf
echo " rw" >> /boot/loader/entries/arch.conf

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../
git clone https://github.com/LukeSmithxyz/st.git
makepkg -si
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
