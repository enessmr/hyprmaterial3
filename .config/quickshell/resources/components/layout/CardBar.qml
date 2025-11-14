// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import "../../colors.js" as Palette
import qs.common

Rectangle {
    id: root

    property real padding: 16
    property real cornerRadius: 12
    property color backgroundColor: Appearance.m3colors.m3surface
    property color outlineColor: Appearance.m3colors.m3outline

    color: backgroundColor
    radius: cornerRadius
    border.width: 1
    border.color: outlineColor

    //implicitWidth: Math.max(contentItem.implicitWidth + padding * 2, 160)
    //implicitHeight: Math.max(contentItem.implicitHeight + padding * 2, 100)

    default property alias content: contentItem.data

    Item {
        id: contentItem
        anchors.fill: parent
        anchors.margins: padding
    }
}


