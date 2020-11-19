#!/bin/bash
lsblk
echo "Enter the drive name you'd like to format. THIS WILL FORMAT THE WHOLE DRIVE."
echo -n "Valid drive names are:"
lsblk -nd --output NAME | sed -z 's/\n/, /g'
read -r DRIVE

SWAPSIZE=$(($(cat /proc/meminfo | grep MemTotal | awk '{print int($2/1024)}')+300))
# Creates boot, swap, and root partition.
parted --script /dev/$DRIVE \
    mklabel gpt \
    mkpart primary fat32 1MiB 300MiB \
    set 1 esp on \
    mkpart primary linux-swap 300MiB "$SWAPSIZE"MiB \
    mkpart primary ext4 "$SWAPSIZE"MiB 100% \
    align-check min 1

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
pacman -Sy --noconfirm archlinux-keyring pacman-contrib
rankmirrors -n 6 mirrorlist > /etc/pacman.d/mirrorlist

# Install packages from file
pacstrap /mnt $(grep -v "#" packages | tr '\n' ' ')
echo "Creating FS Table."
genfstab -U -p /mnt > /mnt/etc/fstab
echo "Copying install scripts to root fs and entering chroot."
echo "$ROOT" > /mnt/rootPart
cp chroot.sh /mnt && cp user.sh /mnt && arch-chroot /mnt bash chroot.sh && cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
