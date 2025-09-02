import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.folderlistmodel 1.0
import Qt.labs.platform 1.1
import Quickshell.Io


Rectangle {
    id: wallpaperSelector
    anchors.fill: parent
    color: "transparent"
    z: 1000


    property string selectedWallpaper: ""
    property string wallpaperDir: StandardPaths.writableLocation(StandardPaths.PicturesLocation) + "/.Wallpapers"
    property string mode: "dark" // light or dark bestie!!
    property string colorScheme: "tonal-spot" // any valid M3 color scheme!!
    signal wallpaperChanged(string path, string mode, string colorScheme)


    // Temporary feedback text for wallpaper application
    Text {
        id: feedbackText
        anchors.centerIn: parent
        text: ""
        color: "#00d4ff"
        font.pixelSize: 14
        visible: false
        z: 2000
    }


    Button {
        text: "✕"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        onClicked: wallpaperSelector.destroy()
    }


    Rectangle {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.9, 800)
        height: Math.min(parent.height * 0.9, 600)
        color: "#2a2a2a"
        radius: 12
        border.color: "#444"
        border.width: 1


        Text {
            id: title
            text: "Choose Your Wallpaper Bestie ✨"
            color: "white"
            font.pixelSize: 16
            font.bold: true
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 15
        }


        ScrollView {
            anchors.top: title.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 15
            clip: true


            Grid {
                columns: Math.floor(parent.width / 160)
                spacing: 20
                
                Repeater {
                    model: folderModel
                    
                    Column {
                        spacing: 8
                        
                        Rectangle {
                            width: 140
                            height: 140
                            radius: 12
                            clip: true
                            color: wallpaperSelector.selectedWallpaper === model.filePath ? "#00d4ff" : "#444"
                            
                            Image {
                                anchors.fill: parent
                                source: model.fileURL
                                fillMode: Image.PreserveAspectCrop
                                
                                Rectangle {
                                    anchors.fill: parent
                                    color: "#333"
                                    visible: parent.status === Image.Loading
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: "loading..."
                                        color: "#888"
                                        font.pixelSize: 10
                                    }
                                }
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    wallpaperSelector.selectedWallpaper = model.filePath
                                    console.log("🔥 SWITCHING WALLPAPER BESTIE!!")
                                    console.log("  - path:", model.filePath)
                                    console.log("  - mode:", wallpaperSelector.mode)
                                    console.log("  - colorScheme:", wallpaperSelector.colorScheme)
                                    
                                    // Set up and run the script with Quickshell.Io.Process using explicit bash call
                                    var scriptPath = StandardPaths.writableLocation(StandardPaths.HomeLocation) + "/.config/hypr/scripts/svitchVall.sh"
                                    // Build the command as ["bash", "-c", "scriptPath 'filePath' mode colorScheme"]
                                    var commandString = scriptPath + " '" + model.filePath + "' " + wallpaperSelector.mode + " " + wallpaperSelector.colorScheme
                                    var command = ["bash", "-c", commandString]
                                    console.log("  - executing command:", command)
                                    wallpaperProcess.command = command
                                    wallpaperProcess.running = true
                                    
                                    // Show feedback
                                    console.log("  - showing feedback and emitting wallpaperChanged signal!")
                                    feedbackText.text = "Applying wallpaper... ✨"
                                    feedbackText.visible = true
                                    feedbackTimer.restart()
                                    
                                    // Emit signal for backend
                                    wallpaperSelector.wallpaperChanged(model.filePath, wallpaperSelector.mode, wallpaperSelector.colorScheme)
                                }
                            }
                            
                            Rectangle {
                                visible: wallpaperSelector.selectedWallpaper === model.filePath
                                anchors.top: parent.top
                                anchors.right: parent.right
                                anchors.margins: 5
                                width: 20
                                height: 20
                                radius: 10
                                color: "#00d4ff"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "✓"
                                    color: "white"
                                    font.pixelSize: 12
                                    font.bold: true
                                }
                            }
                        }
                        
                        Text {
                            width: 140
                            height: 30
                            text: model.fileName || model.fileBaseName || "sus file bestie"
                            color: "#ffffff"
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignTop
                            elide: Text.ElideMiddle
                            wrapMode: Text.WordWrap
                            clip: true
                        }
                    }
                }
            }
        }
        
        // if no wallpapers found lol
        Text {
            visible: folderModel.count === 0
            anchors.centerIn: parent
            text: "no wallpapers found bestie 😭\ncheck ur wallpaperDir path"
            color: "#888"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
        }
    }
    
    // THE PROCESS THAT RUNS UR FIRE SCRIPT BESTIE!! 🔥🔥🔥 Using Quickshell.Io.Process properly
    Process {
        id: wallpaperProcess
        stdout: StdioCollector {
            onStreamFinished: {
                console.log("✨ WALLPAPER SCRIPT OUTPUT BESTIE:", this.text)
                if (exitCode === 0) {
                    console.log("✨ WALLPAPER SCRIPT SUCCESS!! LETS GOOOOO")
                    feedbackText.text = "Wallpaper applied! 😍"
                    feedbackTimer.restart()
                } else {
                    console.log("💀 script failed with exit code:", exitCode)
                    feedbackText.text = "Oops, script failed! 😭 Check logs!"
                    feedbackTimer.restart()
                }
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text) {
                    console.log("💀 SCRIPT STDERR BESTIE:", this.text)
                    feedbackText.text = "Script error! 😭 Check logs!"
                    feedbackTimer.restart()
                }
            }
        }
    }
    
    // SETTINGS PANEL FOR MODE AND COLOR SCHEME!! 
    Rectangle {
        visible: false
        id: settingsPanel
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 100
        color: "#1a1a1a"
        border.color: "#333"
        border.width: 1
        
        Row {
            anchors.centerIn: parent
            spacing: 30
            
            Column {
                spacing: 5
                Text {
                    text: "Mode:"
                    color: "white"
                    font.pixelSize: 12
                }
                ComboBox {
                    id: modeComboBox
                    model: ["light", "dark"]
                    currentIndex: wallpaperSelector.mode === "dark" ? 1 : 0
                    onCurrentTextChanged: wallpaperSelector.mode = currentText
                    background: Rectangle {
                        color: "#333"
                        border.color: "#555"
                        radius: 4
                    }
                    contentItem: Text {
                        text: modeComboBox.currentText
                        color: "white"
                        font.pixelSize: 12
                        padding: 6
                        verticalAlignment: Text.AlignVCenter
                    }
                    delegate: ItemDelegate {
                        width: modeComboBox.width
                        contentItem: Text {
                            text: modelData
                            color: "white"
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                            color: highlighted ? "#555" : "#333"
                        }
                    }
                }
            }
            
            Column {
                spacing: 5
                Text {
                    text: "Color Scheme:"
                    color: "white"
                    font.pixelSize: 12
                }
                ComboBox {
                    id: colorSchemeComboBox
                    model: ["tonal-spot", "neutral", "vibrant", "expressive", "content", "monochrome"]
                    currentIndex: {
                        var idx = model.indexOf(wallpaperSelector.colorScheme)
                        return idx >= 0 ? idx : 0
                    }
                    onCurrentTextChanged: wallpaperSelector.colorScheme = currentText
                    background: Rectangle {
                        color: "#333"
                        border.color: "#555"
                        radius: 4
                    }
                    contentItem: Text {
                        text: colorSchemeComboBox.currentText
                        color: "white"
                        font.pixelSize: 12
                        padding: 6
                        verticalAlignment: Text.AlignVCenter
                    }
                    delegate: ItemDelegate {
                        width: colorSchemeComboBox.width
                        contentItem: Text {
                            text: modelData
                            color: "white"
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                            color: highlighted ? "#555" : "#333"
                        }
                    }
                }
            }
        }
    }
    
    // SETTINGS TOGGLE BUTTON!!
    Button {
        text: settingsPanel.visible ? "Hide Settings" : "⚙️ Settings"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        onClicked: settingsPanel.visible = !settingsPanel.visible
        background: Rectangle {
            color: "#333"
            border.color: "#555"
            radius: 6
        }
        contentItem: Text {
            text: parent.text
            color: "white"
            horizontalAlignment: Text.AlignHCenter
        }
    }


    // Timer to hide feedback text
    Timer {
        id: feedbackTimer
        interval: 2000
        onTriggered: {
            feedbackText.visible = false
            feedbackText.text = ""
        }
    }


    FolderListModel {
        id: folderModel
        folder: wallpaperDir
        nameFilters: ["*.jpg", "*.png", "*.jpeg", "*.webp", "*.bmp"]
        showDirs: false
        
        Component.onCompleted: {
            console.log("🔥 WALLPAPER DEBUG TIME BESTIE 🔥")
            console.log("wallpaperDir variable:", wallpaperDir)
            console.log("folder property:", folder)
            console.log("checking folder exists:", Qt.resolvedUrl(wallpaperDir))
            
            // wait a hot sec then check count bc folder loading is async bestie
            debugTimer.start()
        }
    }
    
    Timer {
        id: debugTimer
        interval: 100
        repeat: true
        running: false
        
        onTriggered: {
            console.log("📁 checking folder count:", folderModel.count)
            if (folderModel.count > 0) {
                console.log("✨ YESSS found", folderModel.count, "wallpapers lets gooo")
                for (var i = 0; i < folderModel.count; i++) {
                    console.log("  - wallpaper", i + 1, ":")
                    console.log("    fileName:", folderModel.get(i, "fileName"))
                    console.log("    filePath:", folderModel.get(i, "filePath"))
                    console.log("    fileURL:", folderModel.get(i, "fileURL"))
                }
                stop() // we got the tea now stop spamming
            } else {
                console.log("💀 still no wallpapers found... folder path sus?")
                console.log("current folder:", folderModel.folder)
            }
        }
    }
}
