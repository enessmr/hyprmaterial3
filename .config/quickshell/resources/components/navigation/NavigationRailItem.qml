// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import "../../colors.js" as Palette
import qs.common

Item {
    id: root
    property alias text: label.text
    property bool selected: false
    property bool enabled: true
    signal clicked()

    // Size based on content
    property int paddingH: 16
    property int paddingV: 10
    width: Math.max(48, label.implicitWidth + paddingH * 2)
    height: Math.max(40, label.implicitHeight + paddingV * 2)

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 12
        color: selected ? Appearance.m3colors.m3secondaryContainer : "transparent"
        border.width: selected ? 0 : 1
        border.color: Appearance.m3colors.m3outline
        opacity: enabled ? 1.0 : 0.38
        Behavior on color { ColorAnimation { duration: 150; easing.type: Easing.InOutQuad } }
        Behavior on opacity { NumberAnimation { duration: 120; easing.type: Easing.InOutQuad } }
    }

    Text {
        id: label
        anchors.left: parent.left
        anchors.leftMargin: paddingH
        anchors.verticalCenter: parent.verticalCenter
        color: selected ? Appearance.m3colors.m3onSecondaryContainer : Appearance.m3colors.m3onSurface
        font.pixelSize: 13
        elide: Text.ElideRight
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        onClicked: root.clicked()
        onEntered: if (enabled && !selected) bg.opacity = 0.92
        onExited: if (enabled && !selected) bg.opacity = 1.0
        onPressedChanged: if (enabled && !selected) bg.opacity = pressed ? 0.85 : 1.0
    }
}


