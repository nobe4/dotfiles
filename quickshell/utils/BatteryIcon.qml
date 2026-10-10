import QtQuick
import ".."

BarIcon {
    id: root

    required property int percentage
    property bool charging: false

    function batteryIcon() {
        const batteryIcons = ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹",];
        const chargingIcons = ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅",];
        const level = Math.max(0, Math.min(9, Math.ceil(root.percentage / 10) - 1));
        return root.charging ? chargingIcons[level] : batteryIcons[level];
    }

    color: {
        if (root.percentage < 10)
            return Style.red;
        if (root.percentage < 25)
            return Style.orange;
        return Style.fg;
    }
    text: root.batteryIcon()
}
