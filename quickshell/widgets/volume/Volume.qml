import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import "../.."
import "../../utils"

BarIcon {
    id: root

    property PwNode sink: Pipewire.defaultAudioSink
    readonly property int volume: sink?.ready && sink?.audio ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool muted: sink?.ready && sink?.audio ? sink.audio.muted : false
    readonly property var audioStreams: Pipewire.nodes.values.filter(function (node) {
        return node.isStream && node.audio !== null;
    })
    readonly property var playbackStreams: root.activeStreams(PwNodeType.AudioOutStream)

    function activeStreams(streamType) {
        const streams = [];

        for (const link of Pipewire.linkGroups.values) {
            if (link.state !== PwLinkState.Active)
                continue;

            const nodes = [link.source, link.target];
            for (const node of nodes) {
                if (node && (node.type & streamType) === streamType && streams.indexOf(node) === -1)
                    streams.push(node);
            }
        }

        return streams;
    }

    function streamName(stream) {
        const app = stream.properties["application.name"] || stream.description || stream.name;
        const media = stream.properties["media.name"];
        return media ? app + ": " + media : app;
    }

    function volumeIcon(volume, muted) {
        if (muted)
            return "";

        return volume > 66 ? "" : volume > 33 ? "" : "";
    }

    PwObjectTracker {
        objects: root.audioStreams.concat(root.sink ? [root.sink] : [])
    }

    PwObjectTracker {
        objects: Pipewire.linkGroups.values
    }

    color: root.muted ? Style.red : Style.fg
    text: root.volumeIcon(root.volume, root.muted)

    MouseArea {
        id: volumeMouse

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onWheel: function (wheel) {
            if (!root.sink?.ready || !root.sink?.audio)
                return;

            const delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
            root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + delta));
        }
    }

    component VolumeSlider: Column {
        id: control

        required property var node
        required property string label
        readonly property int volume: node?.ready && node?.audio ? Math.round(node.audio.volume * 100) : 0

        spacing: 3

        Text {
            width: parent.width
            color: Style.fg
            elide: Text.ElideRight
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            text: control.label + " " + control.volume + "%"
        }

        Row {
            width: parent.width
            height: 24
            spacing: 8

            Slider {
                id: slider

                width: parent.width - muteButton.width - parent.spacing
                height: parent.height
                enabled: control.node?.ready && control.node?.audio
                from: 0
                to: 1
                value: enabled ? control.node.audio.volume : 0
                onMoved: control.node.audio.volume = value

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

            ActionButton {
                id: muteButton

                width: parent.height
                height: parent.height
                enabled: control.node?.ready && control.node?.audio
                text: root.volumeIcon(control.volume, control.node?.ready && control.node?.audio?.muted)
                textColor: control.node?.ready && control.node?.audio?.muted ? Style.red : Style.fg
                onClicked: control.node.audio.muted = !control.node.audio.muted
            }
        }
    }

    HoverPopup {
        id: volumePopup

        anchor.item: root
        implicitWidth: 320
        implicitHeight: volumeColumn.implicitHeight + 20
        triggerHovered: volumeMouse.containsMouse

        Column {
            id: volumeColumn

            anchors.fill: parent
            anchors.margins: 10
            spacing: 8

            VolumeSlider {
                width: parent.width
                node: root.sink
                label: root.sink?.description || root.sink?.name || "Output"
            }

            Text {
                visible: root.playbackStreams.length > 0
                color: Style.grey
                font.family: Style.fontFamily
                font.pixelSize: Style.fontSize
                text: "Playback"
            }

            Repeater {
                model: root.playbackStreams

                VolumeSlider {
                    required property var modelData

                    width: volumeColumn.width
                    node: modelData
                    label: root.streamName(modelData)
                }
            }

            ActionButton {
                width: parent.width
                text: "More"
                onClicked: {
                    volumePopup.close();
                    if (!pavucontrol.running)
                        pavucontrol.running = true;
                }
            }
        }
    }

    Process {
        id: pavucontrol
        command: ["pavucontrol"]
    }
}
