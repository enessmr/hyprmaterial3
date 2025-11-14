#!/bin/bash

# 💚 ✨ HyprYoshi3 ✨ 🦕

if [ ! -f "$HOME/.local/share/hypryoshi3/greeted.txt" ]; then
    notify-send "Welcome to HyprYoshi3!" "The green dino loves this setup ✨💚🦕✨"
    mkdir -p "$HOME/.local/share/hypryoshi3"
    touch "$HOME/.local/share/hypryoshi3/greeted.txt"
fi
