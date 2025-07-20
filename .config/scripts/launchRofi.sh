#!/bin/bash

if pgrep rofi >/dev/null 2>&1; then
  killall rofi
else
  rofi -show drun
fi
