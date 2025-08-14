#!/bin/bash

# Name of your Eww config directory (if not default)
CONFIG_DIR="$HOME/.config/eww"

# Check if daemon is already running
if ! pgrep -x "eww" >/dev/null; then
    eww daemon --config "$CONFIG_DIR"
    # Give it a moment to fully start
    sleep 0.5
fi

# Open your Eww window (replace with your actual window name)
eww open bar
eww open power-menu-popup
