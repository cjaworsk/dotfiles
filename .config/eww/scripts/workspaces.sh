#!/bin/bash

echo '(box :orientation "h"'

for i in {1..6}; do
  data=$(swaymsg -t get_workspaces | jq -r --argjson num "$i" '
    .[] | select(.num == $num) |
    {
      focused: .focused,
      urgent: .urgent,
      occupied: (.representation != null)
    }' 2>/dev/null)

  # Default values
  icon="○"
  class="empty"

  if [[ -n "$data" ]]; then
    focused=$(jq -r '.focused' <<<"$data")
    urgent=$(jq -r '.urgent' <<<"$data")
    occupied=$(jq -r '.occupied' <<<"$data")

    if [[ "$focused" == "true" ]]; then
      icon="◉"
      class="focused"
    elif [[ "$urgent" == "true" ]]; then
      icon="⚠"
      class="urgent"
    elif [[ "$occupied" == "true" ]]; then
      icon="●"
      class="occupied"
    fi
  fi

  echo "  (button :class \"$class\" :onclick \"swaymsg workspace $i\" (label :text \"$icon\"))"
done

echo ')'
