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
        command: ["kitty", "--title", "quickshell-popup", "--override", "initial_window_width=750", "--override", "initial_window_height=700", "sh", "-c", "cal --year --week --monday && read",]
    }
}
