#!/bin/bash

if pgrep wofi >/dev/null 2>&1; then
  killall wofi
else
  wofi --show drun
fi
