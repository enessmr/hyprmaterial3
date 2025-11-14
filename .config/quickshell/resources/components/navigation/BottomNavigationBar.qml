// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import "../../colors.js" as Palette
import qs.common

Rectangle {
    id: root
    property int selectedIndex: -1
    default property alias content: container.data
    // expose safe area inset for when used inside Container
    property int topInset: 0

    color: Appearance.m3colors.m3surface
    height: 64
    width: parent ? parent.width : implicitWidth
    border.width: 0

    // top divider
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 1
        color: Appearance.m3colors.m3outline
        opacity: 0.24
    }

    Row {
        id: container
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.margins: 8
        anchors.topMargin: 8 + topInset
        spacing: 8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}


