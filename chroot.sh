#!/bin/bash
ROOT=$(cat /rootPart | tr -d '\n')

echo "Setting root password."
until passwd; do sleep 1; done
# PROMPT FOR USERNAME
echo "Please enter your desired username. "
read -r USER
useradd -mg users -G wheel,storage,power,libvirt,video -s /usr/bin/zsh "$USER"
echo "Setting user password."
until passwd "$USER"; do sleep 1; done
# Set up sudoers
sudo sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
# PROMPT FOR HOSTNAME
echo "Please enter your desired hostname for the machine: "
read -r HOSTNAME
echo "$HOSTNAME" > /etc/hostname
# Set locale stuff
echo "Setting locale."
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
export LANG=en_US.UTF-8
locale-gen
# Set timezone
echo "Setting timezone."
ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
# Set clock to utc
hwclock --systohc --utc
# Set makeflags to core count -2
sed -i '/MAKEFLAGS/c\MAKEFLAGS="-j $(( $(nproc)-2 ))"' /etc/makepkg.conf

# Set up virtualization
echo 'nvram = [
	"/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd"
]' >> /etc/qemu/qemu.conf
systemctl enable libvirtd.service virtlogd.socket

# Symlink nvim
ln -s /usr/bin/nvim /bin/vim

# Enable services
echo "Enabling services for first boot"
systemctl enable NetworkManager
systemctl enable cronie

# Set up basic crontab with pacman repo sync
(crontab -l 2>/dev/null; echo "@hourly pacman -Sy") | crontab -

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
