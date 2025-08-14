#!/bin/bash

chosen=$(nmcli -f SSID,BARS device wifi list | tail -n +2 | awk '!seen[$0]++' | wofi --dmenu --prompt "Wi-Fi Networks" | awk '{print $1}')

if [ -n "$chosen" ]; then
  password=$(wofi --dmenu --password --prompt "Password for $chosen")
  nmcli device wifi connect "$chosen" password "$password"
fi
