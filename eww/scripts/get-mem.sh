#!/bin/bash

#printf "%.0f\n" $(free -m | grep Mem | awk '{print ($3/$2)*100}')

read total used <<<$(free -m | awk '/Mem:/ { print $2, $3 }')

if [ -n "$total" ] && [ "$total" -gt 0 ]; then
  printf "%.2f\n" "$(echo "$used / $total * 100" | bc -l)"
else
  echo "0.0"
fi
