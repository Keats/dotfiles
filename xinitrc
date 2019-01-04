#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

start-pulseaudio-x11

# Italy
redshift -l 42.5940479:12.295247 &

# Auto-mounting
udiskie -2 &

# Disable touchpad while typing
syndaeamon -t -k -i 2 &
setxkbmap gb

feh --bg-scale dotfiles/wallpaper.jpg

# Not a horrible looking cursor
xsetroot -cursor_name left_ptr &

# For pycharm
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# https://wiki.archlinux.org/index.php/Dwm#Fixing_misbehaving_Java_applications
# applies to bspwm as well
wmname LG3D

eval "$(ssh-agent)"

exec i3
