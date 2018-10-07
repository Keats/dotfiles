#!/bin/bash

USER=vincent

rm -rf home/$USER/.config && mkdir -p /home/$USER/.config
ln -sf /home/$USER/dotfiles/xinitrc /home/$USER/.xinitrc
ln -sf /home/$USER/dotfiles/zshrc /home/$USER/.zshrc
ln -sf /home/$USER/dotfiles/zprofile /home/$USER/.zprofile
ln -sf /home/$USER/dotfiles/.gitconfig /home/$USER/.gitconfig
ln -sf /home/$USER/dotfiles/.gitignore /home/$USER/.gitignore
ln -sf /home/$USER/dotfiles/Xresources /home/$USER/.Xresources
ln -sf /home/$USER/dotfiles/.colors /home/$USER/.colors
ln -sf /home/$USER/dotfiles/.config/i3 /home/$USER/.config/i3
ln -sf /home/$USER/dotfiles/.config/i3blocks /home/$USER/.config/i3blocks
ln -sf /home/$USER/dotfiles/.config/termite /home/$USER/.config/termite
ln -sf /home/$USER/dotfiles/.config/compton.conf /home/$USER/.config/compton.conf
ln -sf /home/$USER/dotfiles/dircolors /home/$USER/.dircolors
sudo ln -sf /home/vincent/dotfiles/keats.zsh-theme /usr/share/oh-my-zsh/theme
