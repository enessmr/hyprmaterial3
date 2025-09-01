#!/usr/bin/env bash

# HyprMaterial3 wallpaper switcher

WALL_DIR="$HOME/Pictures/.Wallpapers"
WALLPAPERS=("$WALL_DIR"/*)
NUM=${#WALLPAPERS[@]}

if [ "$NUM" -eq 0 ]; then
    echo "No wallpapers found in $WALL_DIR"
    exit 1
fi

# pick a random wallpaper
SELECTED=${WALLPAPERS[$RANDOM % $NUM]}
echo "Selected wallpaper: $SELECTED"
echo $WALLPAPERS
echo $NUM

if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# set it using swww (or replace with hyprpaper command)
swww img "$SELECTED"
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi



matugen image "$SELECTED"

# optional notification
notify-send "Wallpaper Changed" "$(basename "$SELECTED")"
