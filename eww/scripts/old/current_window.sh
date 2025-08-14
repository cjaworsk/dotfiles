#!/usr/bin/env bash

map_app_id() {
    case "$1" in
    "firefox") echo "󰈹 Firefox" ;;
    "kitty") echo "󰄛 Kitty Terminal" ;;
    "") echo "󰍹 Desktop" ;;
    *) echo "$1" ;;
    esac
}

last_output=""

while true; do
    swaymsg -t subscribe '["window"]' | jq -r '
    select(.change == "focus" or .change == "title")
    | .container.app_id // .container.window_properties.class // "Desktop"
  ' | while read -r app_id; do
        output=$(map_app_id "$app_id")
        if [[ "$output" != "$last_output" ]]; then
            echo "$output"
            last_output="$output"
        fi
    done

    # If we exit the inner loop (e.g., swaymsg disconnects), wait and try again
    sleep 1
done
