#!/bin/bash

# Get active window class
CLASS=$(hyprctl activewindow -j | jq -r '.class')

# Capitalize first letter
if [ -z "$CLASS" ]; then
  echo '{"text": "󰍹 Desktop", "tooltip": "No active window"}'
else
  CAP_CLASS="$(echo "$CLASS" | sed -E 's/(.)(.*)/\U\1\L\2/')"
  echo "{\"text\": \"$CAP_CLASS\", \"tooltip\": \"$CLASS\"}"
fi
