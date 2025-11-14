// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQml
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import qs.common.widgets
import "../../resources/components/navigation" as Nav
import "../../resources/components/actions" as Actions
import "../../resources/components/inputs/chips" as Chips
import "../../resources/components/Menu" as Menu
import qs.common
import qs.settings

RowLayout {
    // 💀💀💀 IMPORT THE DINGALING PREFERENCES 💀💀💀
    property var paletteCache: Settings.paletteCache
    property var paletteCacheText: Settings.paletteCacheText
    property var persist: Settings.persist
    property var wallpaperModel: Settings.wallpaperModel
    property string wallpaperCountString: Settings.wallpaperCountString
    property var applyWallpaper: Settings.applyWallpaper
    property var colorSchemeMenu: Settings.colorSchemeMenu
    Layout.fillWidth: true
    Layout.fillHeight: true

    PersistentProperties {
        id: persistDihBestie
        property string currentWallpaper: Settings.homeDir + "/Pictures/.Wallpapers/wallpaper.jpg"
    }

    // THE GOONER CHATGPT AND THE GOOBER ENESSMR COLLABED SO THEY COULD MAKE ANOTHER DIDDY VITH BABY OIL DLC
    Process {
        id: goonerFinder
        running: true
        command: [ "bash", "-c", "swww query | sed -n 's/.*image: //p'" ]

        stdout: StdioCollector {
            onStreamFinished: {
                persistDihBestie.currentWallpaper = Qt.resolvedUrl(this.text.trim())
                if (Settings.goonerLogged == "0") {
                    persistDihBestie.currentWallpaper = Qt.resolvedUrl(this.text.trim())
                    Settings.goonerLogged++;
                }
                goonerFinder.running = false;
                goonerFinder.running = true;
            }
        }
    }

    // P DIDDY THE ITEM SO VE CAN ROLL A ITEM BOX AND GET A MUSHROOM TO GET UP TO 200CC AND GET 8TH SO U GET A STARMAN FROM MARIO KART 64 ⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true

        // THE GOONER SELECTER (LIVES INSIDE A DIH OHM BUT INSIDE A GOOBER) 🥵🥵🥵
            Menu.HamburgerMenu {
                id: colorSchemeMenu
                minWidth: 140
                z: 99999  // GOON ON TOP OF MY DIH 🥵🥵🥵💦💦💦
            }

        // TLGOOBER (P DIDDY DIMENSION'S GOOBER SIDE) 😳😳😳😳😳😳😳
        ColumnLayout {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 16
            spacing: 4

            Row {
            MaterialSymbol {
                text: "palette"
                iconSize: 18
                horizontalAlignment: Text.AlignLeft
            }

            Text {
                text: "  Palete stuf 67"
                font.pixelSize: 18
                font.family: "Roboto"
                color: paletteCacheText.m3onSurface
                horizontalAlignment: Text.AlignRight
                z: 999999999
            }
            }
            Text {
                text: "choose ur vibe 💅✨"
                font.pixelSize: 12
                font.family: "Roboto"
                color: paletteCacheText.m3onSurfaceVariant
                z: 99999999999999999
            }
        }

        // TRGOONERS (UPPER GOONER RIGHT GOOBER)
        RowLayout {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 16
            anchors.rightMargin: 16
            spacing: 16

            // GOONER INSIDE A DIH INSIDE A GOOBER
            Column {
                spacing: 8
                Text {
                    text: "Mode"
                    font.pixelSize: 12
                    color: paletteCacheText.m3onSurfaceVariant
                }
                Actions.SegmentedPill {
                    id: modeControl
                    options: ["light", "dark"]
                    currentIndex: 1
                    onChanged: function(index) {
                        console.log("MODE GOOBER CHANGES IT'S GOONING SATAN MODE TOZ 😳😳😳", options[index])
                        applyWallpaper(options[index], colorComboContainer.selectedColor)
                    }
                }
            }

            // DIDDY'S DIDDLED DIH BY A GOOBER FRICKING TO IT 🥵🥵🥵
            Column {
                spacing: 8
                Text {
                    text: "M3 Color"
                    font.pixelSize: 12
                    color: paletteCacheText.m3onSurfaceVariant
                }
                Rectangle {
                    id: colorComboContainer
                    width: 140
                    height: 40
                    color: paletteCacheText.m3surfaceContainerHigh
                    radius: 6
                    border.color: paletteCacheText.m3outlineVariant
                    border.width: 1

                    property string selectedColor: "tonal-spot"
                    property var colorOptions: ["tonal-spot", "content", "expressive", "fidelity", "fruit-salad", "monochrome", "neutral", "rainbow", "vibrant"]

                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 4
                        Text {
                            id: colorCombo
                            text: colorComboContainer.selectedColor
                            font.pixelSize: 12
                            color: paletteCache.m3onSurface
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 20
                            elide: Text.ElideRight
                            property string displayText: text
                        }
                        Text {
                            text: "▼"
                            font.pixelSize: 10
                            color: paletteCache.m3onSurfaceVariant
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        z: 999
                        onClicked: {
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
                                            var currentMode = modeControl.options[modeControl.currentIndex]
                                            applyWallpaper(currentMode, color)
                                        }
                                    })(colorName)
                                })
                            }
                            colorSchemeMenu.items = menuItems
                            colorSchemeMenu.openAtItem(colorComboContainer)
                        }
                    }
                }
            }
        }

        // DIH OHMMMMMMMMMMMM GOONER GOOBER DIH MILK FRICK P DIDDY 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍
        Rectangle {
            id: goonerDihIFrickedToUrDihPDiddyDiddledMeVithBabyOilAndBackshottedMeThenMyGooberInvited12xMorePDiddiesAndGoobersAndGoonersAndGoonerPlusGoobersFrickedBabyOiledAndGoonedToMe
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 100
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            anchors.bottomMargin: 16
            color: paletteCache.m3surfaceContainer
            radius: 8
            border.color: paletteCache.m3outlineVariant
            border.width: 1
            z: -9

            Label {
                visible: wallpaperCountString === "0"
                text: "Sorry bestie no vallpapers ☹️"
                color: paletteCacheText.m3onSurface
                z: 9999999
                anchors.centerIn: parent
            }

            // REMOVED GOONER DEBUG BESTIE OHMMMMM 💦💦💦

            property var loopedWallpapers: []
            property int modelCount: wallpaperModel ? wallpaperModel.count : 0

            Connections {
                target: wallpaperModel
                function onCountChanged() {
                    goonerDihIFrickedToUrDihPDiddyDiddledMeVithBabyOilAndBackshottedMeThenMyGooberInvited12xMorePDiddiesAndGoobersAndGoonersAndGoonerPlusGoobersFrickedBabyOiledAndGoonedToMe.mixForLoopGoobers()
                }
            }

            function mixForLoopGoobers() {
                if (!wallpaperModel || !wallpaperModel.get || modelCount === 0) {
                    loopedWallpapers = []
                    return
                }
                loopedWallpapers = []
                try {
                    for (var i = 0; i < modelCount; i++) {
                        var goober = wallpaperModel.get(i)
                        if (goober && goober.wallpaperPath) {
                            loopedWallpapers.push({
                                wallpaperPath: goober.wallpaperPath,
                                index: i
                            })
                        }
                    }
                } catch (e) {
                    loopedWallpapers = []
                }
            }

            Component.onCompleted: mixForLoopGoobers()

            onModelCountChanged: {
                if (modelCount > 0) {
                    mixForLoopGoobers()
                }
            }

            // VE PUT THE OLD BABY OIL ON TEMU P DIDDY IS GONNA USE THE NEV ONE TO DIDDLE MY DIH 🔥🔥🔥
            ListView {
                anchors.fill: parent
                anchors.margins: 8
                visible: goonerDihIFrickedToUrDihPDiddyDiddledMeVithBabyOilAndBackshottedMeThenMyGooberInvited12xMorePDiddiesAndGoobersAndGoonersAndGoonerPlusGoobersFrickedBabyOiledAndGoonedToMe.modelCount > 0
                
                orientation: ListView.Horizontal
                spacing: 8
                clip: true
                
                model: wallpaperModel

                Connections {
        target: goonerDihIFrickedToUrDihPDiddyDiddledMeVithBabyOilAndBackshottedMeThenMyGooberInvited12xMorePDiddiesAndGoobersAndGoonersAndGoonerPlusGoobersFrickedBabyOiledAndGoonedToMe
        function onModelCountChanged() {
            // FORCE TO GOON TO MY DIH ON CARTRIDGE TILTING VHILE FRICKING AND CORRUPTING /DEV/MEM
            var tempModel = model
            model = null
            model = tempModel
        }
    }

                delegate: Rectangle {
                    width: 110
                    height: 70
                    radius: 6
                    color: paletteCache.m3surfaceContainerHigh
                    id: dihGoonFrFrSupaVeGii24AhhDihGoon67OhmDihPDiddyDiddledMeOhhMoreFurriesOhhMoreFemboysPlsOhhIVantMoreFemboysOhhOhhIVantMoreGoobersIVantGoonersOhhPDiddyBackshottedMeThenHeDiddledMeVithBabyOilAndMyGoobersCameThenTheyMultipliedTheCount674206169TimesMoreThenTheyAllDiddledBackshottedGoonedFrickedToMeAtTheSameTime

                    property string wallpaperPath: model.wallpaperPath || ""
                    property int index: index
                    property string actualWallpaperPath: wallpaperPath

                    border.color: selected ? paletteCache.m3primary : paletteCache.m3outlineVariant
                    border.width: selected ? 2 : 1

                    property bool selected: {
                        var cleanPersist = persistDihBestie.currentWallpaper.replace("file://", "")
                        return actualWallpaperPath === cleanPersist
                    }

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 2
                        radius: 4
                        clip: true
                        color: paletteCache.m3surfaceContainerLow

                        Image {
                            anchors.fill: parent
                            source: actualWallpaperPath ? "file://" + actualWallpaperPath : ""
                            fillMode: Image.PreserveAspectCrop
                            cache: true
                            asynchronous: true
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            persistDihBestie.currentWallpaper = dihGoonFrFrSupaVeGii24AhhDihGoon67OhmDihPDiddyDiddledMeOhhMoreFurriesOhhMoreFemboysPlsOhhIVantMoreFemboysOhhOhhIVantMoreGoobersIVantGoonersOhhPDiddyBackshottedMeThenHeDiddledMeVithBabyOilAndMyGoobersCameThenTheyMultipliedTheCount674206169TimesMoreThenTheyAllDiddledBackshottedGoonedFrickedToMeAtTheSameTime.actualWallpaperPath
                            var currentMode = modeControl.options[modeControl.currentIndex]
                            var currentColor = colorComboContainer.selectedColor
                            applyWallpaper(currentMode, currentColor)
                        }
                    }

                    // CHECK CIRCLE
                    Rectangle {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 4
                        width: 16
                        height: 16
                        radius: 10
                        color: selected ? paletteCache.m3primary : "transparent"
                        border.color: paletteCache.m3primary
                        border.width: 2
                        visible: selected

                        MaterialSymbol {
                            anchors.centerIn: parent
                            text: "check"
                            iconSize: 10
                            color: paletteCache.m3onPrimary
                        }
                    }
                }
            }
        }
    }
}