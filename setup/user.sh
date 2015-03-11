#!/bin/bash

USER=vincent

mkdir -p /home/$USER/.config
ln -sf /home/$USER/dotfiles/xinitrc /home/$USER/.xinitrc
ln -sf /home/$USER/dotfiles/zshrc /home/$USER/.zshrc
ln -sf /home/$USER/dotfiles/zprofile /home/$USER/.zprofile
ln -sf /home/$USER/dotfiles/.gitconfig /home/$USER/.gitconfig
ln -sf /home/$USER/dotfiles/Xresources /home/$USER/.Xresources
ln -sf /home/$USER/dotfiles/.colors /home/$USER/.colors
ln -sf /home/$USER/dotfiles/.config/bspwm /home/$USER/.config/bspwm
ln -sf /home/$USER/dotfiles/.config/sxhkd /home/$USER/.config/sxhkd
ln -sf /home/$USER/dotfiles/.config/lighthouse /home/$USER/.config/lighthouse
