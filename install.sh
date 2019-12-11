#!/bin/bash

ROOT=/dev/vda3
SWAP=/dev/vda2
BOOT=/dev/vda1

echo "Formatting partitions."
mkfs.ext4 $ROOT
mkswap $SWAP
mkfs.fat -F32 $BOOT

echo "Mounting partitions."
mount $ROOT /mnt
mkdir /mnt/boot
mount $BOOT /mnt/boot
swapon $SWAP

echo "Installing system."
pacman -Sy --noconfirm archlinux-keyring
pacstrap /mnt base base-devel linux linux-firmware vim zsh dhcpcd xorg-server xorg xorg-xinit sudo noto-fonts git i3-gaps i3status dmenu feh unzip unrar tmux xclip mpd ncmpcpp networkmanager network-manager-applet
echo "Creating FS Table." 
rm /mnt/etc/fstab
genfstab -U -p /mnt >> /mnt/etc/fstab
echo "Copying install scripts to root fs and entering chroot."
echo "/dev/$DRIVE3" > /mnt/rootPart
cp chroot.sh /mnt && cp user.sh /mnt && arch-chroot /mnt bash chroot.sh
