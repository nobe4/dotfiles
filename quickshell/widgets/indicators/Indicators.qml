import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import "../.."
import "../../utils"

Item {
    id: root

    width: height

    property string screenStatus: ""
    property string webcamStatus: ""

    readonly property var audioStreams: Pipewire.nodes.values.filter(function (node) {
        return node.isStream && node.audio !== null;
    })
    readonly property var playbackStreams: root.activeStreams(PwNodeType.AudioOutStream)
    readonly property var recordingStreams: root.activeStreams(PwNodeType.AudioInStream)

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

    function streamDetails(streams) {
        return streams.map(function (stream) {
            const app = stream.properties["application.name"] || stream.description || stream.name;
            const media = stream.properties["media.name"];
            return media ? app + ": " + media : app;
        }).join("\n");
    }

    component Dot: Rectangle {
        width: 7
        height: 7
        radius: width / 2
    }

    component SummaryLine: Row {
        id: line

        required property color dotColor
        required property string description

        spacing: 5

        Dot {
            anchors.verticalCenter: parent.verticalCenter
            color: line.dotColor
        }

        Text {
            color: Style.fg
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            text: line.description
        }
    }

    Grid {
        anchors.centerIn: parent
        columns: 2

        Dot {
            color: Style.red
            visible: root.screenStatus !== ""
        }

        Dot {
            color: Style.orange
            visible: root.webcamStatus !== ""
        }

        Dot {
            color: Style.green
            visible: root.recordingStreams.length > 0
        }

        Dot {
            color: Style.blue
            visible: root.playbackStreams.length > 0
        }
    }

    HoverHandler {
        id: statusHover
    }

    MouseArea {
        anchors.fill: parent
        visible: root.screenStatus !== ""
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (!stopRecording.running)
                stopRecording.running = true;
        }
    }

    HoverPopup {
        anchor.item: root
        implicitWidth: summaryColumn.implicitWidth + 10
        implicitHeight: summaryColumn.implicitHeight + 10
        triggerHovered: statusHover.hovered

        Column {
            id: summaryColumn

            anchors.centerIn: parent
            spacing: 3

            SummaryLine {
                visible: root.screenStatus !== ""
                dotColor: Style.red
                description: root.screenStatus
            }

            SummaryLine {
                visible: root.webcamStatus !== ""
                dotColor: Style.orange
                description: root.webcamStatus
            }

            SummaryLine {
                visible: root.recordingStreams.length > 0
                dotColor: Style.green
                description: "Microphone: " + root.streamDetails(root.recordingStreams)
            }

            SummaryLine {
                visible: root.playbackStreams.length > 0
                dotColor: Style.blue
                description: "Audio playback: " + root.streamDetails(root.playbackStreams)
            }
        }
    }

    PwObjectTracker {
        objects: root.audioStreams
    }

    PwObjectTracker {
        objects: Pipewire.linkGroups.values
    }

    ScriptProcess {
        id: screenStatusProcess
        script: "widgets/indicators/screen-status"
        stdout: StdioCollector {
            onStreamFinished: root.screenStatus = text
        }
    }

    ScriptProcess {
        id: webcamStatusProcess
        script: "widgets/indicators/webcam-status"
        stdout: StdioCollector {
            onStreamFinished: root.webcamStatus = text
        }
    }

    Process {
        id: stopRecording
        command: ["/home/nobe4/.config/dotfiles/bin/screenrecord", "--stop"]
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!screenStatusProcess.running)
                screenStatusProcess.running = true;
            if (!webcamStatusProcess.running)
                webcamStatusProcess.running = true;
        }
    }
}
