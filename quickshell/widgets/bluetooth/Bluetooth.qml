pragma ComponentBehavior: Bound

import Quickshell.Bluetooth as Bluez
import Quickshell.Services.UPower
import QtQuick
import QtQml
import "../.."
import "../../utils"

BarIcon {
    id: root

    readonly property var adapter: Bluez.Bluetooth.defaultAdapter
    readonly property var powerDevices: UPower.devices.values
    readonly property var devices: {
        const values = root.adapter?.devices?.values ?? [];
        return values.filter(function (device) {
            return device.paired || device.bonded || device.deviceName !== "";
        }).slice().sort(function (left, right) {
            if (left.connected !== right.connected)
                return right.connected - left.connected;
            if (left.paired !== right.paired)
                return right.paired - left.paired;
            return root.deviceName(left).localeCompare(root.deviceName(right));
        });
    }
    readonly property int connectedDevices: devices.filter(function (device) {
        return device.connected;
    }).length
    readonly property bool adapterBusy: adapter?.state === Bluez.BluetoothAdapterState.Enabling || adapter?.state === Bluez.BluetoothAdapterState.Disabling

    function deviceName(device) {
        return device.name || device.deviceName || device.address;
    }

    function powerDevice(device) {
        const address = device.address.toLowerCase().replace(/[^0-9a-f]/g, "");
        if (address === "")
            return null;

        return root.powerDevices.find(function (powerDevice) {
            const path = powerDevice.nativePath.toLowerCase().replace(/[^0-9a-f]/g, "");
            return !powerDevice.isLaptopBattery && path.includes(address);
        }) ?? null;
    }

    function activateDevice(device) {
        if (device.connected) {
            device.disconnect();
        } else if (device.paired || device.bonded) {
            device.connect();
        } else {
            device.pair();
        }
    }

    function toggleAdapter() {
        if (!root.adapter || root.adapterBusy)
            return;

        if (root.adapter.enabled)
            root.adapter.discovering = false;
        root.adapter.enabled = !root.adapter.enabled;
    }

    color: {
        if (root.connectedDevices > 0)
            return Style.blue;
        return root.adapter?.enabled ? Style.fg : Style.grey;
    }
    font.pixelSize: Style.fontSize + 3 // icons are a bit small
    text: {
        if (!root.adapter?.enabled)
            return "󰂲";
        if (root.adapter.discovering)
            return "󰂱";
        if (root.connectedDevices > 0)
            return "󰂰";
        return "";
    }

    MouseArea {
        id: bluetoothMouse

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: root.adapter === null ? Qt.ArrowCursor : Qt.PointingHandCursor
        onClicked: root.toggleAdapter()
    }

    HoverPopup {
        id: bluetoothPopup

        anchor.item: root
        implicitWidth: 360
        implicitHeight: deviceColumn.implicitHeight + 20
        triggerHovered: bluetoothMouse.containsMouse
        onPopupOpenChanged: {
            if (root.adapter?.enabled)
                root.adapter.discovering = popupOpen;
        }

        Column {
            id: deviceColumn

            anchors.fill: parent
            anchors.margins: 10
            spacing: 8

            Text {
                visible: root.adapter === null || !root.adapter.enabled
                color: Style.grey
                font.family: Style.fontFamily
                font.pixelSize: Style.fontSize
                text: "Bluetooth disabled"
            }

            Text {
                visible: root.adapter?.enabled && root.devices.length === 0
                color: Style.grey
                font.family: Style.fontFamily
                font.pixelSize: Style.fontSize
                text: root.adapter?.discovering ? "Scanning..." : "No devices"
            }

            Repeater {
                model: root.adapter?.enabled ? root.devices : []

                Row {
                    id: deviceRow

                    required property var modelData

                    readonly property bool busy: modelData.pairing || modelData.state === Bluez.BluetoothDeviceState.Connecting || modelData.state === Bluez.BluetoothDeviceState.Disconnecting
                    readonly property var powerDevice: root.powerDevice(modelData)
                    readonly property bool batteryAvailable: modelData.batteryAvailable || powerDevice !== null
                    readonly property real battery: modelData.batteryAvailable ? modelData.battery : powerDevice?.percentage ?? 0
                    readonly property bool batteryCharging: powerDevice?.state === UPowerDeviceState.Charging
                    readonly property string state: {
                        if (modelData.pairing)
                            return "Pairing";
                        if (modelData.state === Bluez.BluetoothDeviceState.Connecting)
                            return "Connecting";
                        if (modelData.state === Bluez.BluetoothDeviceState.Disconnecting)
                            return "Disconnecting";
                        if (modelData.connected)
                            return "Connected";
                        return modelData.paired || modelData.bonded ? "Paired" : "Not paired";
                    }

                    width: deviceColumn.width
                    spacing: 10

                    Column {
                        width: parent.width - actionButton.width - parent.spacing

                        Row {
                            width: parent.width
                            spacing: 6

                            Text {
                                width: parent.width - (batteryIcon.visible ? batteryIcon.width + parent.spacing : 0)
                                color: Style.fg
                                elide: Text.ElideRight
                                font.family: Style.fontFamily
                                font.pixelSize: Style.fontSize
                                text: root.deviceName(deviceRow.modelData)
                            }

                            BatteryIcon {
                                id: batteryIcon

                                visible: deviceRow.batteryAvailable
                                percentage: Math.round(deviceRow.battery * 100)
                                charging: deviceRow.batteryCharging
                            }
                        }

                        Text {
                            width: parent.width
                            color: Style.grey
                            elide: Text.ElideRight
                            font.family: Style.fontFamily
                            font.pixelSize: Style.fontSize
                            text: deviceRow.modelData.address + " - " + deviceRow.state
                        }
                    }

                    ActionButton {
                        id: actionButton

                        width: 90
                        enabled: root.adapter?.enabled && !deviceRow.busy
                        text: {
                            if (deviceRow.busy)
                                return deviceRow.state;
                            if (deviceRow.modelData.connected)
                                return "Disconnect";
                            return deviceRow.modelData.paired || deviceRow.modelData.bonded ? "Connect" : "Pair";
                        }
                        onClicked: root.activateDevice(deviceRow.modelData)
                    }
                }
            }
        }
    }

    Connections {
        target: root.adapter

        function onEnabledChanged() {
            if (root.adapter.enabled && bluetoothPopup.popupOpen)
                root.adapter.discovering = true;
        }
    }
}
