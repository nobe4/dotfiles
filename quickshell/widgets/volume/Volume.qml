import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import "../.."

Text {
    id: root

    property PwNode sink: Pipewire.defaultAudioSink
    readonly property int volume: sink?.ready && sink?.audio ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool muted: sink?.ready && sink?.audio ? sink.audio.muted : false

    PwObjectTracker {
        objects: [root.sink]
    }

    color: root.muted ? Style.red : Style.fg
    font.family: Style.fontFamily
    font.pixelSize: Style.fontSize
    leftPadding: 5
    rightPadding: 5
    verticalAlignment: Text.AlignVCenter
    text: {
        if (root.muted)
            return root.volume + "% ";

        const icon = root.volume > 66 ? "" : root.volume > 33 ? "" : "";
        return root.volume + "% " + icon;
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: pavucontrol.running = true
        onWheel: function (wheel) {
            if (!root.sink?.ready || !root.sink?.audio)
                return;

            const delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
            root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + delta));
        }
    }

    Process {
        id: pavucontrol
        command: ["pavucontrol"]
    }
}
