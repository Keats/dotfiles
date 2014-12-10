#!/bin/bash

# X + graphic stuff
sudo pacman -S xorg-server xorg-xinit xorg-server-utils mesa

# Tiling/Terminal stuff
sudo pacman -S i3 rxvt-unicode zsh xclip

# File manager/usb automount stuff
sudo pacman -S thunar thunar-volman udisks2 udiskie ntfs-3g

# Fonts
sudo pacman -S ttf-ubuntu-font-family ttf-inconsolata adobe-source-code-pro-fonts terminus-font adobe-source-sans-pro-fonts adobe-source-han-sans-jp-fonts ttf-droid

# Misc
sudo pacman -S dunst scrot feh evince conky redshift firefox dmenu xf86-input-synaptics numix-themes lxappearance

# Wifi
sudo pacman -S wpa_supplicant wireless_tools networkmanager network-manager-applet gnome-keyring gnome-icon-theme

# Dev
sudo pacman -S vim python-pip python-virtualenv python-virtualenvwrapper

echo "Finished installing dependencies"
