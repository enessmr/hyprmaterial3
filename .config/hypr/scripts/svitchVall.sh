#!/usr/bin/env bash

# HyprMaterial3 wallpaper switcher with Matugen args

IMAGE="$1"
MODE="$2"
M3COLOR="$3"

if [ -z "$IMAGE" ] || [ -z "$MODE" ] || [ -z "$M3COLOR" ]; then
    echo "Usage: $0 <IMAGE> <MODE> <M3COLORSCHEME>"
    exit 1
fi

# --- Expand globs / validate file ---
MATCHES=($IMAGE)
if [ ${#MATCHES[@]} -eq 0 ]; then
    echo "Wallpaper not found: $IMAGE"
    exit 1
fi
IMAGE="${MATCHES[0]}"

# --- Start swww daemon if not running ---
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# --- Set wallpaper ---
echo "Setting wallpaper: $IMAGE"
swww img "$IMAGE" &
sleep 0.2

# --- Apply Matugen colors ---
matugen image "$IMAGE" -m "$MODE" -t scheme-"$M3COLOR"

# --- Notification ---
notify-send "Wallpaper Changed" "$(basename "$IMAGE") — Mode: $MODE | Color: $M3COLOR"
