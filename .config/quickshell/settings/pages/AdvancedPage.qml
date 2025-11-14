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

Column {
                            spacing: 16
                            
                            Row {
                            MaterialSymbol {
                                text: "settings_alert"
                                iconSize: 18
                            }

                            Text {
                                text: "  Advanced stuf 67"
                                font.pixelSize: 18
                                color: Appearance.m3colors.m3onSurface
                            }
                            }
                            
                            Text {
                                text: "for the brave souls only 💀"
                                font.pixelSize: 12
                                color: Appearance.m3colors.m3onSurfaceVariant
                            }
                            
                            Rectangle {
                                implicitWidth: parent.width
                                implicitHeight: 100
                                color: Appearance.m3colors.m3tertiaryContainer
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "Advanced options here\n(don't touch unless u know what ur doing)"
                                    color: Appearance.m3colors.m3onTertiaryContainer
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }