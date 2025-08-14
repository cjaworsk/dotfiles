import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../themes/"

RowLayout {
    id: root
    spacing: 10
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    // Assume 'taskbar' is a global or passed-in property for current screen context
    // Use your own screen reference or monitor if needed

    // Reactive list of workspaces for current monitor (or all if not ready)
    readonly property var workspacesForScreen: {
        if (taskbar && taskbar.screen && taskbar.screen.name) {
            return Hyprland.workspaces.values.filter(w => w.monitor?.name === taskbar.screen.name)
        }
        return Hyprland.workspaces.values
    }

    // Reactive current focused workspace id
    readonly property int focusedWsId: Hyprland.focusedWorkspace.id

    Repeater {
        model: root.workspacesForScreen

        Button {
            id: wsButton
            
            padding: 4
            //Workspace number text
            contentItem: Text {
                text: modelData.id
                anchors.centerIn: wsBack
                font.family: Appearance.settings.font
                font.pixelSize: Appearance.settings.fontSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: modelData.id === root.focusedWsId
                    ? Appearance.colors.crust
                    : Appearance.colors.teal
            }
            
            //Workspace background squares
            background: Rectangle {
                id: wsBack
                border.width: 2
                border.color: Appearance.colors.teal
                width: 24
                height: 28
                color: modelData.id === root.focusedWsId
                    ? Appearance.colors.teal
                    : Appearance.colors.surface0
                    radius: 5
            }

            onPressed: {
                Hyprland.dispatch(`workspace ${modelData.id}`)
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}

