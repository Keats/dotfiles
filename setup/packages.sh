#!/bin/bash

# If you are running on wired, you will need to run systemctl enable/start dhcpcd@interface_name.service
# Use wifi-menu if no wifi
sudo pacman -Syu

sudo pacman-key --init
sudo pacman-key --populate archlinux
# https://bbs.archlinux.org/viewtopic.php?id=190380
sudo dirmngr </dev/null

# Enable multilib repo, this is witchery
sudo sed -i ':begin;$!N;s/#\[multilib\]\n#Include/\[multilib\]\nInclude/;tbegin;P;D' /etc/pacman.conf
# Add yaourt server
grep -q 'archlinuxfr' /etc/pacman.conf
if [ $? -ne 0 ]; then
    echo -e "\n[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch" | sudo tee --append /etc/pacman.conf
fi

# Add pretty font rendering with infinality
sudo pacman-key -r 962DDE58
sudo pacman-key --lsign-key 962DDE58
grep -q 'infinality-bundle' /etc/pacman.conf
if [ $? -ne 0 ]; then
    echo -e "\n[infinality-bundle]\nServer = http://bohoomil.com/repo/\$arch" | sudo tee --append /etc/pacman.conf
    echo -e "\n[infinality-bundle-multilib]\nServer = http://bohoomil.com/repo/multilib/\$arch" | sudo tee --append /etc/pacman.conf
fi

sudo pacman -Syu

echo "Installing base packages (xorg, video, sound, touchpad etc)"
sudo pacman -S --needed xorg-server xorg-xinit xorg-server-utils xterm xorg-xkill mesa xf86-video-intel \
                   xf86-input-synaptics xf86-input-mouse xf86-input-keyboard \
                   alsa-utils alsa-plugins pulseaudio pulseaudio-alsa


echo "Installing common stuff"
sudo pacman -S --needed vim openssh zsh acpi tlp unzip tar wget scrot redshift firefox \
                   numix-themes unclutter fcitx-im fcitx-mozc fcitx-configtool fcitx-ui-light lxappearance \
                   gnome-keyring gnome-icon-theme p7zip htop avahi libreoffice yaourt flashplugin \
                   transmission-gtk reflector calibre anki mpv steam conky dzen2 feh gmrun polkit \
                   skype lxrandr virtualbox-guest-modules polkit mplayer wmname lib32-gtk2 \
                   xscreensaver rsync

# TLP optimizes battery life
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
# Setup Avahi
sudo systemctl enable avahi-daemon
sudo systemctl enable avahi-dnsconfd

echo "Installing dev stuff"
sudo pacman -S --needed git virtualbox docker qt4 python-pip python2-pip python-virtualenv python-virtualenvwrapper
sudo systemctl enable docker.service
sudo sed -i "s/ExecStart=\/usr\/bin\/docker -d -H fd:\/\//ExecStart=\/usr\/bin\/docker -d -H tcp:\/\/127.0.0.1:4243 -H unix:\/\/\/var\/run\/docker.sock/" /usr/lib/systemd/system/docker.service

echo "Installing printer stuff"
sudo pacman -S --needed cups cups-filters ghostscript gsfonts gutenprint system-config-printer
sudo systemctl enable cups

echo "Installing terminal"
sudo pacman -S --needed rxvt-unicode xsel urxvt-perls

echo "Installing font stuff"
sudo pacman -S --needed infinality-bundle adobe-source-han-sans-otc-fonts ttf-dejavu ttf-liberation terminus-font \
                   adobe-source-code-pro-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts \
                   freetype2-ubuntu otf-ipafont tamsyn-font

echo "Installing file manager stuff"
sudo pacman -S --needed thunar thunar-volman udisks2 udiskie ntfs-3g gvfs-mtp android-udev


echo "And now install stuff from AUR"
yaourt -S --noconfirm google-chrome dropbox spotify pycharm-professional jdk \
                      android-sdk
yaourt -S --noconfirm lighthouse-git numix-circle-icon-theme-git powerline-fonts-git tamzen-font-git sublime-text-dev \
                      compton ttf-fantasque-sans bspwm-git sxhkd-git bar-aint-recursive \
                      ttf-ms-fonts jmtpfs thunar-dropbox numix-icon-theme-git trimage-git \
                      oh-my-zsh-git bdf-tewi-git gohufont xtitle-git stlarch_font iojs-bin
yaourt -S --noconfirm lastpass xss-lock zathura-pdf-mupdf-git
