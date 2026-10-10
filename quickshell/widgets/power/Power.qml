import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import "../.."
import "../../utils"

BarIcon {
    id: root

    required property bool active
    property string powerError: ""
    signal toggled

    function runPowerAction(action) {
        if (powerAction.running)
            return;

        root.powerError = "";
        powerAction.command = ["systemctl", action];
        powerAction.running = true;
    }

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
        id: powerMouse

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggled()
    }

    HoverPopup {
        anchor.item: root
        implicitWidth: powerColumn.implicitWidth
        implicitHeight: powerColumn.implicitHeight
        triggerHovered: powerMouse.containsMouse

        Column {
            id: powerColumn

            anchors.fill: parent

            Repeater {
                model: [
                    {
                        action: "poweroff",
                        label: "  Shutdown"
                    },
                    {
                        action: "reboot",
                        label: "  Restart"
                    },
                    {
                        action: "hibernate",
                        label: "󰒲  Hibernate"
                    }
                ]

                ActionButton {
                    required property var modelData

                    width: 180
                    height: 36
                    enabled: !powerAction.running
                    text: modelData.label
                    onClicked: root.runPowerAction(modelData.action)
                }
            }

            Text {
                visible: root.powerError !== ""
                width: 180
                color: Style.red
                font.family: Style.fontFamily
                font.pixelSize: Style.fontSize
                text: root.powerError
                wrapMode: Text.Wrap
            }
        }
    }

    Process {
        id: powerAction

        stderr: StdioCollector {
            id: powerError
        }
        onExited: function (exitCode) {
            if (exitCode !== 0)
                root.powerError = powerError.text.trim() || "Power action failed.";
        }
    }
}
