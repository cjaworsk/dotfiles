#!/bin/bash

# Check if eww daemon is already running
if ! pgrep -x "eww" >/dev/null; then
    echo "Starting eww daemon..."
    eww daemon &
    sleep 0.5 # small wait to ensure it's ready
else
    echo "Eww daemon already running."
fi

# Open windows (with optional namespace)
eww open bar --namespace left
eww open bar --namespace right
