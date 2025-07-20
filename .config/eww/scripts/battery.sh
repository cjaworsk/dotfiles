#!/bin/bash

icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
index=$((capacity / 10))
if [ "$index" -gt 9 ]; then
  index=9
fi

echo "${icons[$index]} ${capacity}%"
