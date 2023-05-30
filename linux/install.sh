#!/bin/bash

# argument 1 = drive path
DRIVE=$1

# argument 2 = nvme or something else
DRIVE_TYPE=""
if [ "$2" = "nvme" ]; then
	DRIVE_TYPE="p"
fi
DRIVE_PARTITION="$DRIVE""$DRIVE_TYPE"

# partition the drive
sgdisk -o $DRIVE
sgdisk -n 1::+300M -t 1:ef00 $DRIVE
sgdisk -n 2::0 -t 2:8300 $DRIVE

# format the partitions
mkfs.fat -F 32 "$DRIVE_PARTITION"1
mkfs.btrfs "$DRIVE_PARTITION"2

# create btrfs subvolumes
mount -o compress=zstd,noatime "$DRIVE_PARTITION"2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@.snapshots
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@pkg
umount /mnt

# mount root subvolume
mount -o compress=zstd,noatime,subvol=@ "$DRIVE_PARTITION"2 /mnt

# create mountpoints
mkdir -p /mnt/{home,boot,var/{log,cache/pacman/pkg}}

# mount other subvolumes
mount -o compress=zstd,noatime,subvol=@home "$DRIVE_PARTITION"2 /mnt/home
mount -o compress=zstd,noatime,subvol=@log "$DRIVE_PARTITION"2 /mnt/var/log
mount -o compress=zstd,noatime,subvol=@ "$DRIVE_PARTITION"2 /mnt/var/cache/pacman/pkg

# mount efi partition
mount "$DRIVE_PARTITION"1 /mnt/boot

# install base
pacstrap -K /mnt base linux linux-firmware

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# copy next part of install script to root
cp /root/chroot.sh /mnt/

# run next part of install
arch-chroot /mnt bash /chroot.sh

# unmount
umount -R /mnt

# reboot
reboot
