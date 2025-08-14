#!/bin/bash

# Initial workspace state
workspaces='[]'

swaymsg -t subscribe '[ "workspace" ]' | while read -r line; do
  # Parse event JSON to extract workspace info
  # For simplicity, re-generate full workspace state here
  workspaces=$(swaymsg -t get_workspaces | jq 'map({
    num,
    focused,
    urgent,
    occupied: (.representation != null),
    icon: (if .focused then "◉" elif .urgent then "⚠" elif (.representation != null) then "●" else "○" end),
    class: (if .focused then "focused" elif .urgent then "urgent" elif (.representation != null) then "occupied" else "empty" end)
  })')

  # Update eww variable with new workspace info
  eww update workspaces="$workspaces"
done
