#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

start-pulseaudio-x11

# london
redshift -l 51.5:0 &

# Auto-mounting
udiskie -2 &

# Disable touchpad while typing
syndaeamon -t -k -i 2 &
setxkbmap gb

skype &

feh --bg-scale dotfiles/wallpaper.jpg

# Not a horrible looking cursor
xsetroot -cursor_name left_ptr &

# For pycharm
export _JAVA_AWT_WM_NONREPARENTING=1

# Japanese keyboard
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &
# https://wiki.archlinux.org/index.php/Dwm#Fixing_misbehaving_Java_applications
# applies to bspwm as well
wmname LG3D

eval "$(ssh-agent)"

sxhkd &
exec bspwm
