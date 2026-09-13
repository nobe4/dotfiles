import Quickshell
import Quickshell.Io
import QtQuick
import "../.."

Item {
    id: root
    implicitWidth: time.implicitWidth
    implicitHeight: time.implicitHeight

    Text {
        id: time
        anchors.centerIn: parent
        color: Style.fg
        font.family: Style.fontFamily
        font.pixelSize: Style.fontSize
        text: Time.time
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            if (!calendarTerminal.running)
                calendarTerminal.running = true;
        }
        onExited: calendarTerminal.running = false
    }

    Process {
        id: calendarTerminal
        command: ["bash", Quickshell.shellPath("widgets/clock/calendar")]
    }
}
