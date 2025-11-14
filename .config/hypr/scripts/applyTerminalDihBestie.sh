#!/usr/bin/env bash

# 💚 ✨ HyprYoshi3 ✨ 🦕

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_SHARE_HOME="${XDG_SHARE_HOME:-$HOME/.local/share}"
HYI3="${HYI3:-$HOME/.local/share/hyprmaterial3}"
STATE_DIR="$HYI3/quickshell"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
term_alpha=100

if [ ! -d "$STATE_DIR"/user/generated ]; then
    mkdir -p "$STATE_DIR"/user/generated
fi

colornames=$(cat $STATE_DIR/user/generated/material_colors.scss | cut -d: -f1)
colorstrings=$(cat $STATE_DIR/user/generated/material_colors.scss | cut -d: -f2 | cut -d ' ' -f2 | cut -d ";" -f1)

IFS=$'\n'
colorlist=($colornames)
colorvalues=($colorstrings)

# Check if terminal escape sequence template exists
if [ ! -f "$SCRIPT_DIR/terminal/sequences.txt" ]; then
    echo "Template file not found for Terminal. Skipping."
    exit 1
fi

# Copy template
mkdir -p "$STATE_DIR"/user/generated/terminal
cp "$SCRIPT_DIR/terminal/sequences.txt" "$STATE_DIR"/user/generated/terminal/sequences.txt

# Apply colors
for i in "${!colorlist[@]}"; do
    sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$STATE_DIR"/user/generated/terminal/sequences.txt
done

sed -i "s/\$alpha/$term_alpha/g" "$STATE_DIR"/user/generated/terminal/sequences.txt

# Apply to all terminals
for file in /dev/pts/*; do
    if [[ $file =~ ^/dev/pts/[0-9]+$ ]]; then
        {
            cat "$STATE_DIR"/user/generated/terminal/sequences.txt >"$file"
        } & disown || true
    fi
done