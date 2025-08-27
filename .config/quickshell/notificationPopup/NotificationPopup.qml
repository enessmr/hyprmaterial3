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

    // BESTIE WE'RE GOING FULL CAVEMAN MODE - NO MORE FANCY STUFF
    property var notificationService: null

    Timer {
        id: serviceChecker
        interval: 100  // Check every 100ms like a MENACE
        running: true
        repeat: true
        onTriggered: {
            if (!notificationPopup.notificationService) {
                // Try different ways to find this service bc QuickShell is UNHINGED
                var service = Quickshell.services?.notifications 
                if (!service) {
                    // Maybe try the global scope? WHO KNOWS AT THIS POINT
                    service = notifications
                }
                if (service) {
                    console.log("🎯 FINALLY FOUND THE SERVICE BESTIE!! IT WAS HIDING FR")
                    notificationPopup.notificationService = service
                    serviceChecker.stop() // We can rest now
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("📱 NOTIFICATION POPUP LOADED BESTIE")
        // Try immediately first
        var service = Quickshell.services?.notifications
        if (service) {
            console.log("🎯 SERVICE EXISTS IMMEDIATELY BESTIE")
            notificationService = service
            serviceChecker.stop()
        } else {
            console.log("🔍 SERVICE NOT FOUND YET, STARTING HUNT...")
        }
    }

    PanelWindow {
        id: root
        // BULLETPROOF VISIBILITY CHECK BESTIE
        visible: notificationPopup.notificationService?.popupList?.length > 0
        
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
            console.log("🔥 NOTIFICATION SERVICE EXISTS:", !!notificationPopup.notificationService)
            console.log("🔥 POPUP LIST LENGTH:", notificationPopup.notificationService?.popupList?.length ?? "undefined")
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
            
            model: notificationPopup.notificationService?.popupList ?? []
            
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
                        if (notificationPopup.notificationService) {
                            notificationPopup.notificationService.discardNotification(modelData.notificationId)
                        }
                    }
                }
            }
        }

        // Debug info - FIXED THE REFERENCE BESTIE
        Text {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 8
            text: "Popups: " + (notificationPopup.notificationService?.popupList?.length ?? 0)
            color: "red"
            font.pixelSize: 10
            visible: true // Set to false later
        }
    }
}