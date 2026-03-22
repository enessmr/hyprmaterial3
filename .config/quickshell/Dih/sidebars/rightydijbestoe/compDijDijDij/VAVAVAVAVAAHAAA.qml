// 💚 ✨ HyprYoshi3 ✨ 🦕

//  BASIC  DIJ ON  THE BESTIE

import qs.common
import QtQuick 2.15
import Quickshell
import Quickshell.Io
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.common.widgets
import qs.roundedcorner

Rectangle {

    implicitWidth:  parent.width - 100
    anchors.right: parent.right 
    anchors.rightMargin: 10
    implicitHeight: Screen.height - 35
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 20
    radius: Appearance.rounding.normal
    color: Appearance.m3colors.m3surfaceContainerHigh

    Column {
        anchors.left: parent.left
        anchors.leftMargin: 11        
        Text {
            text: "dij hehe"
        }
    }
}
