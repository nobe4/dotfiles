pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "./widgets/clock/"
import "./widgets/idle/"
import "./widgets/indicators/"
import "./widgets/stats/"
import "./widgets/tray/"
import "./widgets/volume/"
import "./widgets/weather/"
import "./widgets/wifi/"
import "./widgets/workspaces/"

Variants {
    id: root

    property bool idleInhibited: false

    model: Quickshell.screens

    PanelWindow {
        id: window
        required property var modelData
        screen: modelData

        implicitHeight: 26
        color: Style.bg

        anchors {
            top: true
            left: true
            right: true
        }

        Workspaces {}

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            spacing: 10

            Indicators {
                height: parent.height
            }

            Clock {
                height: parent.height
            }

            Weather {
                height: parent.height
            }
        }

        Row {
            anchors.right: parent.right
            height: parent.height

            Tray {
                height: parent.height
            }

            Volume {
                height: parent.height
            }

            Stats {
                height: parent.height
            }

            Wifi {
                height: parent.height
            }

            Idle {
                height: parent.height
                active: root.idleInhibited
                onToggled: root.idleInhibited = !root.idleInhibited
            }
        }
    }
}
