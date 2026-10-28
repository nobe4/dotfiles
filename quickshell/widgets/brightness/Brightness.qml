import Quickshell.Io
import QtQuick
import QtQuick.Controls
import "../.."
import "../../utils"

BarIcon {
    id: root

    property bool available: false
    property int brightness: 100
    readonly property var brightnessIcons: [
        "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"
    ]

    function applyBrightness() {
        if (setBrightness.running)
            return;

        setBrightness.target = root.brightness;
        setBrightness.running = true;
    }

    function brightnessIcon() {
        const index = Math.min(root.brightnessIcons.length - 1,
            Math.ceil(root.brightness / 10) - 1);
        return root.brightnessIcons[index];
    }

    visible: root.available
    text: root.brightnessIcon()

    MouseArea {
        id: brightnessMouse

        anchors.fill: parent
        hoverEnabled: true
    }

    HoverPopup {
        anchor.item: root
        implicitWidth: 140
        implicitHeight: 36
        triggerHovered: brightnessMouse.containsMouse

        Slider {
            id: brightnessSlider

            anchors.fill: parent
            anchors.margins: 10
            from: 2
            to: 100
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: root.brightness
            onMoved: {
                root.brightness = Math.round(value);
                root.applyBrightness();
            }

            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }

            background: Rectangle {
                x: brightnessSlider.leftPadding
                y: brightnessSlider.topPadding + brightnessSlider.availableHeight / 2 - height / 2
                width: brightnessSlider.availableWidth
                height: 4
                color: Style.grey
                radius: 2

                Rectangle {
                    width: brightnessSlider.visualPosition * parent.width
                    height: parent.height
                    color: Style.blue
                    radius: parent.radius
                }
            }

            handle: Rectangle {
                x: brightnessSlider.leftPadding
                    + brightnessSlider.visualPosition * (brightnessSlider.availableWidth - width)
                y: brightnessSlider.topPadding
                    + brightnessSlider.availableHeight / 2 - height / 2
                width: 12
                height: 12
                color: brightnessSlider.pressed ? Style.fg : Style.blue
                radius: 6
            }
        }
    }

    Process {
        id: getBrightness

        command: ["brightnessctl", "--machine-readable"]
        stdout: SplitParser {
            onRead: function (line) {
                const match = line.match(/(\d+)%/);
                if (!match)
                    return;

                root.available = true;
                if (!brightnessSlider.pressed && !setBrightness.running)
                    root.brightness = Math.max(2, Math.min(100, Number(match[1])));
            }
        }
    }

    Process {
        id: setBrightness

        property int target: 100

        command: ["brightnessctl", "set", target + "%"]
        onExited: {
            if (target !== root.brightness)
                root.applyBrightness();
        }
    }

    Timer {
        interval: 1000
        running: root.available
        repeat: true
        onTriggered: {
            if (!getBrightness.running && !setBrightness.running)
                getBrightness.running = true;
        }
    }

    Component.onCompleted: getBrightness.running = true
}
