#!/usr/bin/env python3
import i3ipc
import html
import os
import sys

# Mapping from app_id or class to icons + names
APP_MAP = {
    # Misc
    "kitty": "󰄛 Kitty Terminal",
    "firefox": "󰈹 Firefox",
    "microsoft-edge": "󰇩 Edge",
    "discord": " Discord",
    "vesktop": " Vesktop",
    "org.kde.dolphin": " Dolphin",
    "plex": "󰚺 Plex",
    "steam": " Steam",
    "spotify": "󰓇 Spotify",
    "ristretto": "󰋩 Ristretto",
    "obsidian": "󱓧 Obsidian",
    "rofi": " Rofi",
    "qBittorrent": " qBittorrent",
    "soundcloud-rpc": " Soundcloud",
    "": "󰍹 Desktop",
    # Browsers
    "google-chrome": " Google Chrome",
    "brave-browser": "󰖟 Brave Browser",
    "chromium": " Chromium",
    "opera": " Opera",
    "vivaldi": "󰖟 Vivaldi",
    "waterfox": "󰖟 Waterfox",
    "thorium": "󰖟 Thorium",
    "tor-browser": " Tor Browser",
    "floorp": "󰈹 Floorp",
    "zen": " Zen Browser",
    # Terminals
    "gnome-terminal": " GNOME Terminal",
    "konsole": " Konsole",
    "alacritty": " Alacritty",
    "wezterm": " Wezterm",
    "foot": "󰽒 Foot Terminal",
    "tilix": " Tilix",
    "xterm": " XTerm",
    "urxvt": " URxvt",
    "com.mitchellh.ghostty": "󰊠 Ghostty",
    "st": " st Terminal",
    # Development Tools
    "code": "󰨞 Visual Studio Code",
    "vscode": "󰨞 VS Code",
    "sublime-text": " Sublime Text",
    "atom": " Atom",
    "android-studio": "󰀴 Android Studio",
    "jetbrains-idea": " IntelliJ IDEA",
    "jetbrains-pycharm": " PyCharm",
    "jetbrains-webstorm": " WebStorm",
    "jetbrains-phpstorm": " PhpStorm",
    "eclipse": " Eclipse",
    "netbeans": " NetBeans",
    "docker": " Docker",
    "vim": " Vim",
    "neovim": " Neovim",
    "neovide": " Neovide",
    "emacs": " Emacs",
    # Communication Tools
    "slack": "󰒱 Slack",
    "telegram-desktop": " Telegram",
    "org.telegram.desktop": " Telegram",
    "whatsapp": "󰖣 WhatsApp",
    "teams": "󰊻 Microsoft Teams",
    "skype": "󰒯 Skype",
    "thunderbird": " Thunderbird",
    "signal": "󰭹 Signal",
    # File Managers
    "nautilus": "󰝰 Files (Nautilus)",
    "thunar": "󰝰 Thunar",
    "pcmanfm": "󰝰 PCManFM",
    "nemo": "󰝰 Nemo",
    "ranger": "󰝰 Ranger",
    "doublecmd": "󰝰 Double Commander",
    "krusader": "󰝰 Krusader",
    # Media Players
    "vlc": "󰕼 VLC Media Player",
    "mpv": " MPV",
    "rhythmbox": "󰓃 Rhythmbox",
    # Graphics Tools
    "gimp": " GIMP",
    "inkscape": " Inkscape",
    "krita": " Krita",
    "blender": "󰂫 Blender",
    # Video Editing
    "kdenlive": " Kdenlive",
    # Games and Gaming Platforms
    "lutris": "󰺵 Lutris",
    "heroic": "󰺵 Heroic Games Launcher",
    "minecraft": "󰍳 Minecraft",
    "csgo": "󰺵 CS:GO",
    "dota2": "󰺵 Dota 2",
    # Office and Productivity
    "evernote": " Evernote",
    "sioyek": " Sioyek",
    # Cloud Services and Sync
    "dropbox": "󰇣 Dropbox",
}


LOCKFILE = "/tmp/eww_current_window.lock"

if os.path.exists(LOCKFILE):
    with open(LOCKFILE, "r") as f:
        pid = f.read().strip()
    if pid and os.path.exists(f"/proc/{pid}"):
        sys.exit(0)  # Already running

with open(LOCKFILE, "w") as f:
    f.write(str(os.getpid()))


def get_label(app_id):
    return APP_MAP.get(app_id, f"󰍹 {app_id or 'Desktop'}")


def build_widget(label: str) -> str:
    escaped = html.escape(label)  # Just in case
    return f'(box :class "current-window" (label :text "{escaped}"))'


def emit(app_id: str):
    label = get_label(app_id)
    widget = build_widget(label)
    print(widget, flush=True)


def main():
    ipc = i3ipc.Connection()

    def update(ipc, e=None):
        focused = ipc.get_tree().find_focused()
        if focused and not focused.floating_nodes and focused.name:
            app_id = focused.app_id or focused.window_class or ""
        else:
            app_id = ""
        emit(app_id)

    update(ipc)  # Emit once on startup
    ipc.on("window", update)
    ipc.on("workspace", update)
    ipc.main()


if __name__ == "__main__":
    main()
