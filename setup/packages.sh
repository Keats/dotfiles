#!/bin/bash


USER=vincent

# If you are running on wired, you will need to run systemctl enable dhcpcd@interface_name.service
# Use wifi-menu if no wifi
pacman -Syu

pacman-key --init
pacman-key --populate archlinux
# https://bbs.archlinux.org/viewtopic.php?id=190380
dirmngr </dev/null

# Enable multilib repo
sed -i "s/#\[multilib]\n#Include = \/etc\/pacman.d\/mirrorlist/[multilib]\nInclude = \/etc\/pacman.d\/mirrorlist/g" /etc/pacman.conf
# Add yaourt server
grep -q 'archlinuxfr' /etc/pacman.conf 
if [ $? -ne 0 ]; then
    echo -e "\n[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
fi

# Add pretty font rendering with infinality
pacman-key -r 962DDE58
pacman-key --lsign-key 962DDE58
grep -q 'infinality-bundle' /etc/pacman.conf 
if [ $? -ne 0 ]; then
    echo -e "\n[infinality-bundle]\nServer = http://bohoomil.com/repo/\$arch" >> /etc/pacman.conf
    echo -e "\n[infinality-bundle-multilib]\nServer = http://bohoomil.com/repo/multilib/\$arch" >> /etc/pacman.conf
fi

pacman -Syu

echo "Installing base packages (xorg, video, sound, touchpad etc)"
pacman -S --needed xorg-server xorg-xinit xorg-server-utils xorg-xkill mesa xf86-video-intel \
                   xf86-input-synaptics xf86-input-mouse xf86-input-keyboard \
                   alsa-utils alsa-plugins pulseaudio pulseaudio-alsa


echo "Installing common stuff"
pacman -S --needed vim openssh zsh acpi tlp unzip tar wget scrot redshift firefox \
                   numix-themes unclutter fcitx-mozc fcitx-configtool lxappearance \
                   gnome-keyring gnome-icon-theme p7zip htop avahi libreoffice yaourt flashplugin \
                   transmission-gtk reflector calibre anki mpv steam

# TLP optimizes battery life
systemctl enable tlp.service
systemctl enable tlp-sleep.service
# Setup Avahi
systemctl enable avahi-daemon
systemctl enable avahi-dnsconfd

echo "Installing dev stuff"
pacman -S --needed git virtualbox docker qt4 python-pip python2-pip python-virtualenv python-virtualenvwrapper
systemctl enable docker.service

echo "Installing printer stuff"
pacman -S --needed cups cups-filters ghostscript gsfonts gutenprint system-config-printer
systemctl enable cups

echo "Installing terminal"
pacman -S --needed rxvt-unicode xsel urxvt-perls

echo "Installing font stuff"
pacman -S --needed infinality-bundle adobe-source-han-sans-otc-fonts ttf-dejavu ttf-liberation terminus-font \
                   adobe-source-code-pro-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts \
                   freetype2-ubuntu

echo "Installing file manager stuff"
pacman -S --needed thunar thunar-volman udisks2 udiskie ntfs-3g gvfs-mtp android-udev


echo "Creating user if it doesn't exist"
if ! id -u $USER > /dev/null 2>&1; then
    useradd -m -G wheel,vboxusers -s /bin/zsh $USER
    passwrd $USER
    # Adding wheel group to sudoers
    cp -v /etc/sudoers /etc/sudoers.bak
    sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers
fi

su - $USER

echo "And now install stuff from AUR"
yaourt -S  --noconfirm lighthouse-git numix-circle-icon-theme-git ttf-powerline-fonts-git tamzen-font-git sublime-text-dev \
                       google-chrome dropbox compton spotify ttf-fantasque-sans pycharm-professional \
                       bspwm-git sxhkd-git bar-aint-recursive ttf-ms-fonts jmtpfs jdk thunar-dropbox \
                       numix-icon-theme-git trimage-git oh-my-zsh-git android-studio

