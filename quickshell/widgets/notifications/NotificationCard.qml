pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQml
import "../.."
import "../../utils"

Rectangle {
    id: root

    required property Notification notification

    readonly property bool critical: notification.urgency === NotificationUrgency.Critical
    readonly property int timeout: notification.expireTimeout
    readonly property NotificationAction defaultAction: notification.actions.find(function (action) {
        return action.identifier === "default";
    }) ?? null
    readonly property var visibleActions: notification.actions.filter(function (action) {
        return action.identifier !== "default";
    })

    implicitHeight: content.implicitHeight + 10
    color: {
        if (root.critical)
            return Style.red;
        return root.notification.urgency === NotificationUrgency.Low ? Style.bg : Style.blue;
    }

    Accessible.role: Accessible.AlertMessage
    Accessible.name: notification.summary
    Accessible.description: notification.body

    function restartTimeout() {
        expiry.stop();
        if (root.timeout > 0 && !root.critical && !hover.hovered)
            expiry.start();
    }

    Component.onCompleted: restartTimeout()

    HoverHandler {
        id: hover
        onHoveredChanged: root.restartTimeout()
    }

    Timer {
        id: expiry

        interval: Math.max(1, root.timeout)
        onTriggered: root.notification.expire()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        enabled: root.defaultAction !== null
        cursorShape: Qt.PointingHandCursor
        onClicked: root.defaultAction.invoke()
    }

    TapHandler {
        acceptedButtons: Qt.RightButton
        onTapped: root.notification.dismiss()
    }

    Column {
        id: content

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 5
        }
        spacing: 8

        Row {
            width: parent.width
            spacing: 8

            Image {
                id: icon

                width: 32
                height: 32
                visible: source.toString() !== ""
                fillMode: Image.PreserveAspectFit
                source: {
                    if (root.notification.image)
                        return root.notification.image;
                    const appIcon = root.notification.appIcon;
                    if (!appIcon || appIcon.startsWith("/") || appIcon.startsWith("file:"))
                        return appIcon;
                    return Quickshell.iconPath(appIcon);
                }
            }

            Text {
                width: parent.width - (icon.visible ? icon.width + parent.spacing : 0)
                height: parent.height
                color: Style.fg
                font.family: Style.fontFamily
                font.pixelSize: Style.fontSize
                text: root.notification.appName
                textFormat: Text.PlainText
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
        }

        Text {
            width: parent.width
            visible: text !== ""
            color: Style.fg
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            font.bold: true
            text: root.notification.summary
            textFormat: Text.PlainText
            wrapMode: Text.Wrap
        }

        Text {
            width: parent.width
            visible: text !== ""
            color: Style.fg
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            text: root.notification.body
            textFormat: Text.PlainText
            wrapMode: Text.Wrap
        }

        Flow {
            id: actions

            width: parent.width
            spacing: 6
            visible: root.visibleActions.length > 0
            Repeater {
                model: root.visibleActions

                delegate: ActionButton {
                    required property NotificationAction modelData

                    width: Math.min(actions.width, Math.max(70, implicitContentWidth + 20))
                    text: modelData.text || modelData.identifier
                    onClicked: modelData.invoke()
                }
            }
        }
    }
}
