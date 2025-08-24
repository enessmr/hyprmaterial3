pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth
import qs
import qs.bar
import "../../resources/components/inputs"
import "../../resources/colors.js" as Palette

ClickableIcon {
    id: root
    required property var bar
    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property bool connected: adapter ? adapter.devices.values.some(device => device.connected) : false

    property bool showMenu: false

    onPressed: event => {
        event.accepted = true
        if (event.button === Qt.RightButton) {
            showMenu = !showMenu
        }
    }

    onClicked: event => {
        if (event.button === Qt.LeftButton) {
            adapter.enabled = !adapter.enabled
        }
    }

    image: ""
    showPressed: showMenu || (pressedButtons & ~Qt.RightButton)
    implicitHeight: width
    fillWindowWidth: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    // Centered main icon
    Item {
        anchors.fill: parent
        
        Label {
            id: bluetoothIcon
            // Position manually in center to avoid anchor conflicts with scaling
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2
            font.family: "Material Symbols Outlined"
            font.pixelSize: 37 // Base size
            // Scale down when menu is open or when right-clicked
            scale: root.showMenu || (root.pressedButtons & Qt.RightButton) ? 0.7 : 1.0
            text: {
                if (!adapter || !adapter.enabled) return "bluetooth_disabled"
                if (connected) return "bluetooth_connected"
                return "bluetooth"
            }
            color: Palette.palette().onSurface
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            // Scale from center point
            transformOrigin: Item.Center
            
            // Smoother scaling transition with NumberAnimation instead
            Behavior on scale {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.adapter.enabled = !root.adapter.enabled
            }
        }
    }

    // Tooltip
    property var tooltip: TooltipItem {
        tooltip: bar.tooltip
        owner: root
        show: root.containsMouse

        Label {
            color: Palette.palette().onSurface
            text: "Bluetooth"
        }
    }

    // Right-click menu
    property var rightclickMenu: TooltipItem {
        id: rightclickMenu
        tooltip: bar.tooltip
        owner: root
        isMenu: true
        show: root.showMenu
        onClose: root.showMenu = false

        Loader {
            width: 400
            active: root.showMenu || rightclickMenu.visible

            sourceComponent: Column {
                spacing: 5

                move: Transition {
                    SmoothedAnimation { property: "y"; velocity: 350 }
                }

                RowLayout {
                    width: parent.width
                    spacing: 5

                    // Icon + label clickable
                    MouseArea {
                        anchors.fill: parent
                        onClicked: { root.adapter.enabled = !root.adapter.enabled }

                        RowLayout {
                            spacing: 5

                            Label {
                                font.family: "Material Symbols Outlined"
                                font.pixelSize: 20 // Smaller icon in menu
                                text: {
                                    if (!adapter || !adapter.enabled) return "bluetooth_disabled"
                                    if (connected) return "bluetooth_connected"
                                    return "bluetooth"
                                }
                                color: Palette.palette().onSurface
                            }

                            Label {
                                text: `Bluetooth (${root.adapter.adapterId})`
                                color: Palette.palette().onSurface
                                font.pixelSize: 16
                            }
                        }
                    }

                    Item { Layout.fillWidth: true }

                    // Toggle adapter button
                    Label {
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20 // Smaller icon in menu
                        text: adapter.enabled ? "bluetooth_disabled" : "bluetooth"
                        color: Palette.palette().onSurface
                        MouseArea { anchors.fill: parent; onClicked: root.adapter.enabled = !root.adapter.enabled }
                    }

                    // Discover button
                    Label {
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20 // Smaller icon in menu
                        text: "search"
                        color: Palette.palette().onSurface
                        MouseArea { anchors.fill: parent; onClicked: root.adapter.discovering = !root.adapter.discovering }
                    }
                }

                Rectangle {
                    width: parent.width
                    implicitHeight: 1
                    visible: root.adapter.devices.values.length > 0
                    color: ShellGlobals.colors.separator
                }

                Repeater {
                    model: ScriptModel {
                        values: [...root.adapter.devices.values].sort((a, b) => {
                            if (a.connected && !b.connected) return -1
                            if (b.connected && !a.connected) return 1
                            if (a.bonded && !b.bonded) return -1
                            if (b.bonded && !a.bonded) return 1
                            return b.name - a.name
                        })
                    }

                    delegate: BluetoothDeviceDelegate {
                        required property BluetoothDevice modelData
                        device: modelData
                        width: parent.width
                    }
                }
            }
        }
    }
}