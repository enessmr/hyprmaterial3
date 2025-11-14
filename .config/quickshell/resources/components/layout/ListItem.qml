// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import "../../colors.js" as Palette
import qs.common

Item {
    id: root
    property string text: "Item"
    property bool enabled: true
    implicitHeight: 32
    implicitWidth: 160

    Rectangle {
        id: hoverBg
        anchors.fill: parent
        radius: 6
        color: Appearance.m3colors.m3onSurface
        opacity: mouse.containsMouse ? 0.06 : 0.0
        Behavior on opacity { NumberAnimation { duration: 100; easing.type: Easing.InOutQuad } }
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        color: Appearance.m3colors.m3onSurface
        text: root.text
        font.pixelSize: 14
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        enabled: root.enabled
    }
}


