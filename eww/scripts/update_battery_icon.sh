#!/usr/bin/env bash

# Get battery info
battery=$(upower -e | grep battery)
capacity=$(upower -i "$battery" | grep percentage | awk '{print $2}' | tr -d '%')
status=$(upower -i "$battery" | grep state | awk '{print $2}' | tr '[:upper:]' '[:lower:]')

# Default glyph (discharging)
icon="󰁹" # nf-md-battery (100%)

# Discharging icons
if [ "$status" = "discharging" ]; then
    if [ "$capacity" -lt 10 ]; then
        icon="󰁺" # nf-md-battery_10
    elif [ "$capacity" -lt 20 ]; then
        icon="󰁻"
    elif [ "$capacity" -lt 30 ]; then
        icon="󰁼"
    elif [ "$capacity" -lt 40 ]; then
        icon="󰁽"
    elif [ "$capacity" -lt 50 ]; then
        icon="󰁾"
    elif [ "$capacity" -lt 60 ]; then
        icon="󰁿"
    elif [ "$capacity" -lt 70 ]; then
        icon="󰂀"
    elif [ "$capacity" -lt 80 ]; then
        icon="󰂁"
    elif [ "$capacity" -lt 90 ]; then
        icon="󰂂"
    elif [ "$capacity" -lt 100 ]; then
        icon="󰁹"
    else
        icon="󰂑"
    fi

# Charging icons
elif [ "$status" = "charging" ]; then
    if [ "$capacity" -lt 10 ]; then
        icon="󰢜"
    elif [ "$capacity" -lt 20 ]; then
        icon="󰂆"
    elif [ "$capacity" -lt 30 ]; then
        icon="󰂇"
    elif [ "$capacity" -lt 40 ]; then
        icon="󰂈"
    elif [ "$capacity" -lt 50 ]; then
        icon="󰢝"
    elif [ "$capacity" -lt 60 ]; then
        icon="󰂉"
    elif [ "$capacity" -lt 70 ]; then
        icon="󰢞"
    elif [ "$capacity" -lt 80 ]; then
        icon="󰂊"
    elif [ "$capacity" -lt 90 ]; then
        icon="󰂋"
    elif [ "$capacity" -lt 100 ]; then
        icon="󰂅"
    else
        icon="󰂄" # full + charging
    fi
fi

printf "${icon}"
#eww update bat-tooltip 'Battery: ${capacity}% (${status})')"

# Update Eww
#eww update bat-icon="$icon"
#eww update bat-tooltip="'Battery: ${capacity}% (${status})'"

# Blinking when critical
prev_class=$(eww get bat-class)

if [ "$capacity" -lt 10 ] && [ "$status" != "charging" ]; then
    # Toggle red ↔ green
    if [ "$prev_class" = "bat-red" ]; then
        eww update bat-class="bat-green"
    else
        eww update bat-class="bat-red"
    fi
elif [ "$capacity" -lt 5 ] && [ "$status" != "charging" ]; then
    eww update bat-class="bat-critical"
else
    eww update bat-class="bat-green"
fi
