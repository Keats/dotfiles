#!/bin/bash
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

echo "Installing official packages"
sudo pacman -S $(< pkglist.txt)

echo "Installing AUR packages"
yaourt -S --noconfirm $(< pkglist-aur.txt)
