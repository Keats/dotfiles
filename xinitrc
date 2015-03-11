#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xrdb ~/.Xresources
start-pulseaudio-x11

# Hide cursor when not used
unclutter -grab -noevents -root &

# london
redshift  -l 51.5:0 &

# Auto-mounting
udiskie -2 &

# Disable touchpad while typing
syndaeamon -t -k -i 2 &
setxkbmap gb

skype &

xset +fp /usr/share/fonts/local
xset fp rehash

# Not a horrible looking cursor
xsetroot -cursor_name left_ptr &

# Japanese keyboard
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &

eval "$(ssh-agent)"

compton &

sxhkd &
exec bspwm -s
