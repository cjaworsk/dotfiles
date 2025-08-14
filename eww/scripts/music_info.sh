#!/bin/bash

TITLE=$(playerctl metadata title 2>/dev/null || echo "")
ARTIST=$(playerctl metadata artist 2>/dev/null || echo "")
ALBUM=$(playerctl metadata album 2>/dev/null || echo "")
POSITION=$(playerctl position 2>/dev/null || echo "0")
DURATION=$(playerctl metadata mpris:length 2>/dev/null || echo "0")

# Convert microseconds to seconds
DURATION_SEC=$(awk "BEGIN { print $DURATION / 1000000 }")

# Get progress as percentage
if (($(echo "$DURATION_SEC > 0" | bc -l))); then
    PERCENT=$(awk "BEGIN { printf \"%d\", 100 * $POSITION / $DURATION_SEC }")
else
    PERCENT=0
fi

echo "{ \"title\": \"$TITLE\", \"artist\": \"$ARTIST\", \"album\": \"$ALBUM\", \"progress\": $PERCENT }"
