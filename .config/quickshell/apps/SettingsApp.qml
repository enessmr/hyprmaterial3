import QtQuick 2.15
import QtQuick.Controls 2.15
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

FloatingWindow {
    id: root

    width: 200
    height: 300

    visible: true

    WlrLayershell.namespace: "quickshell:onScreenDisplay"

    IpcHandler {
        target: "settingsApp"

        function toggle(): void {
            root.visible = !root.visible
        }

        function open(): void {
            root.visible = true
        }

        function close(): void {
            root.visible = false
        }
    }
}