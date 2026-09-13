import Quickshell
import QtQuick
import ".."

PopupWindow {
    id: root

    required property bool triggerHovered
    property int hoverDelay: 150
    property bool popupOpen: false

    anchor.rect.x: 0
    anchor.rect.y: 0
    anchor.rect.width: anchor.item?.width ?? 1
    anchor.rect.height: (anchor.item?.height ?? 0) + 1
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom
    color: Style.bg
    visible: root.popupOpen

    function close() {
        hoverTimer.stop();
        root.popupOpen = false;
    }

    onTriggerHoveredChanged: {
        if (triggerHovered) {
            hoverTimer.stop();
            root.popupOpen = true;
        } else if (root.popupOpen) {
            hoverTimer.restart();
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: Style.grey
    }

    HoverHandler {
        id: popupHover

        onHoveredChanged: {
            if (hovered) {
                hoverTimer.stop();
            } else if (root.popupOpen) {
                hoverTimer.restart();
            }
        }
    }

    Timer {
        id: hoverTimer

        interval: root.hoverDelay
        onTriggered: {
            if (!root.triggerHovered && !popupHover.hovered)
                root.popupOpen = false;
        }
    }
}
