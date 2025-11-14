// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import "../../colors.js" as Palette
import qs.common

Rectangle {
    id: root

    // Material-like surface with outline
    property real cornerRadius: 14
    property real outlineWidth: 1
    property color surfaceColor: Appearance.m3colors.m3surface
    property color outlineColor: Appearance.m3colors.m3outline
    property real padding: 12

    color: surfaceColor
    radius: cornerRadius
    border.color: outlineColor
    border.width: outlineWidth

    default property alias content: contentItem.data

    implicitWidth: Math.max(contentItem.implicitWidth + padding * 2, 64)
    implicitHeight: Math.max(contentItem.implicitHeight + padding * 2, 32)

    Item {
        id: contentItem
        anchors.fill: parent
        anchors.margins: padding
    }
}


