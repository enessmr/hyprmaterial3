#!/bin/bash

CPOS="$(hyprctl cursorpos | grep -E '^[0-9]' || echo '0,0')"

swww "$1"