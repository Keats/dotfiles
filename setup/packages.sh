#!/bin/bash


USER=vincent

# If you are running on wired, you will need to run systemctl enable dhcpcd@interface_name.service
# Use wifi-menu if no wifi
pacman -Syy


echo "Installing base packages (xorg, video, sound, touchpad etc)"
pacman -S xorg-server xorg-xinit xorg-server-utils xorg-xkill mesa xf86-video-intel \
		  xf86-input-synaptics xf86-input-mouse xf86-input-keyboard \
		  alsa-utils alsa-plugins lib32-alsa-plugins pulseaudio pulseaudio-alsa lib32-libpulse


echo "Installing common stuff"
pacman -S vim openssh zsh acpi tlp unzip tar wget scrot redshift firefox \
          numix-themes unclutter fcitx-mozc fcitx-configtool lxappearance \
          gnome-keyring gnome-icon-theme p7zip htop avahi

# TLP optimizes battery life
systemctl enable tlp.service
systemctl enable tlp-sleep.service
# Setup Avahi
systemctl enable avahi-daemon
systemctl enable avahi-dnsconfd

echo "Installing dev stuff"
pacman -S git virtualbox docker qt4 python-pip python2-pip python-virtualenv python-virtualenvwrapper
systemctl enable docker.service


# echo "Creating user if it doesn't exist"
# if ! id -u $USER > /dev/null 2>&1; then
# 	useradd -m -G wheel,vboxusers -s /bin/zsh $USER
# 	passwrd $USER
# 	# Adding wheel group to sudoers
# 	cp -v /etc/sudoers /etc/sudoers.bak
# 	sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
# fi
