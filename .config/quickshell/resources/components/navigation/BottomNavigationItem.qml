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

    width: 96
    height: 56

    Column {
        anchors.centerIn: parent
        spacing: 2

        Rectangle {
            id: indicator
            width: 24; height: 24; radius: 12
            color: selected ? Appearance.m3colors.m3secondaryContainer : "transparent"
            border.width: selected ? 0 : 1
            border.color: Appearance.m3colors.m3outline
            Behavior on color { ColorAnimation { duration: 150; easing.type: Easing.InOutQuad } }
        }

        Text {
            id: label
            color: selected ? Appearance.m3colors.m3onSecondaryContainer : Appearance.m3colors.m3onSurface
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        onClicked: root.clicked()
    }
}


