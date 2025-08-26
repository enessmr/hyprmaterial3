import qs
import qs.common
import qs.common.widgets
import qs.services
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    id: notificationPopup

    PanelWindow {
        id: root
        // BULLETPROOF VISIBILITY CHECK BESTIE
        property var notificationService: null
        visible: notificationService?.popupList?.length > 0
        
        screen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name) ?? null

        WlrLayershell.namespace: "quickshell:notificationPopup"
        WlrLayershell.layer: WlrLayer.Overlay
        exclusiveZone: 0

        anchors {
            top: true
            right: true
            bottom: true
        }

        mask: Region {
            item: listview.contentItem
        }

        color: "transparent"
        implicitWidth: 400 // fallback width

        Component.onCompleted: {
            console.log("📱 NOTIFICATION POPUP LOADED BESTIE")
            // Find the notification service from the shell root
            let shellRoot = parent
            while (shellRoot && !shellRoot.notificationService) {
                shellRoot = shellRoot.parent
            }
            if (shellRoot) {
                notificationService = shellRoot.notificationService
                console.log("Found notification service:", !!notificationService)
            } else {
                console.log("Could not find notification service!")
            }
        }

        // Simple list view for now - you can replace with your fancy NotificationListView
        ListView {
            id: listview
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                rightMargin: 4
                topMargin: 4
            }
            width: parent.width - 8
            
            model: notificationService?.popupList ?? []
            
            delegate: Rectangle {
                width: listview.width
                height: 80
                color: "#2a2a2a"
                radius: 8
                border.color: "#4a4a4a"
                border.width: 1
                
                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 12
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Text {
                        text: modelData.summary || "No Summary"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 14
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }
                    
                    Text {
                        text: modelData.body || "No Body"
                        color: "#cccccc"
                        font.pixelSize: 12
                        width: parent.width
                        wrapMode: Text.WordWrap
                        maximumLineCount: 2
                        elide: Text.ElideRight
                    }
                    
                    Text {
                        text: modelData.appName || "Unknown App"
                        color: "#888888"
                        font.pixelSize: 10
                        font.italic: true
                    }
                }
                
                // Click to dismiss
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("👆 DISMISSING NOTIFICATION:", modelData.notificationId)
                        if (notificationService) {
                            notificationService.discardNotification(modelData.notificationId)
                        }
                    }
                }
            }
        }

        // Debug info
        Text {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 8
            text: "Popups: " + (parent.notifications?.popupList?.length ?? 0)
            color: "red"
            font.pixelSize: 10
            visible: true // Set to false later
        }
    }
}