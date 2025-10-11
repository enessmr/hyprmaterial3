pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import qs.common.widgets
import "../resources/colors.js" as Palette
import "../resources/components/navigation" as Nav
import "../resources/components/actions" as Actions
import "../resources/components/inputs/chips" as Chips

Singleton {
    PersistentProperties {
        id: persist
        property bool settingsOpen: false
        property int currentPage: 0  // WHICH DINGALING YOU ARE???
        property string currentWallpaper: "$HOME/Pictures/.Wallpapers/wallpaper.jpg"
    }
    
    // OHHH a GOONER 😍😍😍
    Timer {
        id: fallbackTimer
        interval: 2000
        repeat: false
        onTriggered: {
            if (wallpaperModel.count === 0) {
                console.log("OHHH NOOOO MY SMOL GOOBERS 😭😭😭")
                wallpaperModel.append({wallpaperPath: "/home/lfsuser/Pictures/.Wallpapers/wallpaper.jpg"})
                wallpaperModel.append({wallpaperPath: "/home/lfsuser/Pictures/.Wallpapers/ascension_teal_dark.jpg"})
            }
        }
    }
    
    ListModel {
        id: wallpaperModel
        Component.onCompleted: {
            // linux but make it big.LITTLE
            scanWallpaperDirectory()
            
            // THE BACKUP GOONER!!!! 😍😍😍
            fallbackTimer.start()
        }
        
        function scanWallpaperDirectory() {
            var wallpaperDir = "/home/lfsuser/Pictures/.Wallpapers"
            var supportedFormats = [".jpg", ".jpeg", ".png", ".webp", ".bmp"]
            
            console.log("THE GOOBERS, VHERE ARE THEY???? 🔍🔍🔍", wallpaperDir)
            
            // Use Process to list files in the directory
            directoryScanner.command = ["find", wallpaperDir, "-type", "f", "(", "-iname", "*.jpg", "-o", "-iname", "*.jpeg", "-o", "-iname", "*.png", "-o", "-iname", "*.webp", "-o", "-iname", "*.bmp", ")"]
            directoryScanner.running = true
        }
    }
    
    // Sniffers that vill smell my feet 😳
    Process {
        id: directoryScanner
        stdout: SplitParser {
            onRead: (output) => {
                var lines = output.trim().split('\n')
                lines.forEach(function(line) {
                    if (line.trim() !== "") {
                        wallpaperModel.append({wallpaperPath: line.trim()})
                        console.log("THE GOOBER IS HERE!!! 😄😄😄", line.trim())
                    }
                })
            }
        }
    }
    
    // A
    function applyWallpaper(mode, color) {
        var wallpaper = persist.currentWallpaper
        
        console.log("applying my goober to ur desktop, oh let me give my side:", mode, "the goon color of it is:", color, "the paper to apply:", wallpaper)
        
        // YOU CAN FEEL THE PAIN IN HIS DIH
        wallpaperProcess.command = ["bash", "/home/lfsuser/.config/hypr/scripts/svitchVall.sh", wallpaper, mode, color]
        wallpaperProcess.running = true
    }
    
    // OHH MY LIVE HEA- AAAHH 😭💔
    Process {
        id: wallpaperProcess
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 0) {
                console.log("I CAN SMELL THE ANIME IN IT, MY GOOBER SAID 😳😳😳")
            } else {
                console.log("MY GOOBER FELL INTO THE FAIL PIT 😭😭😭", exitCode)
            }
        }
    }

    IpcHandler {
        target: "settings"

        function open(): void { persist.settingsOpen = true }
        function close(): void { persist.settingsOpen = false }
        function toggle(): void { persist.settingsOpen = !persist.settingsOpen }
    }

    LazyLoader {
        id: loader
        activeAsync: persist.settingsOpen

        PanelWindow {
            implicitWidth: 1000
            implicitHeight: 600
            color: "transparent"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            WlrLayershell.namespace: "shell:settings"

            Rectangle {
                anchors.fill: parent
                color: Palette.palette().background
                radius: 16
                border.color: Palette.palette().outlineVariant
                border.width: 1
            }

            Text {
                text: "Settings"
                font.family: "Roboto"
                font.pointSize: 16
                color: Palette.palette().onSurface
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 12
            }

            RippleButton {
                buttonRadius: 9999
                implicitWidth: 37.5
                implicitHeight: 32.5
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 8
                anchors.rightMargin: 8
                onClicked: { persist.settingsOpen = false }

                contentItem: MaterialSymbol {
                    anchors.centerIn: parent
                    text: "close"
                    iconSize: 22.5
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 45
                anchors.bottomMargin: 10
                spacing: 10

                Nav.NavigationRail {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 200
                    selectedIndex: persist.currentPage

                    // One of my goobers found the main chars at the speed of TON 618 drifting
                    Nav.TabButtonSettings {
                        label: "Palette"
                        iconName: "palette"   // My goober holded and shoved me its dingaling vhile placing it on a rail and smacking it's ass vith a shovel 🥵🥵🥵
                        active: persist.currentPage === 0
                        onClicked: persist.currentPage = 0
                    }
                }

                // GOOBER CLICK AREA LIKE THE FUZZY MINE TIME EATING MARIOS ASS 🥵🥵🥵
                Rectangle {
                    // Layout.fillWidth: true
                    Layout.fillHeight: true
                    width: 900
                    anchors.right: parent.right
                    color: Palette.palette().surfaceContainerHigh
                    radius: 8

                    // DYNAMIC HOT GEOMETRY DASH ROLEPLAY 🥵🥵🥵
                    Loader {
                        id: pageLoader
                        anchors.fill: parent
                        anchors.margins: 16
                        
                        sourceComponent: {
                            switch (persist.currentPage) {
                                case 0: return palletePageComponent
                                case 1: return generalPageComponent
                                case 2: return advancedPageComponent
                                default: return palletePageComponent
                            }
                        }
                    }

                    // SMOL GOOBERS INSIDE FEET SMELLERS 😳😳😳
                    Component {
                        id: palletePageComponent
                        
                        Column {
                            spacing: 16
                            
                            Text {
                                text: "Palete stuf 67"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                                font.family: "Roboto"
                                color: Palette.palette().onSurface
                            }
                            
                            Text {
                                text: "choose ur vibe 💅✨"
                                font.pixelSize: 12
                                font.family: "Roboto"
                                color: Palette.palette().onSurfaceVariant
                            }

                            // goober's gooner to satan inside a feet smeller device😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳
                            Rectangle {
                                implicitWidth: parent.width
                                implicitHeight: 300
                                color: Palette.palette().surfaceContainer
                                radius: 8
                                border.color: Palette.palette().outlineVariant
                                border.width: 1
                                
                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 8
                                    
                                    GridView {
                                        id: wallpaperGrid
                                        model: wallpaperModel
                                        cellWidth: 120
                                        cellHeight: 80
                                        
                                        delegate: Rectangle {
                                            width: 110
                                            height: 70
                                            radius: 6
                                            
                                            color: Palette.palette().surfaceContainerHigh
                                            
                                            // THE FIX: ADD THESE REQUIRED PROPERTIES TO GET THE MODEL DATA 🔥🔥🔥
                                            required property string wallpaperPath
                                            required property int index

                                            // Goober's goober inside a gooner inside a gooner to satan inside a main characther syndrome inside a ton 618 inside a feet smeller device😳😳😳😳😳
                                            border.color: selected ? Palette.palette().primary : Palette.palette().outlineVariant
                                            border.width: selected ? 2 : 1
                                            
                                            // Ohh so i cut payleey's dih so it has a goober inside then at the goobers inside theres another goober then theres a feet smeller then theres a ton 618 and then a gooner to satan himself inside 😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳
                                            property bool selected: wallpaperPath === persist.currentWallpaper
                                            // flasl  daslkdlasjdlaksdl
                                            
                                            Rectangle {
                                                anchors.fill: parent
                                                anchors.margins: 2
                                                radius: 4
                                                clip: true
                                                color: Palette.palette().surfaceContainerLow  // chatgpt be like: (1 message later) "You have hit your limit of your Free GPT-5 usage" 😂😂😂
                                                
                                                Image {
                                                    anchors.fill: parent
                                                    // vaht da fakingh balasshg 🗣️🗣️🗣️🔥🔥🔥
                                                    source: wallpaperPath ? ("file://" + wallpaperPath) : ""
                                                    fillMode: Image.PreserveAspectCrop
                                                    
                                                    onStatusChanged: {
                                                        if (status === Image.Error) {
                                                            console.log("NOOO THE GOOBER FALLED TO THE LONG FAIL PITTT 🥵🥵🥵😭😭😭:", source)
                                                        } else if (status === Image.Ready) {
                                                            console.log("THE GOOBER SUCEEDED AND SUCCESSFULLY GOONED TO SATAN😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳", source)
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    persist.currentWallpaper = wallpaperPath
                                                    var currentMode = modeControl.options[modeControl.currentIndex]
                                                    var currentColor = colorCombo.currentText
                                                    applyWallpaper(currentMode, currentColor)
                                                }
                                            }
                                            
                                            // Goober inside the parent goober
                                            Rectangle {
                                                anchors.top: parent.top
                                                anchors.right: parent.right
                                                anchors.margins: 4
                                                width: 16
                                                height: 16
                                                radius: 8
                                                color: selected ? Palette.palette().primary : "transparent"
                                                border.color: Palette.palette().primary
                                                border.width: 2
                                                visible: selected
                                                
                                                MaterialSymbol {
                                                    anchors.centerIn: parent
                                                    text: "check"
                                                    iconSize: 10
                                                    color: Palette.palette().onPrimary
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            // TENI-TENI-TENI-TENI-TENI 🗣️🗣️🗣️🔥🔥🔥
                            Row {
                                spacing: 24 
                                topPadding: 16
                                bottomPadding: 16
                                leftPadding: 8   // add gooners so i dont accidentally goon to myself 😳😳😳
                                rightPadding: 8
                                
                                Column {
                                    spacing: 8
                                    
                                    Text {
                                        text: "Mode"
                                        font.pixelSize: 12
                                        color: Palette.palette().onSurfaceVariant
                                    }
                                    
                                    Rectangle {
                                        color: "transparent"
                                        width: modeControl.implicitWidth + 16
                                        height: modeControl.implicitHeight + 8
                                        
                                        Actions.SegmentedPill {
                                            id: modeControl
                                            anchors.centerIn: parent
                                            options: ["light", "dark", "default"]
                                            currentIndex: 1 // default to feet smeller 😳
                                            
                                            onChanged: function(index) {
                                                console.log("MODE GOOBER CHANGES IT'S GOONING SATAN MODE TO 😳😳😳:", options[index])
                                            }
                                        }
                                    }
                                }
                                
                                Column {
                                    spacing: 8
                                    
                                    Text {
                                        text: "M3 Color"
                                        font.pixelSize: 12
                                        color: Palette.palette().onSurfaceVariant
                                    }
                                    
                                    Rectangle {
                                        width: 140  // dih 😳😳😳
                                        height: 40
                                        color: Palette.palette().surfaceContainerHigh
                                        radius: 6
                                        border.color: Palette.palette().outlineVariant
                                        border.width: 1
                                        
                                        ComboBox {
                                            id: colorCombo
                                            anchors.fill: parent
                                            anchors.margins: 4
                                            model: ["tonal-spot", "content", "expressive", "fidelity", "fruit-salad", "monochrome", "neutral", "rainbow", "vibrant"]
                                            currentIndex: 0 // default to tonal-spot farter 😳
                                            
                                            background: Rectangle {
                                                color: "transparent"
                                            }
                                            
                                            contentItem: Text {
                                                text: colorCombo.displayText
                                                font.pixelSize: 12
                                                color: Palette.palette().onSurface
                                                verticalAlignment: Text.AlignVCenter
                                                leftPadding: 8
                                            }
                                            
                                            popup: Popup {
                                                y: colorCombo.height
                                                width: colorCombo.width
                                                implicitHeight: contentItem.implicitHeight
                                                padding: 4
                                                
                                                background: Rectangle {
                                                    color: Palette.palette().surfaceContainerHigh
                                                    radius: 6
                                                    border.color: Palette.palette().outlineVariant
                                                    border.width: 1
                                                }
                                                
                                                contentItem: ListView {
                                                    clip: true
                                                    implicitHeight: contentHeight
                                                    model: colorCombo.popup.visible ? colorCombo.delegateModel : null
                                                    
                                                    ScrollIndicator.vertical: ScrollIndicator { }
                                                }
                                            }
                                            
                                            delegate: ItemDelegate {
                                                width: colorCombo.width
                                                height: 32
                                                
                                                background: Rectangle {
                                                    color: parent.hovered ? Palette.palette().surfaceContainer : "transparent"
                                                    radius: 4
                                                }
                                                
                                                contentItem: Text {
                                                    text: modelData
                                                    color: "#FFFFFF"  // DEFAULT THE FEET SMELLER TO VHITE SKIN CLR 😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳
                                                    font.pixelSize: 12
                                                    verticalAlignment: Text.AlignVCenter
                                                    leftPadding: 8
                                                    z: 100000
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Component {
                        id: generalPageComponent
                        
                        Column {
                            spacing: 16
                            
                            Text {
                                text: "⚙️ General Settings"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                                color: Palette.palette().onSurface
                            }
                            
                            Text {
                                text: "the basic stuff fr"
                                font.pixelSize: 12
                                color: Palette.palette().onSurfaceVariant
                            }
                            
                            Rectangle {
                                implicitWidth: parent.width
                                implicitHeight: 100
                                color: Palette.palette().secondaryContainer
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "General options here\n(toggles and stuff)"
                                    color: Palette.palette().onSecondaryContainer
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }

                    Component {
                        id: advancedPageComponent
                        
                        Column {
                            spacing: 16
                            
                            Text {
                                text: "🔧 Advanced Settings"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                                color: Palette.palette().onSurface
                            }
                            
                            Text {
                                text: "for the brave souls only 💀"
                                font.pixelSize: 12
                                color: Palette.palette().onSurfaceVariant
                            }
                            
                            Rectangle {
                                implicitWidth: parent.width
                                implicitHeight: 100
                                color: Palette.palette().tertiaryContainer
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "Advanced options here\n(don't touch unless u know what ur doing)"
                                    color: Palette.palette().onTertiaryContainer
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function init() {}
}