import QtQuick
import QtQuick.Controls
import ".."

Column {
    id: root

    required property var node
    property string label: ""
    required property string icon
    property bool selectable: false
    property bool selected: false
    property bool selectionEnabled: true
    readonly property int volume: node?.ready && node?.audio ? Math.round(node.audio.volume * 100) : 0
    readonly property bool muted: node?.ready && node?.audio ? node.audio.muted : false
    signal selectionToggled

    spacing: 3

    Text {
        visible: root.label !== ""
        width: parent.width
        color: Style.fg
        elide: Text.ElideRight
        font.family: Style.fontFamily
        font.pixelSize: Style.fontSize
        text: root.label
    }

    Row {
        width: parent.width
        height: 24
        spacing: 8

        Slider {
            id: slider

            width: parent.width - volumeText.width - selectButton.width - muteButton.width
                - parent.spacing * (root.selectable ? 3 : 2)
            height: parent.height
            enabled: root.node?.ready && root.node?.audio
            from: 0
            to: 1
            value: enabled ? root.node.audio.volume : 0
            onMoved: root.node.audio.volume = value

            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }

            background: Rectangle {
                x: slider.leftPadding
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                width: slider.availableWidth
                height: 4
                color: Style.grey
                radius: 2

                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: Style.blue
                    radius: parent.radius
                }
            }

            handle: Rectangle {
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                width: 12
                height: 12
                color: slider.pressed ? Style.fg : Style.blue
                radius: 6
            }
        }

        Text {
            id: volumeText

            width: 36
            height: parent.height
            color: Style.fg
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            text: root.volume + "%"
        }

        ActionButton {
            id: muteButton

            width: parent.height
            height: parent.height
            enabled: root.node?.ready && root.node?.audio
            text: root.icon
            textColor: root.muted ? Style.red : Style.fg
            onClicked: root.node.audio.muted = !root.node.audio.muted
        }

        ActionButton {
            id: selectButton

            visible: root.selectable
            width: root.selectable ? parent.height : 0
            height: parent.height
            enabled: root.selectionEnabled && root.node?.ready && root.node?.audio
            text: root.selected ? "✓" : "+"
            textColor: root.selected ? Style.blue : Style.fg
            onClicked: root.selectionToggled()
        }
    }
}
