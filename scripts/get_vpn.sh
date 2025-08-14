#!/bin/bash

# Grab active connections
active_vpn=$(nmcli -t -f NAME,TYPE connection show --active | grep -E ":vpn$|:wireguard$" | cut -d: -f1)

# If found, extract location portion (e.g., US-CA#903 from "ProtonVPN US-CA#903")
if [[ -n "$active_vpn" ]]; then
    # Use parameter expansion to strip prefix before location
    location="${active_vpn##* }"
    echo "$location"
    eww update vpn_connected=true
else
    echo "Disconnected"
    eww update vpn_connected=false
fi
