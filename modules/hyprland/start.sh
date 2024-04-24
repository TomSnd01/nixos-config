#!/usr/bin/env bash

swww init &

sleep 1 &&

swww img ~/background-image.jpg &

nm-applet --indicator &
waybar &
dunst
