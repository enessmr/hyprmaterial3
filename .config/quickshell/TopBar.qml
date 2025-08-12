// ======== TopBar.qml ========
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: root
    height: 40
    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0.1, 0.1, 0.15, 0.7)
        layer.enabled: true
        layer.effect: Blur { radius: 32 }
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.1)

        RowLayout {
            anchors.fill: parent
            spacing: 20

            // Workspace switcher
            WorkspaceSwitcher {
                Layout.preferredWidth: 150
                Layout.leftMargin: 15
            }

            // System stats
            Item {
                Layout.fillWidth: true
                Row {
                    spacing: 15
                    anchors.verticalCenter: parent.verticalCenter
                    
                    SysMonitor {
                        label: "CPU"
                        value: SysInfo.cpuLoad.toFixed(1)
                        unit: "%"
                        warningThreshold: 80
                    }
                    
                    SysMonitor {
                        label: "MEM"
                        value: (SysInfo.memoryUsed / 1024 / 1024).toFixed(1)
                        unit: "GB"
                        warningThreshold: 8
                    }
                    
                    SysMonitor {
                        label: "TEMP"
                        value: SysInfo.cpuTemp
                        unit: "°C"
                        warningThreshold: 75
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
}