import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io

import "AppMap.qml" as AppMap
import "../themes"

Item {
  id: root
  width: parent ? parent.width : 100
  height: 24

  // Reference to current active toplevel
  property var activeToplevel: Hyprland.activeToplevel

  Text {
    elide: Text.ElideRight
    font.pixelSize: 14
    color: Appearance.colors.peach
    //text: AppMap.getAppLabel(activeTopLevel?.appid)
    text: activeToplevel?.title || "Desktop"  // Fallback if null

  }

  // Automatically update when the active window changes
  Connections {
    target: Hyprland
    onActiveToplevelChanged: {
      root.activeToplevel = Hyprland.activeToplevel
    }
  }
}

