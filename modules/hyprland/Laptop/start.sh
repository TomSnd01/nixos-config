#!/usr/bin/env bash

swww init &

sleep 0.1 &&

swww img -o eDP-1 ~/main-background-image.jpg &

nm-applet --indicator &
waybar &
dunst
