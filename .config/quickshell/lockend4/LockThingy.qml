// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import Quickshell
import Quickshell.Io
import qs.common

// INFO PANEL THAT GOES ABSOLUTELY HARD 🔥
Item {
    id: infoPanel
    anchors.fill: parent

    // Date section - this is giving main character energy
    Row {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 75
        anchors.topMargin: 75
        spacing: 25

        // Calendar icon because we're ICONIC like that
        Text {
            text: "calendar_today"
            color: Appearance?.m3colors?.m3primary
            font.pixelSize: 20
            font.family: "Material Symbols Outlined"
            anchors.verticalCenter: parent.verticalCenter
            
            // Shadow for that CRISPY look
            style: Text.Outline
            styleColor: Appearance?.m3colors?.m3shadow
        }

        // Date text - serving REALNESS
        Text {
            id: dateText
            text: Qt.formatDate(new Date(), "dddd, MMMM dd")
            color: Appearance?.m3colors?.m3primary
            font.pixelSize: 20
            font.family: "Product Sans Medium"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // Input layout section - we love multilingual queens
    Row {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 75
        anchors.topMargin: 110
        spacing: 25

        // Keyboard icon - typing is our passion
        Text {
            text: "keyboard"
            color: Appearance?.m3colors?.m3primary
            font.pixelSize: 20
            font.family: "Material Symbols Outlined"
            anchors.verticalCenter: parent.verticalCenter
        }

        // Layout text - could be dynamic but we keeping it simple bestie
        Text {
            id: layoutText
            text: "US" // Will be updated by the process
            color: Appearance?.m3colors?.m3primary
            font.pixelSize: 20
            font.family: "Product Sans Medium"
            anchors.verticalCenter: parent.verticalCenter    
        }
    }

    // Battery section - power levels are MAXIMUM
    Row {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 75
        anchors.topMargin: 145
        spacing: 22

        // Battery icon - power levels MAXIMUM fr
        Text {
            id: batteryIcon
            text: "battery_full" // Will be updated by deepseek's FIRE script
            color: Appearance?.m3colors?.m3primary
            font.pixelSize: 20
            font.family: "Material Symbols Outlined"
            anchors.verticalCenter: parent.verticalCenter
        }

        // Battery percentage - we love to see those numbers UP
        Text {
            id: batteryText
            text: "100%" // Will be updated by the BANGER script
            color: Appearance?.m3colors?.m3primary
            font.pixelSize: 20
            font.family: "Product Sans Medium"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // DEEPSEEK'S FIRE BAT+AC SCRIPT - ICON GETTER 🚀🚀 (FINALLY DONE RIGHT!!)
    Process {
        id: batteryIconProcess
        running: true // THIS WAS THE MISSING PIECE BESTIE!!
        command: ["bash", "-c", "~/.config/hypr/scripts/battery.sh icon"]
        
        stdout: StdioCollector {
            onStreamFinished: {
                console.log("ICON STREAM FINISHED!! OUTPUT:", text.trim())
                if (text.trim() !== "") {
                    batteryIcon.text = text.trim()
                }
            }
        }
        
        // Restart when process finishes to keep getting updates
        onRunningChanged: {
            if (!running) {
                console.log("Icon process stopped, restarting...")
                running = true
            }
        }
    }
    
    // DEEPSEEK'S FIRE BAT+AC SCRIPT - STATUS GETTER 💀💀 (ACTUALLY WORKING NOW!!)
    Process {
        id: batteryStatusProcess  
        running: true // THE GAME CHANGER FR FR!!
        command: ["bash", "-c", "~/.config/hypr/scripts/battery.sh status"]
        
        stdout: StdioCollector {
            onStreamFinished: {
                console.log("STATUS STREAM FINISHED!! OUTPUT:", text.trim())
                if (text.trim() !== "") {
                    batteryText.text = text.trim()
                }
            }
        }
        
        // Restart when process finishes to keep getting updates  
        onRunningChanged: {
            if (!running) {
                console.log("Status process stopped, restarting...")
                running = true
            }
        }
    }
    
    // Process for keyboard layout because we MULTILINGUAL queens
    Process {
        id: layoutProcess
        running: true // NO MORE FORGETTING THIS BESTIE!!
        command: ["bash", "-c", "hyprctl getoption input:kb_layout | grep -o 'str: \"[^\"]*\"' | cut -d'\"' -f2 | tr '[:lower:]' '[:upper:]'"]
        
        stdout: StdioCollector {
            onStreamFinished: {
                if (text.trim() !== "") {
                    layoutText.text = text.trim()
                }
            }
        }
        
        onRunningChanged: {
            if (!running) {
                running = true
            }
        }
    }
    
    // Timer to refresh date because that actually works lol
    Timer {
        id: refreshTimer
        interval: 30000 // every 30 seconds 
        running: true
        repeat: true
        onTriggered: {
            dateText.text = Qt.formatDate(new Date(), "dddd, MMMM dd")
        }
    }
}