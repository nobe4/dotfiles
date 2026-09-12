import Quickshell
import Quickshell.Wayland
import QtQuick
import "../.."

Text {
    id: root

    required property bool active
    signal toggled

    width: parent.height

    color: Style.fg
    font.family: Style.fontFamily
    font.pixelSize: Style.fontSize
    leftPadding: 5
    rightPadding: 5
    verticalAlignment: Text.AlignVCenter
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
