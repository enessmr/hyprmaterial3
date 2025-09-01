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

Singleton {
    PersistentProperties {
        id: persist
        property bool settingsOpen: false
        property int currentPage: 0  // WHICH PAGE WE ON BESTIE
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
            width: 1000
            height: 600
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
                implicitHeight: 37.5
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
                    Nav.NavigationRailItem {
                        text: "Pallete"
                        selected: persist.currentPage === 0
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
                                text: "🎨 Palette Settings"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                                color: Palette.palette().onSurface
                            }
                            
                            Text {
                                text: "customize your colors bestie 💅✨"
                                font.pixelSize: 12
                                color: Palette.palette().onSurfaceVariant
                            }
                            
                            Rectangle {
                                width: parent.width
                                height: 100
                                color: Palette.palette().primaryContainer
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "Color picker goes here\n(palette icon was fire choice ngl)"
                                    color: Palette.palette().onPrimaryContainer
                                    horizontalAlignment: Text.AlignHCenter
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
                                width: parent.width
                                height: 100
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
                                width: parent.width
                                height: 100
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