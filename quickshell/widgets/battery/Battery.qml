import Quickshell.Services.UPower
import QtQuick
import "../.."
import "../../utils"

BatteryIcon {
    id: root

    readonly property var battery: UPower.displayDevice
    readonly property bool available: battery.ready && battery.isPresent
    percentage: available ? Math.round(battery.percentage * 100) : 0
    charging: battery.state === UPowerDeviceState.Charging

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
