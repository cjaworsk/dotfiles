#!/bin/bash

# Reload Cava
if pgrep cava >/dev/null; then
  echo "Reloading Cava..."
  pkill cava
  sleep 0.2
  kitty --class cava -e cava &
fi

# Reload SwayNC (for new colors)
#if pgrep swaync >/dev/null; then
#  echo "Reloading SwayNC..."
#  swaync-client -rs
#fi

# Reload Waybar
killall waybar 2>/dev/null
sleep 0.2
exec waybar &

exit 0
