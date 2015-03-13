#!/bin/bash

HOSTNAME=thinkpad
KB_LAYOUT=uk
LOCALE=en_GB.UTF-8
VOLUME_GROUP_NAME=crypt
ROOT_VOLUME_SIZE=20G
USER=vincent
REPO=git@github.com:Keats/dotfiles.git


echo "Setting up keyboard"
loadkeys $KB_LAYOUT


echo "Setting up partitions"
# Setup partitions: sda1 == boot and sda2 == to-be-encrypted
parted /dev/sda mklabel gpt
parted /dev/sda mkpart primary ext3 1M 200M
parted /dev/sda set 1 boot on
parted /dev/sda mkpart primary ext3 200MB 100%

# Load kernel modules device mapper and encryption
modprobe -a dm-mod dm_crypt

# Following from https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS
# Create a container with stronger encryption than default
echo "You will be asked to set the password for the encrypted volume"
cryptsetup -v --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5000 --use-random luksFormat /dev/sda2
# Open the container
cryptsetup open --type luks /dev/sda2 lvm
# Create a physical volume on top of it
pvcreate /dev/mapper/lvm
# Create a volume group including that volume
vgcreate $VOLUME_GROUP_NAME /dev/mapper/lvm
# And create my logical volumes
lvcreate -L $ROOT_VOLUME_SIZE $VOLUME_GROUP_NAME -n rootvol
lvcreate -l +100%FREE $VOLUME_GROUP_NAME -n homevol
# Create filesystems
mkfs.ext4 /dev/mapper/$VOLUME_GROUP_NAME-rootvol
mkfs.ext4 /dev/mapper/$VOLUME_GROUP_NAME-homevol
# And mount them
mount /dev/$VOLUME_GROUP_NAME/rootvol /mnt
mkdir /mnt/home
mount /dev/$VOLUME_GROUP_NAME/homevol /mnt/home

# Let's not forget the boot partition
mkfs.ext4 /dev/sda1
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

echo "Optimizing mirror list"
pacman -Syy  # refresh first otherwise the install below would fail
pacman -S reflector
reflector -f 6 -l 6 --save /etc/pacman.d/mirrorlist
pacman -Syy  # refresh list

echo "Running pacstrap"
pacstrap -i /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab

echo "Everything below is done chrooting"
# Start configuring the base system

echo "Setting up GB related stuff (locale, keyboard, tz)"
# Setting up GB locale
sed -i s/en_US.UTF-8/#en_US.UTF-8/ /mnt/etc/locale.gen
sed -i s/#$LOCALE/$LOCALE/ /mnt/etc/locale.gen
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
arch-chroot /mnt pacman -S dialog wpa_actiond
echo "Displaying name of devices, which one is the wifi? Leave empty for none:"
ls /sys/class/net
read interface_name
if [ -z "$interface_name" ]
then
	echo "No wifi interface."
else
	arch-chroot /mnt systemctl enable netctl-auto@${interface_name}.service
fi

echo "Editing initial ramdisk"
cp /mnt/etc/mkinitcpio.conf /mnt/etc/mkinitcpio.conf.bak
sed -i "s/filesystems keyboard/encrypt lvm2 keymap filesystems keyboard/" /mnt/etc/mkinitcpio.conf
arch-chroot /mnt mkinitcpio -p linux

echo "Change root password"
arch-chroot /mnt passwd

echo "Bootloader time"
# Need to install gdisk as well: https://bbs.archlinux.org/viewtopic.php?pid=1199850#p1199850
# Installing git and zsh for the user creation
arch-chroot /mnt pacman -S syslinux gdisk zsh git
arch-chroot /mnt syslinux-install_update -iam
sed -i "s/APPEND root=[a-z\/0-9]*/APPEND cryptdevice=\/dev\/sda2:${VOLUME_GROUP_NAME} root=\/dev\/mapper\/${VOLUME_GROUP_NAME}-rootvol/g" /mnt/boot/syslinux/syslinux.cfg

echo "Creating user"
arch-chroot /mnt useradd -m -G wheel -s /bin/zsh $USER
arch-chroot /mnt passwd $USER
sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /mnt/etc/sudoers
arch-chroot /mnt git clone $REPO /home/$USER/dotfiles
arch-chroot /mnt chown vincent:vincent /home/$USER/dotfiles
echo "Base setup done, type reboot if you're happy"
