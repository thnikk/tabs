#!/bin/bash
DRIVE=$1

ROOT=/dev/$DRIVE3
SWAP=/dev/$DRIVE2
BOOT=/dev/$DRIVE1

mkfs.ext4 $ROOT
mkswap $SWAP
mkfs.fat -F32 $BOOT

mount $ROOT /mnt
mkdir /mnt/boot
mount $BOOT /mnt/boot
swapon $SWAP

pacman -Sy --noconfirm archlinux-keyring
pacstrap /mnt base base-devel linux linux-firmware vim zsh dhcpcd xorg-server xorg xorg-xinit sudo noto-fonts git i3-gaps i3status dmenu feh unzip unrar tmux xclip mpd ncmpcpp networkmanager network-manager-applet
genfstab -U -p /mnt >> /mnt/etc/fstab
cp chroot.sh /mnt/chroot.sh && arch-chroot /mnt bash "chroot.sh $ROOT" && rm /mnt/chroot.sh

umount $ROOT $BOOT
