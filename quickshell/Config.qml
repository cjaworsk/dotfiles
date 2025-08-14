pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var colors: themes[themes[settings.currentTheme] == null ? 'default' : settings.currentTheme]
    property var themes: {
        "default": {
            "shadow": "#45475a",
            "highlight": "#efefef",
            "urgent": "#ff723e",
            "accent": "#207874",
            "text-alt":"#11111b",
            "outline": "#000000",
            "outlineGradientFade": "#161616",
            "defaultWallpaperPath": "/home/cjaws/Pictures/Wallpapers/nord-background-main/16.png",
            "rosewater": "#f5e0dc",
            "flamingo": "#f2cdcd",
            "pink": "#f5c2e7",
            "mauve": "#cba6f7",
            "red": "#f38ba8",
            "maroon": "#eba0ac",
            "peach": "#fab387",
            "yellow": "#f9e2af",
            "green": "#a6e3a1",
            "teal": "#94e2d5",
            "sky": "#89dceb",
            "sapphire": "#74c7ec",
            "blue": "#89b4fa",
            "lavender": "#b4befe",
            "text": "#cdd6f4",
            "subtext1": "#bac2de",
            "subtext0": "#a6adc8",
            "overlay2": "#9399b2",
            "overlay1": "#7f849c",
            "overlay0": "#6c7086",
            "surface2": "#585b70",
            "surface1": "#45475a",
            "surface0": "#313244",
            "base": "#1e1e2e",
            "mantle": "#181825",
            "crust": "#11111b",
        }
    }

    property bool openSettingsWindow: false

    property alias settings: settingsJsonAdapter.settings
    FileView {
        path: Qt.resolvedUrl("./settings.json")
        // when changes are made on disk, reload the file's content
        watchChanges: true
        onFileChanged: reload()
        // when changes are made to properties in the adapter, save them
        onAdapterUpdated: writeAdapter()

        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        JsonAdapter {
            id: settingsJsonAdapter
            property JsonObject settings: JsonObject {
                property string version: "0.1"
                property bool militaryTimeClockFormat: true
                property string systemProfileImageSource: "/home/cjaws/.face/cjaws.png"
                property string currentTheme: "default"
                property bool setWallpaperToThemeWallpaper: true
                property JsonObject execCommands: JsonObject {
                    property string terminal: "kitty"
                    property string files: "nemo"
                }
                property JsonObject systemDetails: JsonObject {
                    property string osName: "Linux Distro"
                    property string osVersion: "Distro Version"
                    property string ram: "Ram"
                    property string cpu: "CPU Name"
                    property string gpu: "GPU Name"
                }
                property JsonObject bar: JsonObject {
                    property int fontSize: 12
                    property int trayIconSize: 16
                    property bool monochromeTrayIcons: true
                }

                onCurrentThemeChanged: {
                    console.info("Updated theme to: " + currentTheme);
                }
            }
        }
    }
}
