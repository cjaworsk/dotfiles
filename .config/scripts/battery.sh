#!/bin_bash
battery_info=$(acpi -b)
percentage=$(echo "$battery_info" | grep -o '[0-9]\+%' | tr -d '%')
echo "Battery Percentage: $percentage%"
