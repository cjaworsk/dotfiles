#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILENAME="$DIR/shot_$(date +'%Y-%m-%d_%H-%M-%S').png"

if grimshot save area "$FILENAME"; then
  notify-send "Screenshot Taken" "Saved to $FILENAME"
else
  notify-send "Screenshot Failed" "Could not save screenshot"
fi
