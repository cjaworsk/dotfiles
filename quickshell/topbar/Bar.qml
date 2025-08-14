import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "../themes/"
import "../services/"

Scope {
    PanelWindow {
        id: taskbar
        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 35
        color: Appearance.colors.baseTransparent

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.width: 2
            border.color: Appearance.colors.crust
        }

        RowLayout {
            anchors.fill: parent
            Layout.alignment: Qt.AlignVCenter
            spacing: 10

            // LEFT SECTION: Workspaces + Window title
            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                Workspaces { 
                    id: workspaces
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: implicitWidth
                }
                ActiveWindow {
                    id: activewindow
                    Layout.leftMargin: 25
                    Layout.fillWidth: false
                    Layout.minimumWidth: 20
                }
            }

            // CENTER SECTION: Clock
            Item { Layout.fillWidth: true } // Spacer
            ClockWidget { Layout.alignment: Qt.AlignCenter }

            // RIGHT SECTION: System Tray & other modules
            Item { Layout.fillWidth: true } // Spacer
            RowLayout {
                spacing: 8
                Layout.alignment: Qt.AlignVCenter

                // Example placeholder
                Rectangle {
                    width: 20
                    height: 20
                    radius: 4
                    color: Appearance.colors.red
                }
                // SysTray { id: sysTray }
            }
        }
    }
}

