// 💚 ✨ HyprYoshi3 ✨ 🦕

pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Layouts
import Quickshell
import qs.bar.systray as SysTray
import qs.bar.audio as Audio
import qs.bar.mpris as Mpris
import qs.bar.connections as Connections
import qs.bar.power as Power

BarContainment {
    id: root
    property bool isSoleBar: Quickshell.screens.length == 1;
    
    RowLayout {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        
        RowLayout {
            Layout.fillHeight: true
            
            /* Notifs.NotificationWidget {
                Layout.fillHeight: true
                bar: root
            } */
            
            RowLayout {
                spacing: 0
                
                Loader {
                    active: root.isSoleBar
                    Layout.preferredWidth: active ? implicitWidth : 0;
                    Layout.fillHeight: true
                    sourceComponent: Workspaces {
                        bar: root
                        wsBaseIndex: 1
                    }
                }
            }
        }
    }
    
    RowLayout {
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        
        Mpris.Players {
            bar: root
            Layout.fillHeight: true
        }
        
        Audio.AudioControls {
            bar: root
            Layout.fillHeight: true
        }
        
        SysTray.SysTray {
            bar: root
            Layout.fillHeight: true
        }
        
        Connections.Connections {
            bar: root
            Layout.fillHeight: true
        }
        
        Power.Power {
            bar: root
            Layout.fillHeight: true
        }
        
        ClockWidget {
            bar: root
            Layout.fillHeight: true
        }
    }
}