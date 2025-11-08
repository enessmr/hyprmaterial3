pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQml
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
import qs.common

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

    property var paletteCache: Palette.palette()
    property var paletteCacheText: Palette.palette()
    property string goonerLogged: "0"

    // i am breaking the rules but i collabed vith chatgpt for fixing my broken Process lmfao😳
    Process {
        id: goonerFinder
        running: true
        command: [ "bash", "-c", "swww query | sed -n 's/.*image: //p'" ]

        stdout: StdioCollector {
            onStreamFinished: {
                persist.currentWallpaper = Qt.resolvedUrl(this.text.trim())
                if (goonerLogged == "0") {
                    persist.currentWallpaper = Qt.resolvedUrl(this.text.trim())
                    Config.options.background.wallpaperPath = Qt.resolvedUrl(this.text.trim())
                    console.log(`FOUND GOONER CURRENTLY GOONING TO UR DINGALING SUCCESFULLY😳😳😳😳 ${this.text.trim()}`)
                    console.log(`IF IT DIH GOT CUT HERES A LOG FOR ITS DINGALING TO REPLACE HIS DIH😭😭😭😭 ${Qt.resolvedUrl(this.text.trim())}`)
                    goonerLogged++;
                }
                paletteCache = Palette.palette();
                paletteCacheText = Palette.palette();
                goonerFinder.running = false;
                goonerFinder.running = true;
            }
        }
    }
    
    // OHHH a GOONER 😍😍😍
    Timer {
        id: fallbackTimer
        interval: 2000
        repeat: false
        onTriggered: {
            if (wallpaperModel.count === 0) {
                console.log("OHHH NOOOO MY SMOL GOOBERS 😭😭😭")
                console.log("THEY GOONED TO A FAIL PIT THEN D'OHED LIKE MARIO AND GOONED TO THEIR D'OH AND DINGALING ☠️☠️☠️☠️☠️")
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
    property var freshPalette: AppearanceRippleButton.m3colors
    
    // A
    function applyWallpaper(mode, color) {
        var wallpaper = persist.currentWallpaper.replace("file://", "")
        
        console.log("applying my goober to ur desktop, oh let me give my side:", mode, "the goon color of it is:", color, "the paper to apply:", wallpaper)

        // YOU CAN FEEL THE PAIN IN HIS DIH
        wallpaperProcess.command = ["bash", dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/.config/hypr/scripts/svitchVall.sh", wallpaper, mode, color]
        wallpaperProcess.running = true

        onChanged: {
            goonerLogged = "0";
            paletteCache = Palette.palette();
            reloadTimer.start()
        }
    }

    Timer {
        id: reloadTimer
        interval: 20
        onTriggered: {
            console.log("🎨 FORCING PALETTE RELOAD AFTER DELAY!!!")
            paletteCache = Palette.palette()
            paletteCacheText = Palette.palette()
            colorRefreshTrigger++
            colorsChanged()
        }
    }

    Connections {
        target: wallpaperProcess
        function onExited(exitCode) {
            if (exitCode === 0) {
                console.log("FORCING GOON RELOAD IT AGE 18 RN ALVAYS YKYK AHH DIH OHMMMM 😍🍑");
                freshPalette = Palette.palette();
                paletteCache = Palette.palette();
                paletteCacheText = Palette.palette();  // 🔥 ACTUALLY UPDATE IT 🔥
                colorsChanged();
                colorRefreshTrigger++;
            }
        }
    }

    // dih no gooner 67 vhy u play super luigi 46 and sell my heart for tha-
    // OHH MY LIVE HEA- AAAHH 😭💔
    Process {
        id: wallpaperProcess
        stdout: SplitParser {
            onRead: (output) => {
                console.log("📜 SCRIPT OUTPUT:", output.trim())
            }
        }

        stderr: SplitParser {
            onRead: (output) => {
                console.log("❌ SCRIPT ERROR:", output.trim())
            }
        }

        onExited: (exitCode, exitStatus) => {
            console.log("🔍 SCRIPT EXITED - CODE:", exitCode, "STATUS:", exitStatus)
            if (exitCode === 0) {
                console.log("I CAN SMELL THE ANIME IN IT, MY GOOBER SAID 😳😳😳")
            } else {
                console.log("MY GOOBER FELL INTO THE FAIL PIT 😭😭😭")
                console.log("COMMAND VAS:", command)
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
        loading: true

        ApplicationWindow {
            minimumWidth: 400
            minimumHeight: 200
            color: "transparent"
            title: "I Tuch Myself 2 My Comits 😍"
            visible: persist.dihNoTsNotVisibleVhatItsNotTuff67
            id: dihtsvindovisnttuff
            // update gooner so hes 18 everytime 😍🍑
            flags: Qt.Window | Qt.WindowStaysOnTopHint

            // FOUND A 12 INCH DINGALING AND A GOONER THO NGL??? 😳😳😳
            property var windowGeometry: ({
                x: 0,
                y: 0,
                width: 1000,
                height: 600
            })

            Connections {
                target: dihSettingsRootFrFrNoCapNoCapDingaling
                function onColorRefreshTriggerChanged() {
                    console.log("🎨 PALETTE UPDATE TRIGGERED, REFRESHING THE GOOBER CACHE 🎨")
                    paletteCache = Palette.palette()
                    paletteCacheText = Palette.palette()
                }
            }

            FileView {
  		        path:  Quickshell.env("HOME") + "/.config/quickshell/resources/colors.js"

  		        // when changes are made on disk, reload the file's content
  		        watchChanges: true
  		        onFileChanged: {
                    console.log("GOONER CHANGED CATCHED PIC FRICKING TO A DIH 😳😳😳")
                    reload()

                    // Force reload by re-evaluating the palette
                    paletteCache = Palette.palette()
                    paletteCacheText = Palette.palette()
                    freshPalette = Palette.palette()
        
                    // Trigger property changes to force UI updates
                    colorRefreshTrigger++
                    colorsChanged()
                }    
	        }

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
                persist.settingsOpen = false
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
                z: -10 // 🔥 VINDOV LAYER IN THE SHADOW REALM 🔥

                Behavior on radius {
                    NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                }

                Behavior on scale {
                    NumberAnimation { duration: 800; easing.type: Easing.InOutQuad }
                }
            }

            Text {
                text: "Settings"
                font.family: "Roboto"
                font.pointSize: 16
                color: paletteCacheText.onSurface
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
                    Layout.preferredWidth: 70
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
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    // width: dihtsvindovisnttuff.width
                    // Layout.margins: 0       // general margin
                    // Layout.leftMargin: 80    // specific left margin
                    color: paletteCache.surfaceContainerHigh
                    radius: 8

                    Loader {
                        id: pageLoader
                        anchors.fill: parent
                        anchors.margins: 16
                        active: true
                        
                         source: {
        switch (persist.currentPage) {
            case 0: return "pages/PalettePage.qml"  // 🔥 LOAD THE SEPARATE FILE 🔥
            // case 1: return "pages/GeneralPage.qml"
            // case 2: return "pages/AdvancedPage.qml"
            default: return "pages/PalettePage.qml"
        }
    }
    
    // 💀💀💀 PASS ALL THE DINGHALING PROPS TO THE PAGE 💀💀💀
    onLoaded: {
        item.paletteCache = Qt.binding(() => paletteCache)
        item.paletteCacheText = Qt.binding(() => paletteCacheText)
        item.persist = persist
        item.wallpaperModel = wallpaperModel
        item.applyWallpaper = applyWallpaper
        item.colorSchemeMenu = colorSchemeMenu
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

            // THE GOONER SELECTER (LIVES INSIDE A DIH OHM BUT INSIDE A GOOBER) 🥵🥵🥵
            Menu.HamburgerMenu {
                id: colorSchemeMenu
                anchors.fill: parent
                minWidth: 140
                z: 99999  // GOON ON TOP OF MY DIH 🥵🥵🥵💦💦💦
            }
        }
    }

    function init() {}
}