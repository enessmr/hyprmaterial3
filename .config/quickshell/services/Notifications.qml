// NotificationService.qml - REGULAR COMPONENT NOT SINGLETON
// Put this in your services folder bestie

import qs.common
import qs
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

/**
 * NON-SINGLETON notification service bc singletons are CURSED AF
 */
Item {
    id: root

    component Notif: QtObject {
        id: wrapper
        required property int notificationId
        property Notification notification
        property list<var> actions: notification?.actions.map((action) => ({
            "identifier": action.identifier,
            "text": action.text,
        })) ?? []
        property bool popup: false
        property string appIcon: notification?.appIcon ?? ""
        property string appName: notification?.appName ?? ""
        property string body: notification?.body ?? ""
        property string image: notification?.image ?? ""
        property string summary: notification?.summary ?? ""
        property double time
        property string urgency: notification?.urgency.toString() ?? "normal"
        property Timer timer

        onNotificationChanged: {
            if (notification === null) {
                root.discardNotification(notificationId);
            }
        }
    }

    component NotifTimer: Timer {
        required property int notificationId
        interval: 5000
        running: true
        onTriggered: () => {
            root.timeoutNotification(notificationId);
            destroy()
        }
    }

    property bool silent: false
    property var filePath: Directories.notificationsPath
    property list<Notif> list: []
    property var popupList: list.filter((notif) => notif.popup);
    property bool popupInhibited: silent // removed the cursed GlobalStates
    property var latestTimeForApp: ({})
    property int idOffset: 0

    Component {
        id: notifComponent
        Notif {}
    }
    Component {
        id: notifTimerComponent
        NotifTimer {}
    }

    signal initDone();
    signal notify(notification: var);
    signal discard(id: int);
    signal discardAll();
    signal timeout(id: var);

    NotificationServer {
        id: notifServer
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        bodySupported: true
        imageSupported: true
        keepOnReload: false
        persistenceSupported: true

        Component.onCompleted: {
            console.log("🔥 NOTIFICATION SERVER STARTING BESTIE 🔥")
            console.log("Valid:", notifServer.valid)
            console.log("About to register DBus service fr fr")
        }

        onNotification: (notification) => {
            console.log("🚨 YO GOT NOTIFICATION FR FR:", notification.summary, notification.body)
            
            notification.tracked = true
            const newNotifObject = notifComponent.createObject(root, {
                "notificationId": notification.id + root.idOffset,
                "notification": notification,
                "time": Date.now(),
            });
            
            root.list = [...root.list, newNotifObject];

            // Popup logic
            if (!root.popupInhibited) {
                newNotifObject.popup = true;
                console.log("✨ SETTING POPUP TO TRUE BESTIE ✨")
                
                if (notification.expireTimeout != 0) {
                    newNotifObject.timer = notifTimerComponent.createObject(root, {
                        "notificationId": newNotifObject.notificationId,
                        "interval": notification.expireTimeout < 0 ? 5000 : notification.expireTimeout,
                    });
                }
            } else {
                console.log("❌ POPUP INHIBITED RN BESTIE")
            }

            root.notify(newNotifObject);
            
            // Save to file
            if (notifFileView.loaded) {
                notifFileView.setText(JSON.stringify(root.list.map(notif => ({
                    "notificationId": notif.notificationId,
                    "appIcon": notif.appIcon,
                    "appName": notif.appName,
                    "body": notif.body,
                    "image": notif.image,
                    "summary": notif.summary,
                    "time": notif.time,
                    "urgency": notif.urgency,
                })), null, 2));
            }
        }
    }

    function discardNotification(id) {
        console.log("🗑️ [Notifications] Yeeting notification:", id);
        const index = root.list.findIndex((notif) => notif.notificationId === id);
        if (index !== -1) {
            root.list.splice(index, 1);
            root.list = root.list.slice(0) // trigger change
        }
        
        const notifServerIndex = notifServer.trackedNotifications.values.findIndex((notif) => notif.id + root.idOffset === id);
        if (notifServerIndex !== -1) {
            notifServer.trackedNotifications.values[notifServerIndex].dismiss()
        }
        root.discard(id);
    }

    function timeoutNotification(id) {
        console.log("⏰ TIMING OUT NOTIFICATION:", id)
        const index = root.list.findIndex((notif) => notif.notificationId === id);
        if (root.list[index] != null) {
            root.list[index].popup = false;
            root.list = root.list.slice(0) // trigger change
        }
        root.timeout(id);
    }

    Component.onCompleted: {
        console.log("💀 NOTIFICATION SERVICE LOADED BESTIE 💀")
        if (notifFileView) notifFileView.reload()
    }

    FileView {
        id: notifFileView
        path: Qt.resolvedUrl(filePath)
        
        onLoaded: {
            console.log("📁 Loading saved notifications...")
            try {
                const fileContents = notifFileView.text()
                if (fileContents.trim()) {
                    const savedNotifs = JSON.parse(fileContents)
                    root.list = savedNotifs.map((notif) => {
                        return notifComponent.createObject(root, {
                            "notificationId": notif.notificationId,
                            "appIcon": notif.appIcon,
                            "appName": notif.appName,
                            "body": notif.body,
                            "image": notif.image,
                            "summary": notif.summary,
                            "time": notif.time,
                            "urgency": notif.urgency,
                        });
                    });
                    
                    // Find max ID
                    let maxId = 0
                    root.list.forEach((notif) => {
                        maxId = Math.max(maxId, notif.notificationId)
                    })
                    root.idOffset = maxId
                }
                console.log("✅ Loaded", root.list.length, "saved notifications")
            } catch(e) {
                console.log("❌ Error parsing saved notifications:", e)
                root.list = []
            }
            root.initDone()
        }
        
        onLoadFailed: (error) => {
            if(error == FileViewError.FileNotFound) {
                console.log("📝 Creating new notification file")
                root.list = []
                notifFileView.setText("[]");
            } else {
                console.log("💥 Error loading notification file:", error)
            }
            root.initDone()
        }
    }
}