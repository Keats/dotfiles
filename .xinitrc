#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xrdb ~/.Xresources

start-pulseaudio-x11

# Hide cursor when not used
unclutter -grab -root &

# london
redshift  -l 51.5:0 &

# Auto-mounting
udiskie -2 &

# Notifications
dunst -config ~/.dunstrc &

# Tray icons
nm-applet &
volumeicon &

# Disable touchpad while typing
syndaeamon -t -k -i 2 &
setxkbmap gb

exec i3
