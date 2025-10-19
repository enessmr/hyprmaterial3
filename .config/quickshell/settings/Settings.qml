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
import "../resources/components/Menu" as Menu

Singleton {
    id: dihSettingsRootFrFrNoCapNoCapDingaling

    property string homeDir: Quickshell.env("HOME") || ""

    PersistentProperties {
        id: persist
        property bool settingsOpen: false
        property bool dihNoTsNotVisibleVhatItsNotTuff67: persist.settingsOpen
        property int currentPage: 0  // WHICH DINGALING YOU ARE???
        property string currentWallpaper: dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/Pictures/.Wallpapers/wallpaper.jpg"
    }
    
    // OHHH a GOONER 😍😍😍
    Timer {
        id: fallbackTimer
        interval: 2000
        repeat: false
        onTriggered: {
            if (wallpaperModel.count === 0) {
                console.log("OHHH NOOOO MY SMOL GOOBERS 😭😭😭")
                wallpaperModel.append({
                    wallpaperPath: dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/Pictures/.Wallpapers/wallpaper.jpg",
                    wallpaperPathCached: dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/Pictures/.Wallpapers/wallpaper.jpg"
                })
                wallpaperModel.append({
                    wallpaperPath: dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/Pictures/.Wallpapers/ascension_teal_dark.jpg",
                    wallpaperPathCached: dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/Pictures/.Wallpapers/ascension_teal_dark.jpg"
                })
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
            var wallpaperDir = dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/Pictures/.Wallpapers"
            console.log("THE GOOBERS, VHERE ARE THEY???? 🔍🔍🔍", wallpaperDir)
            
            wallpaperModel.clear()
            
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
                        var path = line.trim()
                        wallpaperModel.append({
                            wallpaperPath: path,
                            wallpaperPathCached: path
                        })
                        console.log("THE GOOBER IS HERE!!! 😄😄😄", path)
                    }
                })
            }
        }
    }

    signal colorsChanged()
    property int colorRefreshTrigger: 0
    property var freshPalette: Palette.palette()
    
    // A
    function applyWallpaper(mode, color) {
        var wallpaper = persist.currentWallpaper
        
        console.log("applying my goober to ur desktop, oh let me give my side:", mode, "the goon color of it is:", color, "the paper to apply:", wallpaper)
        
        // YOU CAN FEEL THE PAIN IN HIS DIH
        wallpaperProcess.command = ["bash", dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/.config/hypr/scripts/svitchVall.sh", wallpaper, mode, color]
        wallpaperProcess.running = true

        onChanged: {
            var freshPalette = Palette.palette()
        }
    }

    Connections {
        target: wallpaperProcess
        function onExited(exitCode) {
            if (exitCode === 0) {
                console.log("🎨 FORCING COLOR RELOAD GOOBER STYLE");
                colorsChanged();
                colorRefreshTrigger++;
            }
        }
    }

    // dih no gooner 67 vhy u play super luigi 46 and sell my heart for tha-
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
        function toggle(): void { persist.settingsOpen = !persist.settingsOpen; console.log("dih") }
    }

    LazyLoader {
        id: loader
        activeAsync: true

        ApplicationWindow {
            width: 1000
            height: 600
            color: "transparent"
            title: "I Tuch Myself 2 My Comits 😍"
            visible: persist.dihNoTsNotVisibleVhatItsNotTuff67
            id: dihtsvindovisnttuff
            property var paletteCache: dihSettingsRootFrFrNoCapNoCapDingaling.freshPalette
            flags: Qt.FramelessWindowHint

            // FOUND A 12 INCH DINGALING AND A GOONER THO NGL??? 😳😳😳
            property var windowGeometry: ({
                x: 0,
                y: 0,
                width: 1000,
                height: 600
            })

            // KEEP THAT 12 INCH DINGALING AND GOONER!!! 🫙🫙🫙 
            onClosing: {
                if (dihtsvindovisnttuff.visibility !== Window.FullScreen) {
                    windowGeometry = {
                        x: x,
                        y: y,
                        width: width,
                        height: height
                    }
                }
            }

            onVisibleChanged: {
                if (visible) {
                    x = windowGeometry.x
                    y = windowGeometry.y
                    width = windowGeometry.width
                    height = windowGeometry.height
                }
            }

            Rectangle {
                // anchors.fill: parent
                color: paletteCache.background
                id: dihNoFakNo67DihUhmAAAPDiddyNoPlsNotTuffGoonerITuchedMySelf
                radius: dihtsvindovisnttuff.visibility === Window.FullScreen ? 0 : 16
                border.color: paletteCache.outlineVariant
                border.width: 1
                width: parent.width
                height: parent.height
                x: parent.x
                y: parent.y
                z: -10 // 🔥 VINDOV LAYER IN THE SHADOW REALM 🔥

                Behavior on radius {
                    NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                }
            }

            Text {
                text: "Settings"
                font.family: "Roboto"
                font.pointSize: 16
                color: paletteCache.onSurface
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 12
                z: 1  // 🗣️ TEXT ON TOP 🗣️
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
                z: 1  // 🔥 BUTTON ON TOP TOO 🔥
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
                    z: -9  // 😳 TABS IN THE GOOBER LAYER 😳

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
                    //Layout.fillWidth: true
                    Layout.fillHeight: true
                    width: dihtsvindovisnttuff.width
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 80
                    color: paletteCache.surfaceContainerHigh
                    radius: 8

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

                    Component {
                        id: palletePageComponent
                        
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 16
                            
                            Text {
                                text: "Palete stuf 67"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                                font.family: "Roboto"
                                color: paletteCache.onSurface
                                z: 1
                            }
                            
                            Text {
                                text: "choose ur vibe 💅✨"
                                font.pixelSize: 12
                                font.family: "Roboto"
                                color: paletteCache.onSurfaceVariant
                                z: 1
                            }

                            Item {
                                id: wallpaperContainer
                                implicitWidth: parent.width
                                implicitHeight: 300
                                
                                Rectangle {
                                    id: realWallpaperGrid
                                    anchors.fill: parent
                                    
                                    color: paletteCache.surfaceContainer
                                    radius: 8
                                    border.color: paletteCache.outlineVariant
                                    border.width: 1
                                    z: -9  // 😳 VALLPAPER BG CONTAINER 😳
                                    
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
                                                z: 9999  // 🔥🔥🔥 KEEP DELEGATE AT NORMAL LAYER 🔥🔥🔥
                                                
                                                color: Palette.palette().surfaceContainerHigh
                                                
                                                // Goober's goober inside a gooner inside a gooner to satan inside a main characther syndrome inside a ton 618 inside a feet smeller device😳😳😳😳😳😳
                                                required property string wallpaperPath
                                                required property int index
                                                property string actualWallpaperPath: wallpaperPath || ""
                                                // Goober's goober inside a gooner inside a gooner to satan inside a main characther syndrome inside a ton 618 inside a feet smeller device😳😳😳😳😳
                                                border.color: selected ? Palette.palette().primary : Palette.palette().outlineVariant
                                                border.width: selected ? 2 : 1
          
                                                // Ohh so i cut payleey's dih so it has a goober inside then at the goobers inside theres another goober then theres a feet smeller then theres a ton 618 and then a gooner to satan himself inside 😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳
                                                property bool selected: {
                                                    var isSelected = actualWallpaperPath === persist.currentWallpaper
                                                    return isSelected
                                                }           
                                                // flasl  daslkdlasjdlaksdl

                                                Rectangle {
                                                    anchors.fill: parent
                                                    anchors.margins: 2
                                                    radius: 4
                                                    clip: true
                                                    color: Palette.palette().surfaceContainerLow  // chatgpt be like: (1 message later) "You have hit your limit of your Free GPT-5 usage" 😂😂😂
                                                    z: 0
                                                    Image {
                                                        anchors.fill: parent
                                                        // vaht da fakingh balasshg 🗣️🗣️🗣️🔥🔥🔥
                                                        source: actualWallpaperPath ? ("file://" + actualWallpaperPath) : ""
                                                        fillMode: Image.PreserveAspectCrop
                                                        cache: true  // 🔥 CACHE THE IMAGE SO IT DONT RELOAD 🔥
                                                        asynchronous: true  // LOAD ASYNC SO UI DONT FREEZE 💯
                                                        z: 0
                                                        
                                                        Component.onCompleted: {
                                                            console.log("LOCKING IN THE GOOBER PATH:", actualWallpaperPath, "💪💪💪")
                                                        }
                                                        
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
                                                    z: 1  // 🔥 MOUSE AREA ON TOP SO U CAN CLICK 🔥
                                                    onClicked: {
                                                        persist.currentWallpaper = actualWallpaperPath
                                                        var currentMode = modeControl.options[modeControl.currentIndex]
                                                        var currentColor = colorCombo.displayText
                                                        applyWallpaper(currentMode, currentColor)
                                                    }
                                                }
                                                
                                                Rectangle {
                                                    anchors.top: parent.top
                                                    anchors.right: parent.right
                                                    anchors.margins: 4
                                                    width: 16
                                                    height: 16
                                                    radius: 10
                                                    color: selected ? paletteCache.primary : "transparent"
                                                    border.color: paletteCache.primary
                                                    border.width: 2
                                                    visible: selected
                                                    z: 999  // 🔥🔥🔥 CHECK CIRCLE ON TOP BABYYYY 🔥🔥🔥
                                                    
                                                    MaterialSymbol {
                                                        anchors.centerIn: parent
                                                        text: "check"
                                                        iconSize: 10
                                                        color: paletteCache.onPrimary
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Row {
                                Layout.fillWidth: true  // 🔥 FILL THE WIDTH 🔥
                                Layout.preferredHeight: 60  // 🔥 FIXED HEIGHT FOR CONTROLS 🔥
                                spacing: 24
                                leftPadding: 8
                                rightPadding: 8   // add gooners so i dont accidentally goon to myself 😳😳😳
                                
                                Column {
                                    spacing: 8

                                    anchors.right: parent.right
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 0
                                            
                                    anchors.leftMargin: 20


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
                                            options: ["light", "dark"]
                                            currentIndex: 1 // default to feet smeller 😳
                                            
                                            onChanged: function(index) {
                                                console.log("MODE GOOBER CHANGES IT'S GOONING SATAN MODE TO 😳😳😳:", options[index])
                                            }
                                        }
                                    }
                                }
                                
                                Column {
                                    spacing: 8

                                            anchors.right: parent.right
                                            anchors.left: parent.left
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 0
                                            
                                            anchors.leftMargin: 90
                                    
                                    Text {
                                        text: "M3 Color"
                                        font.pixelSize: 12
                                        color: Palette.palette().onSurfaceVariant
                                        anchors.left: parent.left
                                        anchors.leftMargin: 200
                                    }
                                    
                                    Rectangle {
                                        id: colorComboContainer
                                        width: 140  // dih 😳😳😳
                                        height: 40
                                        color: Palette.palette().surfaceContainerHigh
                                        radius: 6
                                        border.color: Palette.palette().outlineVariant
                                        border.width: 1
                                        anchors.left: parent.left
                                        anchors.leftMargin: 200
                                        
                                        // THE CUSTOM HAMBURGER MENU COMBOBOX REPLACEMENT 🔥🔥🔥
                                        property string selectedColor: "tonal-spot"
                                        property var colorOptions: ["tonal-spot", "content", "expressive", "fidelity", "fruit-salad", "monochrome", "neutral", "rainbow", "vibrant"]
                                        
                                        // THE DISPLAY TEXT AND ARROW 🗣️🗣️🗣️
                                        Row {
                                            anchors.fill: parent
                                            anchors.margins: 8
                                            spacing: 4
                                            
                                            Text {
                                                id: colorCombo
                                                text: colorComboContainer.selectedColor
                                                font.pixelSize: 12
                                                color: Palette.palette().onSurface
                                                verticalAlignment: Text.AlignVCenter
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: parent.width - 20
                                                elide: Text.ElideRight
                                                
                                                // EXPOSE displayText SO THE REST OF THE CODE STILL VORKS 💀💀💀
                                                property string displayText: text
                                            }
                                            
                                            Text {
                                                text: "▼"
                                                font.pixelSize: 10
                                                color: Palette.palette().onSurfaceVariant
                                                anchors.verticalCenter: parent.verticalCenter
                                            }
                                        }
                                        
                                        // CLICK TO OPEN THE HAMBURGERMENU 🍔🍔🍔
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                // BUILD THE MENU ITEMS ARRAY FROM COLOR OPTIONS 🔥🔥🔥
                                                var menuItems = []
                                                for (var i = 0; i < colorComboContainer.colorOptions.length; i++) {
                                                    var colorName = colorComboContainer.colorOptions[i]
                                                    menuItems.push({
                                                        label: colorName,
                                                        enabled: true,
                                                        onTriggered: (function(color) {
                                                            return function() {
                                                                colorComboContainer.selectedColor = color
                                                                console.log("OHHHH U PICKED THE COLOR SCHEME:", color, "FRFR NO CAP 🔥🔥🔥")
                                                            }
                                                        })(colorName)
                                                    })
                                                }
                                                
                                                // OPEN THE HAMBURGERMENU AT THE COMBOBOX LOCATION 💅✨
                                                colorSchemeMenu.items = menuItems
                                                colorSchemeMenu.openAtItem(colorComboContainer)
                                            }
                                        }
                                        
                                        // THE HAMBURGERMENU OVERLAY (LIVES OUTSIDE BUT ANCHORED HERE) 😳😳😳
                                        Menu.HamburgerMenu {
                                            id: colorSchemeMenu
                                            anchors.fill: parent
                                            minWidth: 140
                                            z: 99999  // 🔥🔥🔥 MENU ON TOP OF EVERYTHING 🔥🔥🔥
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