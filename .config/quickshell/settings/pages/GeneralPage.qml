// 💚 ✨ HyprYoshi3 ✨ 🦕

import qs.common
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

Column {
                            spacing: 16

                            Row {
                            MaterialSymbol {
                                text: "browse"
                                iconSize: 18
                            }
                            
                            Text {
                                text: "  General stuf 67"
                                font.pixelSize: 18
                                color: Appearance.m3colors.m3onSurface
                            }
                            }
                            
                            Text {
                                text: "the basic stuff fr 💯"
                                font.pixelSize: 12
                                color: Appearance.m3colors.m3onSurface
                            }
                            
                            Rectangle {
                                implicitWidth: parent.width
                                implicitHeight: 100
                                color: Appearance.m3colors.m3secondaryContainer
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "General options here\n(toggles n stuff)"
                                    color: Appearance.m3colors.m3onSecondaryContainer
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }