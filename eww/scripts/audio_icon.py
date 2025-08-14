#!/usr/bin/env python3

import subprocess
import sys
import os
import html
import re

LOCKFILE = "/tmp/eww_audio_icon.lock"

# Prevent multiple instances
if os.path.exists(LOCKFILE):
    with open(LOCKFILE, "r") as f:
        pid = f.read().strip()
    if pid and os.path.exists(f"/proc/" + pid):
        sys.exit(0)

with open(LOCKFILE, "w") as f:
    f.write(str(os.getpid()))


def get_active_port() -> str | None:
    try:
        # Get pactl sink info
        output = subprocess.check_output(["pactl", "list", "sinks"], text=True)
    except subprocess.CalledProcessError:
        return None

    # Split into sinks
    sinks = output.split("Sink #")
    for sink in sinks:
        if (
            "State: RUNNING" in sink
            or "State: IDLE" in sink
            or "State: SUSPENDED" in sink
        ):
            # Find the active port line
            match = re.search(r"Active Port:\s*(.*)", sink)
            if match:
                return match.group(1).strip()
    return None


def icon_for_port(port: str | None) -> str:
    if not port:
        return "󰍬"  # fallback

    port = port.lower()
    if "headphone" in port:
        return ""
    elif "speaker" in port:
        return ""
    elif "a2dp" in port or "bluez" in port:
        return "󰂯"
    elif "hdmi" in port:
        return "󰓃"
    return "󰍬"  # fallback


def build_widget(icon: str) -> str:
    return f'(box :class "volume_icon" :valign "center" (label :valign "center" :text "{html.escape(icon)}"))'


# return f'(label :yalign 1 :class "volume_icon" :text "{icon}")'


def emit():
    try:
        port = get_active_port()
        icon = icon_for_port(port)
        print(build_widget(icon), flush=True)
    except Exception:
        print(build_widget("󰍬"), flush=True)  # fallback


def watcher():
    emit()  # Initial
    try:
        proc = subprocess.Popen(
            ["pactl", "subscribe"], stdout=subprocess.PIPE, text=True
        )
        if proc.stdout is None:
            return
        for line in proc.stdout:
            if "sink" in line.lower() or "server" in line.lower():
                emit()
    except Exception:
        pass


def main():
    try:
        watcher()
    finally:
        if os.path.exists(LOCKFILE):
            os.remove(LOCKFILE)


if __name__ == "__main__":
    main()
