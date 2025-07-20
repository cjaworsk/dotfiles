#!/usr/bin/python

import subprocess

icons = ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]


def get_battery_capacity():
    try:
        with open("/sys/class/power_supply/BAT0/capacity", "r") as f:
            return int(f.read().strip())
    except Exception as e:
        print(f"Error reading battery capacity: {e}")
        return 0


def main():
    # icons = ["", "", "", "", "", "", "", "", "", ""]
    capacity = get_battery_capacity()
    index = capacity // 10
    if index > 9:
        index = 9
    icon = icons[index]

    # Update eww variable
    subprocess.run(["eww", "update", f"battery_icon={icon}"])


if __name__ == "__main__":
    main()
