#!/bin/bash

info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
status=$(echo "$info" | grep "state" | awk '{print $2}')
capacity=$(echo "$info" | grep "percentage" | awk '{print $2}')
time=$(echo "$info" | grep -E "time to (empty|full)" | awk -F: '{print $2":"$3}' | xargs)

if [[ -z "$time" ]]; then
  echo "{\"text\": \"$capacity\", \"tooltip\": \"Status: $status\"}"
else
  echo "{\"text\": \"$capacity\", \"tooltip\": \"Status: $status\nTime: $time\"}"
fi
