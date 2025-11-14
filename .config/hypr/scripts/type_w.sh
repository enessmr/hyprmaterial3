#!/bin/bash

# 💚 ✨ HyprYoshi3 ✨ 🦕

# by deepseek ;)

# Check if wtype is installed
if ! command -v wtype &> /dev/null; then
    echo "Error: wtype is not installed. Please install it first."
    exit 1
fi

# Function to get Caps Lock status
get_caps_lock_status() {
    # Try to check using the sysfs method (common on Linux)
    for led in /sys/class/leds/*:capslock; do
        if [ -d "$led" ]; then
            status=$(cat "$led/brightness")
            if [ "$status" -eq 1 ]; then
                echo "on"
                return
            else
                echo "off"
                return
            fi
        fi
    done

    # Fallback: check using hyprctl if on Hyprland
    if command -v hyprctl &> /dev/null; then
        # This is a speculative approach and might need adjustment
        # Hyprland doesn't directly expose Caps Lock status via hyprctl
        # Alternatively, we can check the keyboard layout state
        status=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "at-translated-set-2-keyboard") | .leds.caps_lock' 2>/dev/null)
        if [ "$status" = "true" ]; then
            echo "on"
            return
        else
            echo "off"
            return
        fi
    fi

    # If all methods fail, assume off
    echo "off"
}

# Main execution
caps_status=$(get_caps_lock_status)

if [ "$caps_status" = "on" ]; then
    wtype "W"
    echo "Typed uppercase W (Caps Lock is on)"
else
    wtype "w"
    echo "Typed lowercase w (Caps Lock is off)"
fi