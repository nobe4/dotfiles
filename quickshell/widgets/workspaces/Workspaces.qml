pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import QtQuick
import "../.."

Item {
    id: root

    implicitWidth: parent.width
    implicitHeight: parent.height

    Row {
        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                id: workspace
                required property var modelData

                readonly property color backgroundColor: {
                    if (workspaceMouse.containsMouse)
                        return Style.fg;
                    if (modelData.urgent)
                        return Style.red;
                    if (modelData.active)
                        return Style.grey;
                    return Style.bg;
                }
                readonly property color foregroundColor: workspaceMouse.containsMouse || modelData.urgent || modelData.active ? Style.bg : Style.fg

                implicitWidth: root.height
                implicitHeight: root.height
                color: backgroundColor

                MouseArea {
                    id: workspaceMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: workspace.modelData.activate()
                }

                Text {
                    anchors.centerIn: parent
                    text: workspace.modelData.name
                    color: workspace.foregroundColor
                    font.family: Style.fontFamily
                    font.pixelSize: Style.fontSize
                }
            }
        }
    }
}
