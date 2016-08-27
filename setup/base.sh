#!/bin/bash

HOSTNAME=arch
KB_LAYOUT=uk
LOCALE=en_GB.UTF-8
VOLUME_NAME=crypt
USER=vincent
REPO=https://github.com/Keats/dotfiles.git

echo "Setting up keyboard"
loadkeys $KB_LAYOUT

echo "Sync time"
timedatectl set-ntp true

echo "Setting up partitions"
parted /dev/sda mklabel gpt
parted /dev/sda mkpart ESP fat32 1M 513M
parted /dev/sda set 1 boot on
parted /dev/sda mkpart primary ext4 513M 100%

# Create EFI partition
mkfs.fat -F32 /dev/sda1

# Create a container with stronger encryption than default
echo "You will be asked to set the password for the encrypted volume"
cryptsetup --cipher=aes-xts-plain64 --key-size=512 --hash=sha512 --iter-time=5000 --use-random luksFormat /dev/sda2
# Open the container
# Enable TRIM at the cost of a bit of security
cryptsetup open --allow-discards --type luks /dev/sda2 $VOLUME_NAME
# Create filesystem
mkfs.ext4 -L "Arch" /dev/mapper/$VOLUME_NAME

# And mount them
mount /dev/mapper/$VOLUME_NAME /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

echo "Running pacstrap"
pacstrap -i /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab

echo "Optimizing mirror list"
pacman -Syy  # refresh first otherwise the install below would fail
pacman -S reflector
reflector -f 6 -l 6 --save /mnt/etc/pacman.d/mirrorlist
pacman -Syy  # refresh again

echo "Everything below is done chrooting"
# Start configuring the base system

echo "Setting up GB related stuff (locale, keyboard, tz)"
# Setting up GB locale
sed -i "s/en_US.UTF-8/#en_US.UTF-8/" /mnt/etc/locale.gen
sed -i "s/#$LOCALE/$LOCALE/" /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo LANG=$LOCALE> /mnt/etc/locale.conf
# Making sure uk keyboard is persisted
echo KEYMAP=$KB_LAYOUT > /mnt/etc/vconsole.conf
# Living in London
arch-chroot /mnt ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
arch-chroot /mnt hwclock --systohc --utc

echo "Setting up hostname"
echo $HOSTNAME > /mnt/etc/hostname
echo "127.0.0.1 localhost.localdomain localhost ${HOSTNAME}" > /mnt/etc/hosts
echo "::1   localhost.localdomain localhost ${HOSTNAME}" >> /mnt/etc/hosts

echo "Making sure we still get wifi when we reboot..."
# Installing git and zsh for pkg bootstrap later on
arch-chroot /mnt pacman -S networkmanager dhclient zsh git openssh intel-ucode util-linux
arch-chroot /mnt systemctl enable NetworkManager.service
arch-chroot /mnt systemctl enable fstrim.timer

echo "Editing initial ramdisk"
cp /mnt/etc/mkinitcpio.conf /mnt/etc/mkinitcpio.conf.bak
sed -i "s/filesystems keyboard/encrypt keymap filesystems keyboard/" /mnt/etc/mkinitcpio.conf
arch-chroot /mnt mkinitcpio -p linux

echo "Change root password"
arch-chroot /mnt passwd

echo "Bootloader time"
# https://wiki.archlinux.org/index.php/Systemd-boot
arch-chroot /mnt bootctl --path=/boot install
echo "title Arch Linux Encrypted" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
UUID=$(blkid /dev/sda2 | awk '{print $2}' | sed 's/"//g')
echo "options cryptdevice=$UUID:$VOLUME_NAME:allow-discards root=/dev/mapper/$VOLUME quiet rw" >> /boot/loader/entries/arch.conf

echo "Creating user"
arch-chroot /mnt useradd -m -G wheel -s /bin/zsh $USER
arch-chroot /mnt passwd $USER
sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /mnt/etc/sudoers
arch-chroot /mnt git clone $REPO /home/$USER/dotfiles
arch-chroot /mnt chown $USER:$USER /home/$USER/dotfiles
echo "Base setup done, type reboot if you're happy"
