#!/bin/bash
swaymsg -t get_workspaces | jq -r '
  map({
    num: .num,
    name: .name,
    focused: .focused
  }) as $workspaces
  | "(" + ($workspaces | map(
    "(map num " + (.num|tostring) + ") (map name \"" + (.name|gsub("\""; "\\\"")) + "\") (map focused " + (if .focused then "true" else "false" end) + ")"
  ) | join(") (")) + ")"
'
