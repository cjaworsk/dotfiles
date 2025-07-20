#!bin/bash

# kill waybar and hypridle
killall waybar hypridle 2>/dev/null

sleep 0.2

#restart services
waybar &
hypridle &

exit 0
