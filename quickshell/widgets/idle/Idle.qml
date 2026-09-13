import Quickshell
import Quickshell.Wayland
import QtQuick
import "../.."
import "../../utils"

BarIcon {
    id: root

    required property bool active
    signal toggled

    text: root.active ? "" : ""

    Rectangle {
        anchors.fill: parent
        color: root.active ? Style.red : Style.bg
        z: -1
    }

    IdleInhibitor {
        window: root.QsWindow.window
        enabled: root.active
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggled()
    }
}
