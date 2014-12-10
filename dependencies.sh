#!/bin/bash

# X + graphic stuff
sudo pacman -S xorg-server xorg-xinit xorg-server-utils mesa

# Tiling/Terminal stuff
sudo pacman -S i3 rxvt-unicode zsh xclip

# File manager/usb automount stuff
sudo pacman -S thunar thunar-volman udisks2 udiskie ntfs-3g

# Misc
sudo pacman -S dunst scrot feh evince conky redshift firefox dmenu xf86-input-synaptics

# Wifi
sudo pacman -S wpa_supplicant wireless_tools networkmanager network-manager-applet gnome-keyring gnome-icon-theme

# Dev
sudo pacman -S vim python-pip python-virtualenv python-virtualenvwrapper

echo "Finished installing dependencies"
