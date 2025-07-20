#!/bin/bash

# Build JSON string
json="["

for i in {1..6}; do
  info=$(swaymsg -t get_workspaces | jq -r --argjson n "$i" '
    .[] | select(.num == $n) | {
      focused, urgent,
      occupied: (.representation != null)
    }' 2>/dev/null)

  if [[ -n "$info" ]]; then
    focused=$(jq -r .focused <<<"$info")
    urgent=$(jq -r .urgent <<<"$info")
    occupied=$(jq -r .occupied <<<"$info")

    if [[ "$focused" == "true" ]]; then
      icon="◉"
      class="focused"
    elif [[ "$urgent" == "true" ]]; then
      icon="⚠"
      class="urgent"
    elif [[ "$occupied" == "true" ]]; then
      icon="●"
      class="occupied"
    else
      icon="○"
      class="empty"
    fi
  else
    icon="○"
    class="empty"
  fi

  entry="{\"num\": $i, \"class\": \"$class\", \"icon\": \"$icon\"}"
  json+="$entry"

  [[ "$i" -lt 6 ]] && json+=","
done

json+="]"

# Update Eww variable
eww update workspaces="$json"

echo "$json"
