#!/bin/bash

pactl get-source-mute @DEFAULT_SOURCE@ | grep -o 'yes\|no'

pactl subscribe | rg --line-buffered "on source" | while read -r _; do
    pactl get-source-mute @DEFAULT_SOURCE@ | grep -o 'yes\|no'
done
