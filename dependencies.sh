#!/bin/bash

# Terminal stuff
sudo pacman -S rxvt-unicode zsh

# File manager/usb automount stuff
sudo pacman -S thunar thunar-volman udisks2 udiskie ntfs-3g

# Misc
sudo pacman -S dunst scrot feh evinces

# Dev
sudo pacman -S vim python-pip python-virtualenv python-virtualenvwrapper

echo "Finished installing dependencies"
