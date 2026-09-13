import Quickshell.Networking as Net
import QtQuick
import "../.."
import "../../utils"

BarIcon {
    id: root

    readonly property var devices: Net.Networking.devices?.values ?? []
    readonly property var wiredDevice: devices.find(function (device) {
        return device.type === Net.DeviceType.Wired && device.connected;
    }) ?? null
    readonly property var wifiDevice: devices.find(function (device) {
        return device.type === Net.DeviceType.Wifi;
    }) ?? null
    readonly property var wifiNetwork: {
        const networks = root.wifiDevice?.networks?.values ?? [];
        return networks.find(function (network) {
            return network.connected;
        }) ?? null;
    }
    readonly property bool connected:
        root.wiredDevice !== null || root.wifiNetwork !== null

    function signalStrength() {
        const strength = root.wifiNetwork?.signalStrength ?? 0;
        return Math.round(strength > 1 ? strength : strength * 100);
    }

    function connectivityText() {
        switch (Net.Networking.connectivity) {
        case Net.NetworkConnectivity.Full:
            return "Internet connected";
        case Net.NetworkConnectivity.Limited:
            return "Limited internet access";
        case Net.NetworkConnectivity.Portal:
            return "Sign-in required";
        case Net.NetworkConnectivity.None:
            return "No internet access";
        default:
            return "Internet status unknown";
        }
    }

    function details() {
        if (Net.Networking.backend === Net.NetworkBackendType.None)
            return "NetworkManager unavailable";

        const lines = [];
        if (root.wiredDevice)
            lines.push("Wired");
        if (root.wifiNetwork)
            lines.push("Wi-Fi: " + root.wifiNetwork.name
                + " (" + root.signalStrength() + "%)");
        if (lines.length === 0)
            return "Disconnected";

        lines.push(root.connectivityText());
        return lines.join("\n");
    }

    color: {
        if (!root.connected)
            return Style.red;
        if (Net.Networking.connectivity === Net.NetworkConnectivity.Limited
                || Net.Networking.connectivity === Net.NetworkConnectivity.Portal)
            return Style.orange;
        return Style.fg;
    }
    text: root.wiredDevice ? "󰈀" : root.wifiNetwork ? "" : "⚠"

    HoverHandler {
        id: networkHover
    }

    HoverPopup {
        anchor.item: root
        implicitWidth: detailsText.implicitWidth + 10
        implicitHeight: detailsText.implicitHeight + 10
        triggerHovered: networkHover.hovered

        Text {
            id: detailsText

            anchors.centerIn: parent
            color: Style.fg
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            text: root.details()
        }
    }
}
