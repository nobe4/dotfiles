import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import "../.."
import "../../utils"

BarIcon {
    id: root

    property PwNode sink: Pipewire.defaultAudioSink
    property bool outputMenuOpen: false
    readonly property int volume: sink?.ready && sink?.audio ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool muted: sink?.ready && sink?.audio ? sink.audio.muted : false
    readonly property var audioSinks: Pipewire.nodes.values.filter(function (node) {
        return node.isSink && !node.isStream && node.audio !== null;
    }).slice().sort(function (left, right) {
        return root.nodeName(left).localeCompare(root.nodeName(right));
    })
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

    function nodeName(node) {
        return node?.description || node?.nickname || node?.name || "Unknown output";
    }

    function selectSink(node) {
        Pipewire.preferredDefaultAudioSink = node;
        root.outputMenuOpen = false;
    }

    function volumeIcon(volume, muted) {
        if (muted)
            return "";

        return volume > 66 ? "" : volume > 33 ? "" : "";
    }

    PwObjectTracker {
        objects: root.audioStreams.concat(root.audioSinks)
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
        onClicked: {
            volumePopup.close();
            if (!pavucontrol.running)
                pavucontrol.running = true;
        }
    }

    HoverPopup {
        id: volumePopup

        anchor.item: root
        implicitWidth: 360
        implicitHeight: volumeColumn.implicitHeight + 20
        triggerHovered: volumeMouse.containsMouse
        onPopupOpenChanged: {
            if (!popupOpen)
                root.outputMenuOpen = false;
        }

        Column {
            id: volumeColumn

            anchors.fill: parent
            anchors.margins: 10
            spacing: 8

            ActionButton {
                width: parent.width
                enabled: root.audioSinks.length > 0
                text: root.nodeName(root.sink)
                onClicked: root.outputMenuOpen = !root.outputMenuOpen
            }

            Column {
                visible: root.outputMenuOpen
                width: parent.width
                spacing: 3

                Repeater {
                    model: root.audioSinks

                    ActionButton {
                        required property var modelData

                        width: volumeColumn.width
                        text: root.nodeName(modelData)
                        textColor: modelData === root.sink ? Style.blue : Style.fg
                        onClicked: root.selectSink(modelData)
                    }
                }
            }

            VolumeSlider {
                id: sinkVolume

                width: parent.width
                node: root.sink
                icon: root.volumeIcon(sinkVolume.volume, sinkVolume.muted)
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Style.grey
            }

            Repeater {
                model: root.playbackStreams

                VolumeSlider {
                    id: sourceVolume
                    required property var modelData

                    width: volumeColumn.width
                    node: modelData
                    label: root.streamName(modelData)
                    icon: root.volumeIcon(sourceVolume.volume, sourceVolume.muted)
                }
            }
        }
    }

    Process {
        id: pavucontrol
        command: ["pavucontrol"]
    }
}
