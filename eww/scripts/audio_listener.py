#!/usr/bin/env python3
import subprocess
import re


def get_sink():
    info = subprocess.run(
        ["pactl", "get-default-sink"], capture_output=True, text=True
    ).stdout.strip()
    return info


def get_source():
    info = subprocess.run(
        ["pactl", "get-default-source"], capture_output=True, text=True
    ).stdout.strip()
    return info


def get_volume(sink):
    out = subprocess.run(
        ["pactl", "get-sink-volume", sink], capture_output=True, text=True
    ).stdout
    vol = re.search(r"(\d+)%", out)
    return int(vol.group(1)) if vol else 0


def is_muted(sink):
    out = subprocess.run(
        ["pactl", "get-sink-mute", sink], capture_output=True, text=True
    ).stdout
    return "yes" in out


def get_mic_muted(source):
    out = subprocess.run(
        ["pactl", "get-source-mute", source], capture_output=True, text=True
    ).stdout
    return "yes" in out


def emit_state():
    sink = get_sink()
    source = get_source()
    volume = get_volume(sink)
    muted = is_muted(sink)
    mic_muted = get_mic_muted(source)

    subprocess.run(["eww", "update", f"volume_level_static={volume}"])

    print(
        f'{{"volume": {volume}, "muted": {str(muted).lower()}, "mic_muted": {str(mic_muted).lower()} }}',
        flush=True,
    )


def main():
    emit_state()  # Emit initial state

    try:
        proc = subprocess.Popen(
            ["pactl", "subscribe"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )

        if proc.stdout is None:
            print("❌ Failed to capture stdout from pactl subscribe")
            return

        for line in proc.stdout:
            if any(key in line for key in ["sink", "source"]):
                emit_state()

    except Exception as e:
        print(f"❌ Error in pactl subscribe: {e}")


if __name__ == "__main__":
    main()
