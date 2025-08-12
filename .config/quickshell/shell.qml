// ======== FULL DESKTOP ENVIRONMENT ========
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
    id: root
    width: 1920
    height: 1080
    
    // Global properties
    property color bgColor: "#1e1f29"
    property color accent: "#bd93f9"
    property color textColor: "#f8f8f2"
    property bool darkMode: true

    // Desktop background
    Image {
        anchors.fill: parent
        source: "https://picsum.photos/1920/1080?dark"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.7
    }

    Rectangle {
        anchors.fill: parent
        color: root.bgColor
        opacity: 0.3
    }

    // Top status bar
    Rectangle {
        id: topBar
        height: 40
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        color: Qt.rgba(0.1, 0.1, 0.15, 0.7)
        
        layer.enabled: true
        layer.effect: Blur {
            radius: 32
            transparentBorder: true
        }

        RowLayout {
            anchors.fill: parent
            spacing: 20

            // Workspace switcher
            Row {
                Layout.leftMargin: 15
                spacing: 10
                
                Repeater {
                    model: 5
                    Rectangle {
                        width: 20
                        height: 20
                        radius: 10
                        color: index === 0 ? root.accent : Qt.rgba(1,1,1,0.2)
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: console.log("Switched to workspace", index+1)
                        }
                    }
                }
            }

            // System stats
            Row {
                Layout.fillWidth: true
                spacing: 15
                anchors.verticalCenter: parent.verticalCenter
                
                // CPU Monitor
                Row {
                    spacing: 5
                    Text { text: "CPU:"; color: root.textColor }
                    Text { 
                        text: SysInfo.cpuLoad.toFixed(1) + "%"
                        color: SysInfo.cpuLoad > 80 ? "#ff5555" : root.textColor
                    }
                }
                
                // Memory Monitor
                Row {
                    spacing: 5
                    Text { text: "MEM:"; color: root.textColor }
                    Text { 
                        text: (SysInfo.memoryUsed / 1024 / 1024).toFixed(1) + "GB"
                        color: (SysInfo.memoryUsed / SysInfo.memoryTotal) > 0.8 ? "#ff5555" : root.textColor
                    }
                }
                
                // Temperature Monitor
                Row {
                    spacing: 5
                    Text { text: "TEMP:"; color: root.textColor }
                    Text { 
                        text: SysInfo.cpuTemp + "°C"
                        color: SysInfo.cpuTemp > 75 ? "#ff5555" : root.textColor
                    }
                }
            }

            // Clock and date
            Column {
                Layout.rightMargin: 15
                spacing: 2
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: Qt.formatTime(new Date(), "hh:mm AP")
                    color: root.textColor
                    font { pixelSize: 16; bold: true }
                }
                
                Text {
                    text: Qt.formatDate(new Date(), "dddd, MMMM dd")
                    color: Qt.lighter(root.textColor, 1.5)
                    font.pixelSize: 10
                }
            }
        }
    }

    // Application dock
    Rectangle {
        id: dock
        width: childrenRect.width + 40
        height: 80
        radius: 20
        color: Qt.rgba(0.1, 0.1, 0.15, 0.5)
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 20
        }
        
        Row {
            anchors.centerIn: parent
            spacing: 25
            
            // Dock items
            DockIcon { icon: "🚀"; label: "Terminal"; onClicked: Process.startDetached("alacritty") }
            DockIcon { icon: "🌐"; label: "Browser"; onClicked: Process.startDetached("firefox") }
            DockIcon { icon: "📁"; label: "Files"; onClicked: Process.startDetached("nautilus") }
            DockIcon { icon: "🎵"; label: "Music"; onClicked: Process.startDetached("spotify") }
            DockIcon { icon: "🎮"; label: "Games"; onClicked: Process.startDetached("steam") }
            DockIcon { icon: "⚙️"; label: "Settings"; onClicked: Process.startDetached("gnome-control-center") }
        }
    }

    // System info panel
    FloatingWindow {
        id: sysPanel
        width: 350
        height: 400
        visible: false
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 50
        
        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0.1, 0.1, 0.15, 0.9)
            radius: 12
            border.color: "#6272a4"
            
            Column {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10
                
                Text {
                    text: "System Monitor"
                    color: root.textColor
                    font { pixelSize: 20; bold: true }
                }
                
                // CPU chart
                Rectangle {
                    width: parent.width
                    height: 120
                    color: "transparent"
                    
                    Canvas {
                        id: cpuCanvas
                        anchors.fill: parent
                        
                        property var points: []
                        
                        onPaint: {
                            const ctx = getContext("2d")
                            ctx.clearRect(0, 0, width, height)
                            
                            if (points.length < 2) return
                            
                            ctx.beginPath()
                            ctx.moveTo(points[0].x, points[0].y)
                            
                            for (let i = 1; i < points.length; i++) {
                                ctx.lineTo(points[i].x, points[i].y)
                            }
                            
                            ctx.strokeStyle = root.accent
                            ctx.lineWidth = 3
                            ctx.stroke()
                        }
                    }
                    
                    // Update CPU graph
                    Connections {
                        target: SysInfo
                        onCpuLoadChanged: {
                            if (cpuCanvas.points.length > 30) {
                                cpuCanvas.points.shift()
                            }
                            
                            // Scale value to graph height
                            const yPos = (100 - SysInfo.cpuLoad) * (cpuCanvas.height / 100)
                            cpuCanvas.points.push(Qt.point(
                                cpuCanvas.points.length * (cpuCanvas.width / 30),
                                yPos
                            ))
                            cpuCanvas.requestPaint()
                        }
                    }
                }
                
                // Memory bar
                Column {
                    width: parent.width
                    spacing: 5
                    
                    Text {
                        text: `Memory: ${(SysInfo.memoryUsed/1024/1024).toFixed(1)}GB / ${(SysInfo.memoryTotal/1024/1024).toFixed(1)}GB`
                        color: root.textColor
                    }
                    
                    Rectangle {
                        width: parent.width
                        height: 20
                        radius: 5
                        color: "#44475a"
                        
                        Rectangle {
                            width: (parent.width * SysInfo.memoryUsed / SysInfo.memoryTotal)
                            height: parent.height
                            radius: 5
                            color: root.accent
                            Behavior on width { NumberAnimation { duration: 300 } }
                        }
                    }
                }
                
                // Network status
                Row {
                    spacing: 10
                    Text { text: "🌐"; font.pixelSize: 24; color: root.textColor }
                    Text {
                        text: NetworkManager.connected ? "Connected" : "Offline"
                        color: NetworkManager.connected ? "#50fa7b" : "#ff5555"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    // Global shortcuts
    Shortcut {
        sequence: "Ctrl+Alt+I"
        onActivated: sysPanel.visible = !sysPanel.visible
    }
    
    Shortcut {
        sequence: "Ctrl+Alt+T"
        onActivated: Process.startDetached("alacritty")
    }
    
    // Auto-update time
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: { /* Forces UI update */ }
    }

    // ======== DOCK ICON COMPONENT ========
    component DockIcon: Item {
        id: dockIcon
        width: 60
        height: 60
        property string icon
        property string label
        signal clicked()
        
        Column {
            anchors.centerIn: parent
            spacing: 5
            
            Text {
                text: dockIcon.icon
                font.pixelSize: 24
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                text: dockIcon.label
                color: "white"
                font.pixelSize: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: dockIcon.clicked()
            onEntered: iconAnim.start()
            
            ParallelAnimation {
                id: iconAnim
                NumberAnimation { 
                    target: dockIcon; property: "scale"; 
                    to: 1.2; duration: 150; easing.type: Easing.OutQuad 
                }
                NumberAnimation {
                    target: dockIcon; property: "rotation";
                    from: -10; to: 10; duration: 300; easing.type: Easing.InOutQuad
                }
            }
        }
        
        Behavior on scale {
            NumberAnimation { duration: 200; easing.type: Easing.OutBack }
        }
    }
}