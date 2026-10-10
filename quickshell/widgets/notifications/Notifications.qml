pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Controls as Controls

Scope {
    NotificationServer {
        id: server

        actionsSupported: true
        imageSupported: true

        onNotification: function (notification) {
            notification.tracked = true;
        }
    }

    PanelWindow {
        id: root

        screen: Quickshell.screens[0] ?? null
        visible: screen !== null && server.trackedNotifications.values.length > 0
        color: "transparent"
        exclusiveZone: 0
        implicitWidth: 300
        implicitHeight: Math.min(notificationColumn.implicitHeight, Math.max(1, (screen?.height ?? 1) - 26))

        anchors {
            top: true
            right: true
        }

        Controls.ScrollView {
            id: scroll

            anchors.fill: parent
            contentWidth: availableWidth
            contentHeight: notificationColumn.implicitHeight
            clip: true

            Controls.ScrollBar.horizontal.policy: Controls.ScrollBar.AlwaysOff
            Controls.ScrollBar.vertical.policy: Controls.ScrollBar.AsNeeded

            Column {
                id: notificationColumn

                width: scroll.availableWidth
                spacing: 2

                Repeater {
                    model: server.trackedNotifications

                    delegate: NotificationCard {
                        required property Notification modelData

                        width: notificationColumn.width
                        notification: modelData
                    }
                }
            }
        }
    }
}
