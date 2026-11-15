import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import "../.."
import "../../utils"

Item {
    id: root

    width: height

    // gg: events have no initial state; restart capture after Quickshell starts.
    property bool monitorCaptureActive: false
    property bool windowCaptureActive: false
    readonly property bool screenCaptureActive: monitorCaptureActive || windowCaptureActive
        || screenCaptureHold.running
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
            visible: root.screenCaptureActive
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
                visible: root.screenCaptureActive
                dotColor: Style.red
                description: "Screen recording or sharing"
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

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name !== "screencast")
                return;

            const [state, owner] = event.parse(2);
            if (state !== "0" && state !== "1")
                return;
            if (owner !== "monitor" && owner !== "window")
                return;

            screenCaptureHold.restart();
            if (owner === "monitor")
                root.monitorCaptureActive = state === "1";
            else if (owner === "window")
                root.windowCaptureActive = state === "1";
        }
    }

    Timer {
        id: screenCaptureHold
        interval: 1500
    }

    ScriptProcess {
        id: webcamStatusProcess
        script: "widgets/indicators/webcam-status"
        stdout: StdioCollector {
            onStreamFinished: root.webcamStatus = text
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!webcamStatusProcess.running)
                webcamStatusProcess.running = true;
        }
    }
}
