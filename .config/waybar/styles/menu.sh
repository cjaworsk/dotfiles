#!/bin/bash

if pgrep -f "waybar.*waybar-menu.jsonc" >/dev/null; then
  pkill -f "waybar.*waybar-menu.jsonc"
else
  waybar -c ~/.config/waybar/configs/waybar-menu.jsonc -s ~/.config/waybar/styles/waybar-menu.css
fi
