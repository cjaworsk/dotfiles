#!/bin/bash
# wlogout (Power, Screen Lock, Suspend, etc)

# Check if wlogout is already running
if pgrep -x "wlogout" >/dev/null; then
  pkill -x "wlogout"
  exit 0
fi

wlogout --protocol layer-shell -b 6 -T 400 -B 400 &
