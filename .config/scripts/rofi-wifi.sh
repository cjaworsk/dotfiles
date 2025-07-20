#!/usr/bin/env bash

# Function to get Wi-Fi list and mark connected network
get_wifi_list() {
  current_ssid=$(nmcli -t -f active,ssid dev wifi | grep "^yes" | cut -d':' -f2)
  known_ssids=$(nmcli -g NAME connection show)
  ssids_seen=()

  nmcli -t -f in-use,signal,security,ssid device wifi list | sort -t: -k2 -nr | while IFS=':' read -r inuse signal security ssid; do
    # Skip empty SSIDs
    [[ -z "$ssid" ]] && continue

    # Prevent duplicates
    if [[ " ${ssids_seen[*]} " =~ " ${ssid} " ]]; then
      continue
    fi
    ssids_seen+=("$ssid")

    # Signal icon map
    if ((signal >= 76)); then
      signal_icon="󰤨"
    elif ((signal >= 51)); then
      signal_icon="󰤥"
    elif ((signal >= 26)); then
      signal_icon="󰤢"
    else
      signal_icon="󰤟"
    fi

    # Security icon (lock vs. unlocked)
    if [[ "$security" == "--" ]]; then
      lock_icon=""
    else
      lock_icon=""
    fi

    # Known network = bold
    if echo "$known_ssids" | grep -qx "$ssid"; then
      ssid_known="󰦤 "
    else
      ssid_known=""
    fi

    # Connected now?
    if [[ "$ssid" == "$current_ssid" ]]; then
      echo "$signal_icon $lock_icon $ssid ✔ $ssid_known"
    else
      echo "$signal_icon $lock_icon $ssid $ssid_known"
    fi
  done
}

# Determine toggle button based on current status
connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
  toggle="󰖪  Disable Wi-Fi"
else
  toggle="󰖩  Enable Wi-Fi"
fi

# Notify the user
notify-send "Wi-Fi Manager" "Scanning networks..."

# Main loop: refresh menu every 3 seconds until a choice is made
while true; do
  wifi_list=$(get_wifi_list)

  chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u |
    rofi -dmenu -i --markup-rows -selected-row 1 -location 3 -p " Wi-Fi SSID: ")

  # Exit if canceled
  [[ -z "$chosen_network" ]] && break

  # Extract chosen SSID name (remove icon and ✔ if present)
  read -r chosen_id <<<"${chosen_network:3}"
  chosen_id=$(echo "$chosen_id" | sed 's/ ✔//')

  if [[ "$chosen_network" = "󰖩  Enable Wi-Fi" ]]; then
    nmcli radio wifi on
    sleep 2
  elif [[ "$chosen_network" = "󰖪  Disable Wi-Fi" ]]; then
    nmcli radio wifi off
    break
  else
    success_message="You are now connected to \"$chosen_id\"."

    # Check if it's a saved connection
    saved_connections=$(nmcli -g NAME connection)
    if echo "$saved_connections" | grep -qw "$chosen_id"; then
      nmcli connection up id "$chosen_id" | grep -q "successfully" &&
        notify-send "Connection Established" "$success_message"
    else
      # Prompt for password if secured
      if [[ "$chosen_network" =~ "" ]]; then
        wifi_password=$(rofi -dmenu -p "Password for $chosen_id: ")
      fi
      nmcli device wifi connect "$chosen_id" password "$wifi_password" |
        grep -q "successfully" && notify-send "Connection Established" "$success_message"
    fi

    break # Exit after trying to connect
  fi

  sleep 3 # Refresh delay
done
