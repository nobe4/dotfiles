import Quickshell.Io
import QtQuick
import "../.."

Text {
    id: root

    color: Style.fg
    font.family: Style.fontFamily
    font.pixelSize: Style.fontSize
    leftPadding: 5
    rightPadding: 5
    verticalAlignment: Text.AlignVCenter

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            if (!weatherTerminal.running)
                weatherTerminal.running = true;
        }
        onExited: weatherTerminal.running = false
    }

    Process {
        id: weatherProc
        command: ["/home/nobe4/.config/dotfiles/bin/weather", "--simple"]
        stdout: SplitParser {
            onRead: function (line) {
                root.text = line.trim();
            }
        }
    }

    Process {
        id: weatherTerminal
        command: ["kitty", "--title", "quickshell-popup", "--override", "initial_window_width=800", "--override", "initial_window_height=620", "weather", "--wait",]
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!weatherProc.running)
                weatherProc.running = true;
        }
    }
}
