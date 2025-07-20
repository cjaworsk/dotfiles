import re
import sys

# ANSI escape codes for truecolor
def color_swatch(hex_code, text="     "):
    if not re.match(r"#?[0-9a-fA-F]{6}", hex_code):
        return ""
    hex_code = hex_code.lstrip("#")
    r, g, b = tuple(int(hex_code[i:i+2], 16) for i in (0, 2, 4))
    return f"\033[48;2;{r};{g};{b}m{text}\033[0m"

# Load file from argument
if len(sys.argv) < 2:
    print("Usage: python theme.py <theme.conf>")
    sys.exit(1)

theme_path = sys.argv[1]

try:
    with open(theme_path, "r") as f:
        lines = f.readlines()
except FileNotFoundError:
    print(f"File not found: {theme_path}")
    sys.exit(1)

print(f"\n🎨 Previewing theme: {theme_path}\n")

# Regex to match lines like "key #hex" or "key     #hex"
color_line_re = re.compile(r"^([a-zA-Z0-9_]+)\s+(#(?:[0-9a-fA-F]{6}))")

for line in lines:
    line = line.strip()
    if not line or line.startswith("#"):
        continue

    match = color_line_re.match(line)
    if match:
        key, hex_code = match.groups()
        print(f"{key:<25} {hex_code} {color_swatch(hex_code)}")

