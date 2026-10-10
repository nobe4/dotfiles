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
        color: root.enabled && root.hovered ? Style.bg : root.textColor
        font.family: Style.fontFamily
        font.pixelSize: Style.fontSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: root.text
        textFormat: Text.PlainText
        elide: Text.ElideRight
    }

    background: Rectangle {
        color: root.down
            ? Style.grey
            : root.enabled && root.hovered ? Style.fg : Style.bg
        border.color: root.enabled && root.hovered ? Style.fg : Style.grey
        radius: 3
    }

    HoverHandler {
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
