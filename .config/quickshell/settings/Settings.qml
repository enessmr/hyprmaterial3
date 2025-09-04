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
        property int currentPage: 0  // WHICH PAGE WE ON BESTIE
        property string currentWallpaper: "/home/lfsuser/Pictures/.Wallpapers/wallpaper.jpg"
    }
    
    // Wallpaper model - dynamically load wallpapers from directory
    ListModel {
        id: wallpaperModel
        Component.onCompleted: {
            // Dynamically scan the wallpaper directory
            scanWallpaperDirectory()
            
            // Fallback: Add known wallpapers if scanner fails
            setTimeout(function() {
                if (count === 0) {
                    console.log("🆘 Scanner failed, adding fallback wallpapers bestie!")
                    append({wallpaperPath: "/home/lfsuser/Pictures/.Wallpapers/wallpaper.jpg"})
                    append({wallpaperPath: "/home/lfsuser/Pictures/.Wallpapers/ascension_teal_dark.jpg"})
                }
            }, 2000)
        }
        
        function scanWallpaperDirectory() {
            var wallpaperDir = "/home/lfsuser/Pictures/.Wallpapers"
            var supportedFormats = [".jpg", ".jpeg", ".png", ".webp", ".bmp"]
            
            console.log("🔍 Scanning wallpaper directory bestie:", wallpaperDir)
            
            // Use Process to list files in the directory
            directoryScanner.command = ["find", wallpaperDir, "-type", "f", "(", "-iname", "*.jpg", "-o", "-iname", "*.jpeg", "-o", "-iname", "*.png", "-o", "-iname", "*.webp", "-o", "-iname", "*.bmp", ")"]
            directoryScanner.running = true
        }
    }
    
    // Process to scan wallpaper directory
    Process {
        id: directoryScanner
        stdout: SplitParser {
            onRead: (output) => {
                var lines = output.trim().split('\n')
                lines.forEach(function(line) {
                    if (line.trim() !== "") {
                        wallpaperModel.append({wallpaperPath: line.trim()})
                        console.log("🎨 Found wallpaper bestie:", line.trim())
                    }
                })
            }
        }
    }
    
    // Function to apply wallpaper using the svitchVall.sh script - BESTIE ENERGY! ✨
    function applyWallpaper(mode, color) {
        var wallpaper = persist.currentWallpaper
        
        console.log("🎨 Applying wallpaper bestie! Mode:", mode, "Color:", color, "Wallpaper:", wallpaper)
        
        // Execute the wallpaper switching script - LET'S GOOO! 💅
        wallpaperProcess.command = ["bash", "/home/lfsuser/.config/hypr/scripts/svitchVall.sh", wallpaper, mode, color]
        wallpaperProcess.running = true
    }
    
    // Process for executing wallpaper changes - BESTIE POWER! 💪
    Process {
        id: wallpaperProcess
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 0) {
                console.log("✨ Wallpaper changed successfully bestie! Ur vibe is immaculate! 💅")
            } else {
                console.log("😔 Oops bestie, wallpaper change failed with exit code:", exitCode)
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

                // YOUR EXISTING NAV RAIL COMPONENT - CLEAN AS HELL
                Nav.NavigationRail {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 200
                    selectedIndex: persist.currentPage

                    // PALETTE PAGE - THE MAIN CHARACTER
                    Nav.TabButtonSettings {
                        label: "Palette"
                        iconName: "palette"   // this is ur Material Symbols icon
                        active: persist.currentPage === 0
                        onClicked: persist.currentPage = 0
                    }

                    // ADD MORE PAGES IF YOU WANT BESTIE
                    /* Nav.NavigationRailItem {
                        text: "General"
                        selected: persist.currentPage === 1
                        onClicked: persist.currentPage = 1
                        
                        contentItem: Row {
                            anchors.left: parent.left
                            anchors.leftMargin: 16
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 12

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "settings"
                                font.family: "Material Symbols Outlined"
                                font.pixelSize: 20
                                color: parent.parent.selected ? Palette.palette().onSecondaryContainer : Palette.palette().onSurface
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "General"
                                font.pixelSize: 13
                                color: parent.parent.selected ? Palette.palette().onSecondaryContainer : Palette.palette().onSurface
                            }
                        }
                    } 

                    Nav.NavigationRailItem {
                        text: "Advanced"
                        selected: persist.currentPage === 2
                        onClicked: persist.currentPage = 2
                        
                        contentItem: Row {
                            anchors.left: parent.left
                            anchors.leftMargin: 16
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 12

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "tune"
                                font.family: "Material Symbols Outlined"
                                font.pixelSize: 20
                                color: parent.parent.selected ? Palette.palette().onSecondaryContainer : Palette.palette().onSurface
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Advanced"
                                font.pixelSize: 13
                                color: parent.parent.selected ? Palette.palette().onSecondaryContainer : Palette.palette().onSurface
                            }
                        }
                    } */
                }

                // DYNAMIC CONTENT AREA - WHERE THE MAGIC HAPPENS
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: Palette.palette().surfaceContainerHigh
                    radius: 8

                    // DYNAMIC PAGE CONTENT
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

                    // PAGE COMPONENTS - THE CONTENT KINGS
                    Component {
                        id: palletePageComponent
                        
                        Column {
                            spacing: 16
                            
                            Text {
                                text: "🎨 Wallpaper Picker"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                                color: Palette.palette().onSurface
                            }
                            
                            Text {
                                text: "choose ur vibe bestie 💅✨"
                                font.pixelSize: 12
                                color: Palette.palette().onSurfaceVariant
                            }

                            // Wallpaper Preview Grid
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
                                            border.color: selected ? Palette.palette().primary : Palette.palette().outlineVariant
                                            border.width: selected ? 2 : 1
                                            
                                            property bool selected: wallpaperPath === persist.currentWallpaper
                                            
                                            Rectangle {
                                                anchors.fill: parent
                                                anchors.margins: 2
                                                radius: 4
                                                clip: true
                                                color: Palette.palette().surfaceContainerLow  // Fallback color so we can see the rectangles
                                                
                                                Image {
                                                    anchors.fill: parent
                                                    source: "file://" + wallpaperPath
                                                    fillMode: Image.PreserveAspectCrop
                                                    
                                                    onStatusChanged: {
                                                        if (status === Image.Error) {
                                                            console.log("😔 Failed to load wallpaper bestie:", source)
                                                        } else if (status === Image.Ready) {
                                                            console.log("✨ Wallpaper loaded successfully:", source)
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    persist.currentWallpaper = wallpaperPath
                                                    // Get current mode and color from the controls
                                                    var currentMode = modeControl.options[modeControl.currentIndex]
                                                    var currentColor = colorCombo.currentText
                                                    applyWallpaper(currentMode, currentColor)
                                                }
                                            }
                                            
                                            // Selection indicator
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
                            
                            // Mode and Color Controls - PROPER MARGINS BESTIE! 💅
                            Row {
                                spacing: 24  // Increased spacing between controls
                                topPadding: 16
                                bottomPadding: 16
                                leftPadding: 8   // ADD MARGINS SO ITEMS DON'T COLLIDE! 💅
                                rightPadding: 8
                                
                                // Mode Selection - PROPER M3 COMPONENT! ✨
                                Column {
                                    spacing: 8
                                    
                                    Text {
                                        text: "Mode"
                                        font.pixelSize: 12
                                        color: Palette.palette().onSurfaceVariant
                                    }
                                    
                                    Rectangle {
                                        // Container with proper margins so items don't collide! 💅
                                        color: "transparent"
                                        width: modeControl.implicitWidth + 16
                                        height: modeControl.implicitHeight + 8
                                        
                                        Actions.SegmentedControl {
                                            id: modeControl
                                            anchors.centerIn: parent
                                            options: ["light", "dark", "auto"]
                                            currentIndex: 1 // default to dark
                                            
                                            onChanged: function(index) {
                                                console.log("🎨 Mode changed to:", options[index])
                                            }
                                        }
                                    }
                                }
                                
                                // M3 Color Dropdown - WITH PROPER MARGINS! 💅
                                Column {
                                    spacing: 8
                                    
                                    Text {
                                        text: "M3 Color"
                                        font.pixelSize: 12
                                        color: Palette.palette().onSurfaceVariant
                                    }
                                    
                                    Rectangle {
                                        width: 140  // Made wider for better text display
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
                                            currentIndex: 0 // default to tonal-spot (THE GOAT! 🐐)
                                            
                                            background: Rectangle {
                                                color: "transparent"
                                            }
                                            
                                            contentItem: Text {
                                                text: colorCombo.displayText
                                                font.pixelSize: 12
                                                color: Palette.palette().onSurface  // M3 RECOMMENDED! 💅
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
                                                    color: "#FFFFFF"  // FORCE WHITE TEXT - NO MORE INVISIBLE POPUP TEXT! 💅
                                                    font.pixelSize: 12
                                                    verticalAlignment: Text.AlignVCenter
                                                    leftPadding: 8
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