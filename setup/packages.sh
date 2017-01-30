#!/bin/bash
USER=vincent
sudo pacman -Syu

sudo pacman-key --init
sudo pacman-key --populate archlinux

# Enable multilib repo, this is witchery
sudo sed -i ':begin;$!N;s/#\[multilib\]\n#Include/\[multilib\]\nInclude/;tbegin;P;D' /etc/pacman.conf
# Add yaourt server
grep -q 'archlinuxfr' /etc/pacman.conf
if [ $? -ne 0 ]; then
    echo -e "\n[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch" | sudo tee --append /etc/pacman.conf
fi

sudo pacman -Sy
# it's in pkglist.txt already but better to be explicit
sudo pacman -S yaourt

echo "Installing official packages"
sudo pacman -S $(< pkglist.txt)

echo "Installing AUR packages"
yaourt -S --noconfirm $(< pkglist-aur.txt)

# Font rendering
sudo ln -sf /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
sudo ln -sf /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -sf /etc/fonts/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d
sudo ln -sf /etc/fonts/conf.avail/30-infinality-aliases.conf /etc/fonts/conf.d
echo -e "\nexport _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'" | sudo tee --append /etc/profile.d/jre.sh

echo "Installing rustup"
curl https://sh.rustup.rs -sSf | sh

echo "Installing Nix"
curl https://nixos.org/nix/install | sh

# some systemctl enabling
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl enable NetworkManager.service
sudo tlp start
# docker stuff
sudo systemctl enable docker
sudo usermod -aG docker $USER
