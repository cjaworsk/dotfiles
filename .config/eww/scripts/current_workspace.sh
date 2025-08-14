#!/bin/bash
# ~/.config/eww/scripts/workspace_buttons.sh

TEMP_FILE="/tmp/current-workspace"

{
  echo "(box :orientation \"horizontal\" :spacing 6 :class \"workspaces\""
  swaymsg -t get_workspaces | jq -c '.[]' | while read -r ws; do
    name=$(echo "$ws" | jq -r '.name')
    focused=$(echo "$ws" | jq -r '.focused')
    visible=$(echo "$ws" | jq -r '.visible')
    urgent=$(echo "$ws" | jq -r '.urgent')

    class=""
    [ "$focused" == "true" ] && class="focused"
    [ "$visible" == "true" ] && class="visible"
    [ "$urgent" == "true" ] && class="urgent"

    # Show only non-empty or active
    if [ -n "$class" ]; then
      echo "  (button :class \"$class\" :onclick \"swaymsg workspace $name\" \"●\")"
    fi
  done
  echo ")"
} >"$TEMP_FILE"
