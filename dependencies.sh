#!/bin/bash

# X + graphic stuff
sudo pacman -S xorg-server xorg-xinit xorg-server-utils mesa

# Tiling/Terminal stuff
sudo pacman -S i3 rxvt-unicode zsh xsel urxvt-perls conky

# File manager/usb automount stuff
sudo pacman -S thunar thunar-volman udisks2 udiskie ntfs-3g

# Fonts
sudo pacman -S ttf-liberation ttf-ubuntu-font-family ttf-inconsolata adobe-source-code-pro-fonts terminus-font adobe-source-sans-pro-fonts adobe-source-han-sans-jp-fonts ttf-droid

# Misc
sudo pacman -S tranmission-gtk arandr skype unclutter flashplugin dunst scrot feh evince conky redshift firefox dmenu xf86-input-synaptics numix-themes lxappearance

# Wifi
sudo pacman -S wpa_supplicant wireless_tools networkmanager network-manager-applet gnome-keyring gnome-icon-theme

# Dev
sudo pacman -S docker vim python-pip python2-pip python-virtualenv python-virtualenvwrapper
sudo systemctl enable docker.service

# Fig not working on python3 yet https://github.com/docker/fig/pull/440
sudo pip2 install fig

# Sound
sudo pacman -S pulseaudio pulseaudio-alsa lib32-libpulse lib32-alsa-plugins pavucontrol volumeicon alsa-utils

# And VMs stuff
sudo pacman -S virtualbox qt4

echo "Finished installing dependencies"
