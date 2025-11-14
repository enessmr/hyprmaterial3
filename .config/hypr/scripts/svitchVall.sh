#!/usr/bin/env bash

# 💚 ✨ HyprYoshi3 ✨ 🦕

set -e

# =========================
# CONFIG
# =========================
STATE_DIR="$HOME/.local/share/hyprmaterial3/quickshell"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$STATE_DIR/logs/matugen"
terminalscheme="$SCRIPT_DIR/terminal/scheme-base.json"
SHELL_CONFIG_FILE="$HOME/.config/hyprmaterial3/config.json"

mkdir -p "$LOG_DIR"
mkdir -p "$STATE_DIR/user/generated"

# =========================
# ARGS
# =========================
IMAGE="$1"
MODE="$2"
M3COLOR="$3"

if [ -z "$IMAGE" ] || [ -z "$MODE" ] || [ -z "$M3COLOR" ]; then
    echo "Usage: $0 <IMAGE> <MODE> <M3COLORSCHEME>"
    exit 1
fi

# GLOB EXPANSION MAGIC 💥💥💥
MATCHES=($IMAGE)
if [ ${#MATCHES[@]} -eq 0 ]; then
    echo "Wallpaper not found: $IMAGE"
    exit 1
fi
IMAGE="${MATCHES[0]}"

# =========================
# RUN MATUGEN
# =========================
matugen image "$IMAGE" -m "$MODE" -t scheme-"$M3COLOR" >> "$LOG_DIR/log.dih" 2>&1

# =========================
# GENERATE SCSS WITH PYTHON
# =========================
matugen_args=(image "$IMAGE" --mode "$MODE" --type "scheme-$M3COLOR")
generate_args=(--path "$IMAGE" --mode "$MODE" --termscheme "$terminalscheme" --blend_bg_fg --cache "$STATE_DIR/user/generated/color.txt")

# OPTIONAL EXTRA CONFIG
if [ -f "$SHELL_CONFIG_FILE" ]; then
    harmony=$(jq -r '.appearance.wallpaperTheming.terminalGenerationProps.harmony // empty' "$SHELL_CONFIG_FILE")
    [[ -n "$harmony" ]] && generate_args+=(--harmony "$harmony")
fi

# RUN MATUGEN + PYTHON COLOR GEN
matugen "${matugen_args[@]}"
python3 "$SCRIPT_DIR/generate_colors_material.py" "${generate_args[@]}" > "$STATE_DIR/user/generated/material_colors.scss"
"$SCRIPT_DIR"/applyTerminalDihBestie.sh

# =========================
# NOTIFY
# =========================
notify-send "Wallpaper Changed" "$(basename "$IMAGE") — Mode: $MODE | Color: $M3COLOR"  

echo "SCSS GENERATED 🔥🔥🔥 -> $STATE_DIR/user/generated/material_colors.scss"
