#!/bin/bash
swaymsg -t get_workspaces | jq -c '
  map({
    num: .num,
    name: .name,
    focused: .focused
  }) | 
  map("(map num " + (.num|tostring) + ") (map name \"" + .name + "\") (map focused " + (if .focused then "true" else "false" end) + ")") | 
  join(" ")
'
