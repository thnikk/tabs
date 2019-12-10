#!/bin/bash
ROOT=/dev/vda3

passwd
# PROMPT FOR USERNAME
echo "Please enter your desired username: "
read USER
useradd -mg users -G wheel,storage,power -s /usr/bin/zsh $USER 
passwd $USER
#visudo
sudo sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
# PROMPT FOR HOSTNAME
echo "Please enter your desired hostname for the machine: "
read HOSTNAME
echo "$HOSTNAME" > /etc/hostname
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
export LANG=en_US.UTF-8
locale-gen
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
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value $ROOT | tr -d '\n') rw" >> /boot/loader/entries/arch.conf

chmod +x /user.sh
su -c "/user.sh" - thnikk 
