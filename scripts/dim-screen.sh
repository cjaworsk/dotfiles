#!/bin/bash

#dim the screen if no media or games active
if[[ -z $(pidof mpv) && -z $(pidof gamescope) ]]; then
  brightnessctl set 20%
fi

