import Quickshell.Io
import QtQuick
import "../.."
import "../../utils"

BarIcon {
    id: root

    property string details: ""

    text: ""

    MouseArea {
        id: statsMouse

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: htop.running = true
    }

    HoverPopup {
        anchor.item: root
        implicitWidth: detailsText.implicitWidth + 10
        implicitHeight: detailsText.implicitHeight + 10
        triggerHovered: statsMouse.containsMouse && root.details !== ""

        Text {
            id: detailsText

            anchors.centerIn: parent
            color: Style.fg
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            text: root.details
        }
    }

    ScriptProcess {
        id: stats
        script: "widgets/stats/system-stats"
        stdout: StdioCollector {
            onStreamFinished: root.details = text
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
