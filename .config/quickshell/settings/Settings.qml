pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import qs.common.widgets
import "../resources/colors.js" as Palette

Singleton {
    PersistentProperties {
        id: persist
        property bool settingsOpen: false
    }

    IpcHandler {
        target: "settings"

        function open(): void { persist.settingsOpen = true }
        function close(): void { persist.settingsOpen = false }
        function toggle(): void { persist.settingsOpen = !persist.settingsOpen }
    }

    LazyLoader {
        id: loader
        activeAsync: persist.settingsOpen

        PanelWindow {
            width: 500
            height: 400
            color: "transparent"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            WlrLayershell.namespace: "shell:settings"

            Rectangle {
                anchors.fill: parent
                color: Palette.palette().background
                radius: 16
                border.color: Palette.palette().outlineVariant
                border.width: 1
            }

            Text {
                text: "Settings"
                font.family: "Roboto"
                font.pointSize: 16
                color: Palette.palette().onSurface
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 12
            }

            RippleButton {
                buttonRadius: 9999   // fully round
                implicitWidth: 37.5   // your size
                implicitHeight: 37.5
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 8
                anchors.rightMargin: 8
                onClicked: { persist.settingsOpen = false }

                contentItem: MaterialSymbol {
                    anchors.centerIn: parent
                    text: "close"   // or "✕" if u want it short
                    iconSize: 22.5    // scale down for tiny button
                    horizontalAlignment: Text.AlignHCenter
                }
                // border.color: Palette.palette().outlineVariant
            }

            // Your settings content goes here
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 10
            }
        }
    }

    function init() {}
}
