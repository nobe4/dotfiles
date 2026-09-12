import Quickshell
import Quickshell.Io
import QtQuick
import "../.."

Row {
    id: root

    property int cpu: 0
    property int memory: 0
    property string memoryUsed: "0.0 GiB"

    Text {
        height: parent.height
        color: Style.fg
        font.family: Style.fontFamily
        font.pixelSize: Style.fontSize
        leftPadding: 5
        rightPadding: 5
        verticalAlignment: Text.AlignVCenter
        text: root.cpu + "% "

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: htop.running = true
        }
    }

    Text {
        id: memoryText
        height: parent.height
        color: Style.fg
        font.family: Style.fontFamily
        font.pixelSize: Style.fontSize
        leftPadding: 5
        rightPadding: 5
        verticalAlignment: Text.AlignVCenter
        text: root.memory + "% "

        MouseArea {
            id: memoryMouse
            anchors.fill: parent
            hoverEnabled: true
        }

        PopupWindow {
            anchor.item: memoryText
            anchor.edges: Edges.Bottom
            anchor.gravity: Edges.Bottom
            implicitWidth: usedText.implicitWidth + 10
            implicitHeight: usedText.implicitHeight + 10
            color: Style.bg
            visible: memoryMouse.containsMouse

            Text {
                id: usedText
                anchors.centerIn: parent
                color: Style.fg
                font.family: Style.fontFamily
                font.pixelSize: Style.fontSize
                text: root.memoryUsed + " used"
            }
        }
    }

    Process {
        id: stats
        command: [
            "bash",
            "-c",
            "cpu=$(awk '/^cpu /{idle=$5;t=0;for(i=2;i<=NF;i++)t+=$i;" +
                "printf \"%.0f\",(1-idle/t)*100}' /proc/stat); " +
                "mem=$(awk '/MemTotal/{t=$2}/MemAvailable/{a=$2}" +
                "END{printf \"%.0f,%.1f GiB\",(1-a/t)*100,(t-a)/1048576}' " +
                "/proc/meminfo); " +
                "echo \"$cpu,$mem\"",
        ]
        stdout: SplitParser {
            onRead: function (line) {
                const parts = line.split(",");
                if (parts.length >= 3) {
                    root.cpu = parseInt(parts[0]) || 0;
                    root.memory = parseInt(parts[1]) || 0;
                    root.memoryUsed = parts[2];
                }
            }
        }
    }

    Process {
        id: htop
        command: ["kitty", "--title", "waybar-htop", "htop"]
    }

    Component.onCompleted: stats.running = true

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            if (!stats.running)
                stats.running = true;
        }
    }
}
