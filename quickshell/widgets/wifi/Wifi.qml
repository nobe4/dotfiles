import Quickshell
import Quickshell.Io
import QtQuick
import "../.."

Text {
    id: root

    property bool disconnected: true
    property string details: ""

    color: root.disconnected ? Style.red : Style.fg
    font.family: Style.fontFamily
    font.pixelSize: Style.fontSize
    leftPadding: 5
    rightPadding: 5
    verticalAlignment: Text.AlignVCenter
    text: root.disconnected ? "⚠" : ""

    MouseArea {
        id: wifiMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: iwctl.running = true
    }

    PopupWindow {
        anchor.item: root
        anchor.edges: Edges.Bottom | Edges.Right
        anchor.gravity: Edges.Bottom | Edges.Left
        implicitWidth: detailsText.implicitWidth + 10
        implicitHeight: detailsText.implicitHeight + 10
        color: Style.bg
        visible: wifiMouse.containsMouse && root.details !== ""

        Text {
            id: detailsText
            anchors.centerIn: parent
            color: Style.fg
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            text: root.details
        }
    }

    Process {
        id: network
        command: ["/home/nobe4/.config/dotfiles/quickshell/scripts/network-info"]
        stdout: SplitParser {
            onRead: function (line) {
                const parts = line.split(",");
                root.disconnected = parts[0] !== "wifi";
                root.details = parts.slice(1).join(",").trim();
            }
        }
    }

    Process {
        id: iwctl
        command: ["kitty", "--title", "waybar-iwctl", "iwctl"]
    }

    Component.onCompleted: network.running = true

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            if (!network.running)
                network.running = true;
        }
    }
}
