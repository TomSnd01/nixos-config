#!/usr/bin/env bash

swww init &

sleep 0.1 &&

swww img -o DP-1 ~/main-background-image.jpg &
swww img -o DP-2 ~/main-background-image.jpg &
swww img -o HDMI-A-1 ~/second-background-image.jpeg &

nm-applet --indicator &
waybar &
dunst
