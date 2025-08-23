import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Controls
import Quickshell.Io

PanelWindow {
    id: panelWindow
    anchors {
        top: true
        left: true
    }
    width: 200
    height: 100
    margins: 10
    exclusiveZone: 0 // Don't reserve space, float above other windows
    
    Item {
        id: root
        anchors.fill: parent

        property double screenZoom: 1.0 // Default zoom level

        IpcHandler {
            target: "zoomWidget"

            function updateZoom(newZoom) {
                root.screenZoom = newZoom;
            }

            function toggle() {
                panelWindow.visible = !panelWindow.visible;
            }

            function zoomIn() {
                var newZoom = Math.min(root.screenZoom + 0.1, 1000);
                root.screenZoom = newZoom;
            }

            function zoomOut() {
                var newZoom = Math.max(root.screenZoom - 0.1, 1);
                root.screenZoom = newZoom;
            }
        }

        // Background for better visibility
        Rectangle {
            anchors.fill: parent
            color: "#2b2b2b"
            opacity: 0.9
            radius: 8
        }

        // Zoom level display
        Text {
            id: zoomDisplay
            text: Math.round(root.screenZoom * 100) + "%"
            color: "white"
            font.pixelSize: 14
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
        }

        Button {
            id: zoomInBtn
            text: "+"
            width: 40
            height: 30
            onClicked: {
                var newZoom = Math.min(root.screenZoom + 0.1, 1000);
                root.screenZoom = newZoom;
            }
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 10
        }

        Button {
            id: zoomOutBtn
            text: "-"
            width: 40
            height: 30
            onClicked: {
                var newZoom = Math.max(root.screenZoom - 0.1, 1);
                root.screenZoom = newZoom;
            }
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 20
            anchors.bottomMargin: 10
        }
    }
}