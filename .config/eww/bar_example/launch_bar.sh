#!/bin/bash

## Files and cmd
FILE="$HOME/.cache/eww_launch.xyz"
EWW="eww -c $HOME/.config/eww/bar"

## Run eww daemon if not running already
if [[ ! $(pidof eww) ]]; then
  ${EWW} daemon
  sleep 1
fi

## Open widgets
run_eww() {
  ${EWW} open-many \
    bar

}

if [[ ! -f "$FILE" ]]; then
  touch "$FILE"
  eww -c ~/.config/eww/bar open bar
else
  eww -c ~/.config/eww/bar close-all
  rm "$FILE"
fi
