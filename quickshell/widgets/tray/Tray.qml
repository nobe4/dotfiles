pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick

Row {
    spacing: 5

    Repeater {
        model: SystemTray.items

        delegate: Item {
            id: trayItem
            required property SystemTrayItem modelData

            width: 17
            height: parent.height

            Image {
                anchors.centerIn: parent
                width: 17
                height: 17
                source: trayItem.modelData.icon
                fillMode: Image.PreserveAspectFit
            }

            QsMenuAnchor {
                id: trayMenu
                menu: trayItem.modelData.menu
                anchor.item: trayItem
                anchor.edges: Edges.Bottom
                anchor.gravity: Edges.Bottom
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor

                onClicked: function (mouse) {
                    const item = trayItem.modelData;
                    const menuOnly = item.onlyMenu || item.id === "steam";
                    const openMenu = mouse.button === Qt.RightButton || menuOnly;
                    if (openMenu && item.hasMenu)
                        trayMenu.open();
                    else
                        item.activate();
                }
            }
        }
    }
}
