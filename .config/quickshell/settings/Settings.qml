// 💚 ✨ HyprYoshi3 ✨ 🦕

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
import "../resources/components/navigation" as Nav
import "../resources/components/actions" as Actions
import "../resources/components/inputs/chips" as Chips
import "../resources/components/Menu" as Menu
import qs.services
import qs.common
import qs.settings.pages
import qs.common.functions as CF

Singleton {
    id: dihSettingsRootFrFrNoCapNoCapDingaling

    property string homeDir: Quickshell.env("HOME") || ""

    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme()
    }

    PersistentProperties {
        id: persist
        property bool settingsOpen: false
        property bool dihNoTsNotVisibleVhatItsNotTuff67: persist.settingsOpen
        property int currentPage: 0  // WHICH DINGALING YOU ARE???
        property string currentWallpaper: dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/Pictures/.Wallpapers/wallpaper.jpg"
    }

    property var paletteCache: Appearance?.m3colors
    property var paletteCacheText: Appearance?.m3colors
    property string goonerLogged: "0"

    // THE GOONER AI AND THE GOOBER ENESSMR COLLABED TO MAKE THE MOST P DIDDY AHH DIH DIJ BESTIE BABY OIL DIDDLING EXPERIENCE ONTO CORNHUB TO ONLYFANS TO THEY ALL GOON TO EM THEN  ROLLING A NSMBV ITEM PANEL THEN GETTING A JR THEN BLJING ERE O GET NTO MK64 AND GET O 8H EN GAB A SARMAN EN GET 192H EN GET NOTER STEARMAND TI OAIS OIG GET AS DIOYIOT PE T8A SOTKO P FADSK SDJ JAT ISO DSTOT GE TEPO  E OIASJ N MS S FNASKJL TRIASI DOP SM64  TSOAPI K TOP  SBLJ SAKLD AKSJTISUJ NVCM, TO OTHJEHE LA DK DORRIE OCEAN EPLSE ;KDSEVEARTOER BASHJRE EN NMEHGETO SQQAJK DASJ LT O A A  A8 uiaodnbgds oasoPU  FASBDHNAS ASKVKNALTGJ OIUJAS RHTSGHTR EN SAN  AS DI AER RAOIR IOA TO T HGETE MA KL OAAOTOSAJ AAOOB OPASFOPSAODS AOJI O EKO JKLJASLDJLKE KJKJE T A FA KJDK AUUH AIOEASBSNN REDEREE ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟🌟
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
                paletteCache = Appearance?.m3colors;
                paletteCacheText = Appearance?.m3colors;
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

    property alias wallpaperModel: wallpaperModel
    property int wallpaperCount: wallpaperModel.count  // THE P DIDDY INT IS BABY OILING MY DIH TO TICK IT 😍😍😍😍😍😍😍

    signal wallpapersReady()
    
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
                onFinished: {
                    console.log("P DIDDY BABY OILED THE GOOBERS, READY TO FRICK AND GOON 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍")
                    wallpapersReady()
                }
            }
        }
    }

    property string wallpaperCountString: wallpaperModel.count.toString()
    signal colorsChanged()
    property int colorRefreshTrigger: 0
    property var freshPalette: Appearance?.m3colors
    
    // A
    function applyWallpaper(mode, color) {
        var wallpaper = persist.currentWallpaper.replace("file://", "")
        
        console.log("applying my goober to ur desktop, oh let me give my side:", mode, "the goon color of it is:", color, "the paper to apply:", wallpaper)

        // YOU CAN FEEL THE PAIN IN HIS DIH
        wallpaperProcess.command = ["bash", dihSettingsRootFrFrNoCapNoCapDingaling.homeDir + "/.config/hypr/scripts/svitchVall.sh", wallpaper, mode, color]
        wallpaperProcess.running = true

        onChanged: {
            goonerLogged = "0";
            paletteCache = Appearance?.m3colors;
            reloadTimer.start()
        }
    }

    Timer {
        id: reloadTimer
        interval: 20
        onTriggered: {
            console.log("P DIDDY DIDDLING ART GOOBER AFTER THAT 20 BABY OIL TIME PARTITION!!! 💦💦💦💦💦💦")
            paletteCache = Appearance?.m3colors
            paletteCacheText = Appearance?.m3colors
            colorRefreshTrigger++
            colorsChanged()
        }
    }

    Connections {
        target: wallpaperProcess
        function onExited(exitCode) {
            if (exitCode === 0) {
                console.log("FORCING GOON RELOAD IT AGE 18 RN ALVAYS YKYK AHH DIH OHMMMM 😍🍑");
                freshPalette = Appearance?.m3colors;
                paletteCache = Appearance?.m3colors;
                paletteCacheText = Appearance?.m3colors;  // TICK THE GOOBER'S DIH 🥵🥵🥵🥵🥵🥵
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
                console.log("P DIDDYS BABY OIL 💦💦💦", output.trim())
            }
        }

        stderr: SplitParser {
            onRead: (output) => {
                console.log("P DIDDYS BABY OIL SLIPPED 😭😭😭", output.trim())
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
            title: "HyprYoshi3 Gooner Settings 💚🦕😍💦🥵"
            visible: persist.dihNoTsNotVisibleVhatItsNotTuff67
            id: dihtsvindovisnttuff
            // update gooner so hes 18 everytime 😍🍑
            flags: Qt.Window | Qt.WindowStaysOnTopHint

            property var pages: [
        {
            name: "Palette",
            icon: "palette",
            component: "pages/PalettePage.qml"
        },
        {
            name: "General",
            icon: "browse",
            component: "pages/GeneralPage.qml"
        },
        {
            name: "Advanced",
            icon: "settings_alert",
            component: "pages/AdvancedConfig.qml"
        }
    ]

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
                    console.log("P DIDDY'S GOOBER OIL APPLIED TO GOOBER TO MY DIH 💦💦💦")
                    paletteCache = Appearance?.m3colors
                    paletteCacheText = Appearance?.m3colors
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
                color: paletteCache.m3background
                id: dihNoFakNo67DihUhmAAAPDiddyNoPlsNotTuffGoonerITuchedMySelf
                radius: dihtsvindovisnttuff.visibility === Window.FullScreen ? 0 : 16
                border.color: paletteCache.m3outlineVariant
                border.width: 1
                width: parent.width
                height: parent.height
                z: -10 // P DIDDY IN THE DIDDY DIMENSION 💦💦💦

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
                color: paletteCacheText.m3onSurface
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 12
                z: 1  // DIH ON TOP 😳😳😳😳😳😳😳
            }

            RippleButton {
                buttonRadius: 9999
                implicitWidth: 32.5
                implicitHeight: 32.5
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 8
                anchors.rightMargin: 8
                settings: true
                onClicked: { persist.settingsOpen = false }

                contentItem: MaterialSymbol {
                    anchors.centerIn: parent
                    text: "close"
                    iconSize: 22.5
                    horizontalAlignment: Text.AlignHCenter
                }
                z: 1  // DIJ ON TOP TOO 😳😳😳😳
            }

            RowLayout {
                anchors.fill: parent
                anchors.topMargin: 45
                anchors.bottomMargin: 10
                                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                spacing: 10

                Item {
                id: navRailWrapper
                Layout.fillHeight: true
                Layout.margins: 5
                implicitWidth: navRail.expanded ? 150 : fab.baseSize
                Behavior on implicitWidth {
                    animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
                }
                NavigationRail {
        id: navRail
        Layout.fillHeight: true
        spacing: 10
        expanded: iFrickedToMyDih.width <= 900

        NavigationRailExpandButton {
                        focus: dihtsvindovisnttuff.visible
                    }

                     FloatingActionButton {
                        id: fab
                        property bool justCopied: false
                        iconText: justCopied ? "check" : "edit"
                        buttonText: justCopied ? "Path copied" : "Config file"
                        expanded: navRail.expanded
                        downAction: () => {
                            Qt.openUrlExternally(`${Directories.config}/illogical-impulse/config.json`);
                        }
                        altAction: () => {
                            Quickshell.clipboardText = CF.FileUtils.trimFileProtocol(`${Directories.config}/hypryoshi3/config.json`);
                            fab.justCopied = true;
                            revertTextTimer.restart()
                        }

                        Timer {
                            id: revertTextTimer
                            interval: 1500
                            onTriggered: {
                                fab.justCopied = false;
                            }
                        }

                        StyledToolTip {
                            text: "Open the shell config file\nAlternatively right-click to copy path"
                        }
                    }

        NavigationRailTabArray {
            currentIndex: persist.currentPage
            expanded: navRail.expanded
            Repeater {
                model: dihtsvindovisnttuff.pages
                NavigationRailButton {
                    required property var index
                    required property var modelData
                    toggled: persist.currentPage === index
                    onPressed: persist.currentPage = index
                    expanded: navRail.expanded
                    buttonIcon: modelData.icon
                    buttonText: modelData.name
                }
            }
        }

        Item { Layout.fillHeight: true } // DIJ BESTIE 😭😭😭😭😭😭😭😭
    }
                }

                // GOOBER CLICK AREA LIKE THE FUZZY MINE TIME EATING MARIOS ASS 🥵🥵🥵
                Rectangle {
                    id: iFrickedToMyDih
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: paletteCache.m3surfaceContainerHigh
                    radius: 8

                        Loader {
                        id: pageLoader
                        anchors.fill: parent
                        anchors.margins: 16
                        active: true
                        
                         source: {
        switch (persist.currentPage) {
            case 0: return "pages/PalettePage.qml"  // GOON TO THE NEWBORN GOOBER 👩‍🍼👩‍🍼👩‍🍼
            case 1: return "pages/GeneralPage.qml" // GOON TO THE NEWBORN P DIDDY👩‍🍼👩‍🍼👩‍🍼
            case 2: return "pages/AdvancedPage.qml" // GOON TO THE NEWBORN GOONER 👩‍🍼👩‍🍼👩‍🍼
            default: return "pages/PalettePage.qml" // GOON TO THE SHOOK DIH VHILE THE MOMS ARE FEEDING IT 👩‍🍼👩‍🍼👩‍🍼
        }
    }
                    }
                }
            }
        }
    }

    function init() {}
}