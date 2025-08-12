// ======== AppDock.qml ========
import QtQuick
import QtQuick.Controls
import Quickshell

Item {
    id: dock
    width: childrenRect.width
    height: 70
    
    property var apps: [
        { name: "Terminal", icon: "🚀", command: "alacritty" },
        { name: "Browser", icon: "🌐", command: "firefox" },
        { name: "Files", icon: "📁", command: "nautilus" },
        { name: "Settings", icon: "⚙️", command: "gnome-control-center" }
    ]

    Row {
        spacing: 15
        
        Repeater {
            model: dock.apps
            delegate: DockIcon {
                icon: modelData.icon
                label: modelData.name
                onClicked: Process.startDetached(modelData.command)
            }
        }
    }
}