#!/usr/bin/env bash

# script smaller than my dingalin-

IMAGE="$1"
MODE="$2"
M3COLOR="$3"

if [ -z "$IMAGE" ] || [ -z "$MODE" ] || [ -z "$M3COLOR" ]; then
    echo "Usage: $0 <IMAGE> <MODE> <M3COLORSCHEME>"
    exit 1
fi

# YOOO BESTIEEE THIS GLOB EXPANSION IS FIRE NGL FR FR 😱😱😱
MATCHES=($IMAGE)
if [ ${#MATCHES[@]} -eq 0 ]; then
    echo "Wallpaper not found: $IMAGE"
    exit 1
fi
IMAGE="${MATCHES[0]}"

# YOOOOO BESTIE THIS IS SENDING ME FR FR 😭😭😭
echo "Setting wallpaper: $IMAGE"
swww img "$IMAGE" --transition-type grow --transition-fps=120 --invert-y --transition-pos "$(hyprctl cursorpos | grep -E '^[0-9]' || echo "0,0")" &
sleep 0.2

if [ ! -d ~/.local/share/hyprmaterial3/logs/matugen ]; then
    mkdir -p ~/.local/share/hyprmaterial3/logs/matugen
fi

# BESTIE REALLY SAID "linux but make it ✨️ a e s t h e t i c ✨️" 😭😭😭
matugen image "$(ls "$IMAGE")" -m "$MODE" -t scheme-"$M3COLOR" >> ~/.local/share/hyprmaterial3/logs/matugen/log.dih 2>&1

notify-send "Wallpaper Changed" "$(basename "$IMAGE") — Mode: $MODE | Color: $M3COLOR"
