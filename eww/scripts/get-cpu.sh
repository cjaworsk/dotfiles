#!/bin/bash

# returns a value between 0.0 and 1.0 for circular widget
#printf "%.0f\n" $(top -bn1 | grep "Cpu(s)" | awk -F ',' '{print $4 } | awk {print $1})')

# Extract %idle from top
idle=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print $4}' | awk '{print $1}')

# Clean up the value (remove % or anything weird)
idle_clean=$(echo "$idle" | sed 's/[^0-9.]//g')

#echo "scale=4; (100 - $idle_clean)" | bc -l

# Safety check and output normalized usage
if [[ -n "$idle_clean" ]]; then
  echo "scale=4; (100 - $idle_clean)" | bc -l
else
  echo "0.0"
fi
