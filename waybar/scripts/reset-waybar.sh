#!/bin/bash

# kill waybar and hypridle
killall waybar 2>/dev/null

sleep 0.2

#restart services
waybar &

exit 0
