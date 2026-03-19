// 💚 ✨ HyprYoshi3 ✨ 🦕

pragma Singleton

import qs.common
import QtQuick 2.15
import Quickshell
import Quickshell.Io
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.common.widgets
import qs.roundedcorner
import qs.Dih.sidebars.rightydijbestoe.compDijDijDij

Singleton {
    id: root

    property string homeDir: Quickshell.env("HOME") || ""

    PersistentProperties {
        id: persist
        property bool windowvisible: false
    }

    IpcHandler {
        target: "dihRightSidebar"

        function trigger() {
            persist.windowvisible = !persist.windowvisible
        }

        function open() {
            persist.windowvisible = true
        }

        function close() {
            persist.windowvisible = false
        }
    }

    LazyLoader {
        id: loader
        activeAsync: true

        PanelWindow {
            id: window
            visible: persist.windowvisible
            exclusiveZone: 0
            implicitWidth: 465
            implicitHeight: Screen.height
            color: "transparent"
            anchors.left: false
            anchors.right: true
            WlrLayershell.namespace: "quickshell:sidebarRight"
            property real baseWidth: 55
            anchors.bottom: true
            anchors.top: true

            RoundCorner {
        id: topRightCorner
        corner: RoundCorner.CornerEnum.TopRight
        implicitSize: 15
        // implicitHeight: large
        // implicitWidth: baseWidth + 15
        //exclusiveZone: baseWidth + 15 - leftMargin
        color: Appearance.m3colors.m3background
        anchors.left: window.left
        anchors.top: window.top
        y: 0
        x: 0
        z: 10
    }

    RoundCorner {
        id: bottomRightCorner
        corner: RoundCorner.CornerEnum.BottomRight
        implicitSize: 15
        // implicitWidth: baseWidth + 15
        color: Appearance.m3colors.m3background
        anchors.left: window.left
        anchors.bottom: window.bottom
        y: Screen.height - 15
        x: 0
		z: 10
    }

            Rectangle {
                color: Appearance.m3colors.m3background
                radius: 0
                height: parent.height
                width: 450
                anchors.right: parent
                anchors.left: window.right
                anchors.top: parent
                anchors.bottom: parent
                x: 15

                VAVAVAVAVAAHAAA {}
            }
        }
    }

    function init() {}
}