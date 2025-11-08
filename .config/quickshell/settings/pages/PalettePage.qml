import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQml
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import qs.common.widgets
import "../../resources/colors.js" as Palette
import "../../resources/components/navigation" as Nav
import "../../resources/components/actions" as Actions
import "../../resources/components/inputs/chips" as Chips
import "../../resources/components/Menu" as Menu
import qs.common
                    
RowLayout {
    // 💀💀💀 IMPORT THE DINGALING PREFERENCES 💀💀💀
    property var paletteCache
    property var paletteCacheText
    property var persist
    property var wallpaperModel
    property var applyWallpaper
    property var colorSchemeMenu  // 🍔 DONT FORGET THE HAMBURGER MENU 

    Layout.fillWidth: true
    Layout.fillHeight: true

    // USE AN ITEM AS THE CONTAINER SO WE CAN DO ABSOLUTE POSITIONING 🔥🔥🔥
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true

        // HEADER (TOP LEFT)
        ColumnLayout {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 16
            spacing: 4
            
            Text {
                text: "Palete stuf 67"
                font.pixelSize: 18
                font.weight: Font.Bold
                font.family: "Roboto"
                color: paletteCacheText.onSurface
                z: 999999999
            }
        
            Text {
                text: "choose ur vibe 💅✨"
                font.pixelSize: 12
                font.family: "Roboto"
                color: paletteCacheText.onSurfaceVariant
                z: 99999999999999999
            }
        }

        // CONTROLS (TOP RIGHT) 🔥🔥🔥
        RowLayout {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 16
            anchors.rightMargin: 16
            spacing: 16

            // MODE
            Column {
                spacing: 8

                Text {
                    text: "Mode"
                    font.pixelSize: 12
                    color: paletteCacheText.onSurfaceVariant
                }
                
                Actions.SegmentedPill {
                    id: modeControl
                    options: ["light", "dark"]
                    currentIndex: 1 // default to feet smeller 😳
                    
                    onChanged: function(index) {
                        console.log("MODE GOOBER CHANGES IT'S GOONING SATAN MODE TOZ 😳😳😳", options[index])
                        applyWallpaper(options[index], colorComboContainer.selectedColor)
                    }
                }
            }

            // M3 COLOR
            Column {
                spacing: 8
                    
                Text {
                    text: "M3 Color"
                    font.pixelSize: 12
                    color: paletteCacheText.onSurfaceVariant
                }
                    
                Rectangle {
                    id: colorComboContainer
                    width: 140  // dih 😳😳😳
                    height: 40
                    color: paletteCacheText.surfaceContainerHigh
                    radius: 6
                    border.color: paletteCacheText.outlineVariant
                    border.width: 1
                        
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
                            color: paletteCache.onSurface
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
                            color: paletteCache.onSurfaceVariant
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                        
                    // CLICK TO OPEN THE HAMBURGERMENU 🍔🍔🍔
                    MouseArea {
                        anchors.fill: parent
                        z: 999
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

        // WALLPAPER GRID (FILLS REST OF SPACE)
        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 100
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            anchors.bottomMargin: 16
            
            color: paletteCache.surfaceContainer
            radius: 8
            border.color: paletteCache.outlineVariant
            border.width: 1
            z: -9  // 😳 VALLPAPER BG CONTAINER 😳

            Label {
                visible: wallpaperModel.count === 0 // as it should be vith gooning
                text: "Sorry bestie no vallpapers ☹️"
                color: paletteCacheText.onSurface
                z: 9999999
                anchors.centerIn: parent
            }
            
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
                        
                        color: paletteCache.surfaceContainerHigh
                        
                        // Goober's goober inside a gooner inside a gooner to satan inside a main characther syndrome inside a ton 618 inside a feet smeller device😳😳😳😳😳😳
                        required property string wallpaperPath
                        required property int index
                        property string actualWallpaperPath: wallpaperPath || ""
                        // Goober's goober inside a gooner inside a gooner to satan inside a main characther syndrome inside a ton 618 inside a feet smeller device😳😳😳😳😳
                        border.color: selected ? paletteCache.primary : paletteCache.outlineVariant
                        border.width: selected ? 2 : 1
  
                        // Ohh so i cut payleey's dih so it has a goober inside then at the goobers inside theres another goober then theres a feet smeller then theres a ton 618 and then a gooner to satan himself inside 😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳
                        property bool selected: {
                            var cleanPersist = persist.currentWallpaper.replace("file://", "")
                            return actualWallpaperPath === cleanPersist
                        }
                        // flasl  daslkdlasjdlaksdl

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 2
                            radius: 4
                            clip: true
                            color: paletteCache.surfaceContainerLow  // chatgpt be like: (1 message later) "You have hit your limit of your Free GPT-5 usage" 😂😂😂
                            z: 0

                            Image {
                                visible: wallpaperModel.count > 0
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
                                var currentColor = colorComboContainer.selectedColor
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
}
