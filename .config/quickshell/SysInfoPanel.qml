// ======== SysInfoPanel.qml ========
import QtQuick
import QtQuick.Charts
import Quickshell
import Quickshell.Io

FloatingWindow {
    id: panel
    width: 350
    height: 400
    visible: false
    
    function toggle() { visible = !visible }
    
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
                color: "#f8f8f2"
                font { pixelSize: 20; bold: true }
            }
            
            // CPU usage chart
            ChartView {
                width: parent.width
                height: 120
                antialiasing: true
                
                LineSeries {
                    name: "CPU Usage"
                    axisX: ValueAxis { visible: false }
                    axisY: ValueAxis { min: 0; max: 100 }
                    
                    // Real-time CPU data (simplified)
                    Connections {
                        target: SysInfo
                        onCpuLoadChanged: {
                            if (series.count > 30) series.remove(0);
                            series.append(series.count, SysInfo.cpuLoad);
                        }
                    }
                }
            }
            
            // Memory usage
            ProgressBar {
                width: parent.width
                height: 25
                from: 0
                to: SysInfo.memoryTotal
                value: SysInfo.memoryUsed
                
                background: Rectangle {
                    color: "#44475a"
                    radius: 4
                }
                
                contentItem: Item {
                    Text {
                        anchors.centerIn: parent
                        text: `Memory: ${(SysInfo.memoryUsed/1024/1024).toFixed(1)}GB / ${(SysInfo.memoryTotal/1024/1024).toFixed(1)}GB`
                        color: "white"
                        font.pixelSize: 12
                    }
                }
            }
            
            // Network status
            Row {
                spacing: 10
                Text { text: "🌐"; font.pixelSize: 24 }
                Text {
                    text: NetworkManager.connected ? "Connected" : "Offline"
                    color: NetworkManager.connected ? "#50fa7b" : "#ff5555"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            
            // Battery indicator
            BatteryInfo {
                width: parent.width
                height: 40
            }
        }
    }
}