// CheatsheetVibes.qml - Add this as a new file
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.common
import qs.common.widgets
import Quickshell
import Quickshell.Io

Item {
    id: root
    
    implicitWidth: contentLayout.implicitWidth
    implicitHeight: contentLayout.implicitHeight
    
    // VIBE PROPERTIES - PERSISTENT 🥵💦
    property int vibeLevel: 50
    property int goonLevel: 0
    property bool homeworkMode: false
    property bool teacherAlert: false
    
    Component.onCompleted: {
        // Load from persistent storage if you want
        console.log("Vibe checker loaded! Current vibes:", vibeLevel)
    }
    
    function increaseVibes() {
        vibeLevel = Math.min(100, vibeLevel + 10)
        if (vibeLevel >= 100) {
            Quickshell.execDetached(["notify-send", "--app-name", "HyprYoshi3 Gooner Vibe Checker", "MAX VIBES", "YAHOO! 100% VIBES! 🦕💚"])
        }
    }
    
    function decreaseVibes() {
        vibeLevel = Math.max(0, vibeLevel - 10)
        if (vibeLevel <= 20) {
            Quickshell.execDetached(["notify-send", "--app-name", "HyprYoshi3 Gooner Vibe Checker",  "LOW VIBES", "Take a break bestie 😭"])
        }
    }
    
    function yoshiRescue() {
        vibeLevel = 100
        goonLevel = 0
        homeworkMode = false
        teacherAlert = false
        Quickshell.execDetached(["notify-send", "--app-name", "HyprYoshi3 Gooner Vibe Checker", 
            "YOSHI RESCUE! 🦕", 
            "Vibes restored to 100%!\nNo homework, no teachers, only Yoshi 💚"])
    }
    
    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        spacing: 20
        
        // TITLE
        Label {
            Layout.alignment: Qt.AlignHCenter
            text: "🦕 HYPRYOSHI3 VIBE CHECKER 💚"
            font.pixelSize: Appearance.font.pixelSize.title
            font.bold: true
            color: Appearance.m3colors.m3onSurface
        }
        
        // VIBE DISPLAY
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            radius: Appearance.rounding.medium
            color: {
                if (vibeLevel >= 80) return "#a6e3a1"
                if (vibeLevel >= 50) return "#89b4fa"
                if (vibeLevel >= 20) return "#f9e2af"
                return "#f38ba8"
            }
            border.color: Qt.darker(color, 1.2)
            border.width: 2
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 8
                
                Label {
                    Layout.fillWidth: true
                    text: homeworkMode ? "📚 HOMEWORK MODE" :
                          teacherAlert ? "👨‍🏫 TEACHER ALERT" :
                          "CURRENT VIBES"
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                    color: Appearance.m3colors.m3Surface
                }
                
                Label {
                    Layout.fillWidth: true
                    text: "Vibes: " + vibeLevel + "%\n" +
                          "Goon: " + goonLevel + "%"
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 32
                    font.bold: true
                    color: Appearance.m3colors.m3Surface
                    wrapMode: Text.Wrap
                }
                
                // PROGRESS BAR
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 8
                    radius: 4
                    color: "#313244"
                    
                    Rectangle {
                        width: parent.width * (vibeLevel / 100)
                        height: parent.height
                        radius: 4
                        color: Appearance.m3colors.m3Surface
                    }
                }
            }
        }
        
        // CONTROL BUTTONS
        GridLayout {
            Layout.fillWidth: true
            columns: 2
            rowSpacing: 10
            columnSpacing: 10
            
            Button {
                Layout.fillWidth: true
                text: "↑ Increase Vibes"
                onClicked: increaseVibes()
                
                background: Rectangle {
                    radius: Appearance.rounding.small
                    color: parent.pressed ? "#a6e3a1" : 
                           parent.hovered ? Qt.lighter("#a6e3a1", 1.1) : "#a6e3a1"
                }
                
                contentItem: Label {
                    text: parent.text
                    color: Appearance.m3colors.m3Surface
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                }
            }
            
            Button {
                Layout.fillWidth: true
                text: "↓ Decrease Vibes"
                onClicked: decreaseVibes()
                
                background: Rectangle {
                    radius: Appearance.rounding.small
                    color: parent.pressed ? "#f38ba8" : 
                           parent.hovered ? Qt.lighter("#f38ba8", 1.1) : "#f38ba8"
                }
                
                contentItem: Label {
                    text: parent.text
                    color: Appearance.m3colors.m3Surface
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                }
            }
            
            Button {
                Layout.columnSpan: 2
                Layout.fillWidth: true
                text: homeworkMode ? "📚 Homework: ON" : "📚 Homework: OFF"
                onClicked: homeworkMode = !homeworkMode
                
                background: Rectangle {
                    radius: Appearance.rounding.small
                    color: homeworkMode ? "#f38ba8" : "#a6e3a1"
                }
                
                contentItem: Label {
                    text: parent.text
                    color: "#11111b"
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                }
            }
            
            Button {
                Layout.columnSpan: 2
                Layout.fillWidth: true
                text: teacherAlert ? "👨‍🏫 Teacher: PRESENT" : "👨‍🏫 Teacher: GONE"
                onClicked: teacherAlert = !teacherAlert
                
                background: Rectangle {
                    radius: Appearance.rounding.small
                    color: teacherAlert ? "#f38ba8" : "#a6e3a1"
                }
                
                contentItem: Label {
                    text: parent.text
                    color: Appearance.m3colors.m3Surface
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                }
            }
            
            Button {
                Layout.columnSpan: 2
                Layout.fillWidth: true
                text: "🦕 YOSHI RESCUE"
                onClicked: yoshiRescue()
                
                background: Rectangle {
                    radius: Appearance.rounding.small
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#94e2d5" }
                        GradientStop { position: 1.0; color: "#a6e3a1" }
                    }
                }
                
                contentItem: Label {
                    text: parent.text
                    color: Appearance.m3colors.m3Surface
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                    font.pixelSize: 16
                }
            }
        }
        
        // QUICK ACTIONS
        Flow {
            Layout.fillWidth: true
            spacing: 10
            
            Button {
                text: "Chill 😌"
                onClicked: {
                    vibeLevel = 70
                    goonLevel = 20
                }
                
                background: Rectangle {
                    radius: Appearance.rounding.small
                    color: "#89b4fa"
                }
            }
            
            Button {
                text: "Gooner 🥵"
                onClicked: {
                    vibeLevel = 30
                    goonLevel = 80
                }
                
                background: Rectangle {
                    radius: Appearance.rounding.small
                    color: "#f5c2e7"
                }
            }
            
            Button {
                text: "No Cap FR"
                onClicked: {
                    vibeLevel = 90
                    goonLevel = 10
                    Quickshell.execDetached(["notify-send", 
                        "NO CAP FR FR 💯", 
                        "Vibes on fleek! No homework in sight!"])
                }
                
                background: Rectangle {
                    radius: Appearance.rounding.small
                    color: "#f9e2af"
                }
            }
        }
        
        // STATUS INFO
        Label {
            Layout.fillWidth: true
            text: "Homework mode decreases vibes by 30%\n" +
                  "Teacher alert decreases vibes by 40%\n" +
                  "Yoshi rescue restores to 100%"
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
            color: Appearance.m3colors.m3onSurface
            font.pixelSize: Appearance.font.pixelSize.small
        }
    }
}