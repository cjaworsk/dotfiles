#!/usr/bin/python

import subprocess

# Run wpctl and capture the output
output = subprocess.run(
    ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"], capture_output=True, text=True
)

# Parse the float value from the output
volume_str = output.stdout.strip().split()[1]  # "Volume: 0.30" → "0.30"
volume = float(volume_str)  # Now it's 0.30

# Convert to percentage
volume_percent = int(volume * 100)

# Choose an icon based on volume level
if volume == 0:
    icon = "󰝟"  # Muted
elif volume < 0.33:
    icon = ""  # Low
elif volume < 0.66:
    icon = ""  # Medium
else:
    icon = ""  # High

# Output something Eww or Waybar could use
print(f"{icon}")  # {volume_percent}% if needed
