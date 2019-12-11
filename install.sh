#!/bin/bash
lsblk
echo "Enter drive selection."
read DRIVE

ROOT=/dev/$(echo $DRIVE)3
SWAP=/dev/$(echo $DRIVE)2
BOOT=/dev/$(echo $DRIVE)1

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
pacstrap /mnt base base-devel linux linux-firmware neovim zsh dhcpcd xorg-server xorg xorg-xinit sudo noto-fonts git feh unzip unrar tmux xclip mpd ncmpcpp networkmanager network-manager-applet arc-gtk-theme adobe-source-han-sans-otc-fonts i3-gaps bspwm sxhkd rofi dunst udiskie xorg-xsetroot xorg-xinput arandr ttf-fira-code nautilus kitty
echo "Creating FS Table."
rm /mnt/etc/fstab
genfstab -U -p /mnt >> /mnt/etc/fstab
echo "Copying install scripts to root fs and entering chroot."
echo "$ROOT" > /mnt/rootPart
cp chroot.sh /mnt && cp user.sh /mnt && arch-chroot /mnt bash chroot.sh
