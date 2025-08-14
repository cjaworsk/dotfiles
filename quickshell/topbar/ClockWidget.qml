import QtQuick
import QtQuick.Layouts
import Quickshell

import "../services/"
import "../themes/"

Item {
    id: root
    property bool borderless: false
    property bool showDate: true
    implicitWidth: rowLayout.implicitWidth
    implicitHeight: 32

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 4

        Text {
            font.pixelSize: 16
            color: Appearance.colors.red
            text: DateTime.time
        }

        Text {
            visible: root.showDate
            font.pixelSize: 10
            color: Appearance.colors.blue
            text: "•"
        }

        Text {
            visible: root.showDate
            font.pixelSize: 13
            color: Appearance.colors.teal
            text: DateTime.date
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton

        //ClockWidgetTooltip {
        //    hoverTarget: mouseArea
        //}
    }
}
