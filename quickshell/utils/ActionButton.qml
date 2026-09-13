import QtQuick
import QtQuick.Controls as Controls
import ".."

Controls.Button {
    id: root

    property color textColor: Style.fg

    implicitHeight: 24
    hoverEnabled: true
    opacity: root.enabled ? 1 : 0.5

    contentItem: Text {
        color: root.textColor
        font.family: Style.fontFamily
        font.pixelSize: Style.fontSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: root.text
    }

    background: Rectangle {
        color: root.down
            ? Style.grey
            : root.hovered ? Qt.lighter(Style.bg, 1.5) : Style.bg
        border.color: Style.grey
        radius: 3
    }

    HoverHandler {
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
