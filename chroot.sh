#!/bin/bash
ROOT=$(cat /rootPart | tr -d '\n')

echo "Setting root password."
passwd
# PROMPT FOR USERNAME
echo "Please enter your desired username. "
read USER
useradd -mg users -G wheel,storage,power -s /usr/bin/zsh $USER
echo "Setting user password."
passwd $USER
#visudo
sudo sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
# PROMPT FOR HOSTNAME
echo "Please enter your desired hostname for the machine: "
read HOSTNAME
echo "$HOSTNAME" > /etc/hostname
echo "Setting locale."
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
export LANG=en_US.UTF-8
locale-gen
echo "Setting timezone."
ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc --utc

# Enable network services
echo "Enabling network services for first boot"
systemctl enable NetworkManager
systemctl enable dhcpcd

# Install systemd-boot
bootctl --path=/boot install

# Overwrite file if it exists and append other lines
echo "default arch" > /boot/loader/loader.conf
echo "timeout 1" >> /boot/loader/loader.conf
echo "editor 0" >> /boot/loader/loader.conf

# Overwrite file if it exists and append other lines
echo "title Arch Linux" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value $ROOT | tr -d '\n') rw" >> /boot/loader/entries/arch.conf

chmod +x /user.sh
su -c "/user.sh" - $USER
