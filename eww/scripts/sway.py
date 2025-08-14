#!/usr/bin/env python3
import json
import subprocess
import sys

Icons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
HideUnoccupied = True
NumWorkspaces = 10


def get_workspace_line():
    try:
        result = subprocess.run(
            ["swaymsg", "-t", "get_workspaces"],
            stdout=subprocess.PIPE,
            text=True,
            check=True,
        )
        workspaces = json.loads(result.stdout)
    except Exception as e:
        print("Error getting worspaces:", e)
        sys.exit(1)

    line = ""
    for i in range(1, NumWorkspaces + 1):
        found = False
        for ws in workspaces:
            if ws["num"] == i:
                line += ("F" if ws["focused"] else "O") + str(i) + ":"
                found = True
                break
        if not found:
            line += "U" + str(i) + ":"

    return line.rstrip(":")


def format_eww_literal(line):
    output = ""
    segments = line.split(":")

    for i, token in enumerate(segments):
        if i >= len(Icons):
            break

        icon = Icons[i]
        name = str(i + 1)

        if token.startswith("F"):
            class_name = "active"
        elif token.startswith("O"):
            class_name = "inactive"
        elif token.startswith("U"):
            if HideUnoccupied:
                continue
            class_name = "empty"
        else:
            class_name = "unknown"

        output += f' (button :class "{class_name}" :onclick "swaymsg workspace {name}" "{icon}")'

    print(f'(box :orientation "h" :class "workspaces"{output})')
    sys.stdout.flush()


def subscribe_to_sway():
    # Initial call
    line = get_workspace_line()
    format_eww_literal(line)

    process = subprocess.Popen(
        ["swaymsg", "-t", "subscribe", "-m", '[ "workspace" ]'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )

    if process.stdout is None:
        print("Error: stdout is None")
        sys.exit(1)

    try:
        for _ in process.stdout:
            line = get_workspace_line()
            format_eww_literal(line)
    except KeyboardInterrupt:
        process.terminate()
        sys.exit(0)


if __name__ == "__main__":
    subscribe_to_sway()
