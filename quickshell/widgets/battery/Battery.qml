import Quickshell.Services.UPower
import QtQuick
import "../.."
import "../../utils"

BarIcon {
    id: root

    readonly property var battery: UPower.displayDevice
    readonly property bool available: battery.ready && battery.isPresent
    readonly property int percentage: available ? Math.round(battery.percentage * 100) : 0
    readonly property bool charging: battery.state === UPowerDeviceState.Charging

    function batteryIcon() {
        const batteryIcons = ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹",];
        const chargingIcons = ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅",];
        const level = Math.max(0, Math.min(9, Math.ceil(root.percentage / 10) - 1));
        return root.charging ? chargingIcons[level] : batteryIcons[level];
    }

    function stateText() {
        switch (root.battery.state) {
        case UPowerDeviceState.Charging:
            const toFull = TimeUtils.formatTime(root.battery.timeToFull);
            return toFull ? "Charging\n" + toFull + " to full" : "Charging";
        case UPowerDeviceState.Discharging:
            const toEmpty = TimeUtils.formatTime(root.battery.timeToEmpty);
            return toEmpty ? "Discharging\n" + toEmpty + " left" : "Discharging";
        case UPowerDeviceState.FullyCharged:
            return "Fully charged";
        case UPowerDeviceState.Empty:
            return "Empty";
        case UPowerDeviceState.PendingCharge:
            return "Pending charge";
        case UPowerDeviceState.PendingDischarge:
            return "Pending discharge";
        default:
            return "Unknown";
        }
    }

    visible: root.available
    color: {
        if (root.percentage < 10)
            return Style.red;
        if (root.percentage < 25)
            return Style.orange;
        return Style.fg;
    }
    text: root.batteryIcon()

    HoverHandler {
        id: batteryHover
    }

    HoverPopup {
        anchor.item: root
        implicitWidth: detailsText.implicitWidth + 10
        implicitHeight: detailsText.implicitHeight + 10
        triggerHovered: batteryHover.hovered

        Text {
            id: detailsText

            anchors.centerIn: parent
            color: Style.fg
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            text: root.percentage + "% - " + root.stateText()
        }
    }
}
