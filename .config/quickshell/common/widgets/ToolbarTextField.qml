// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.common
import qs.common.widgets

TextField {
    id: filterField

    property alias colBackground: background.color

    Layout.fillHeight: true
    implicitWidth: 200
    padding: 10

    placeholderTextColor: Appearance.colors.colSubtext
    color: Appearance.colors.colOnLayer1
    font.pixelSize: Appearance.font.pixelSize.small
    renderType: Text.NativeRendering
    selectedTextColor: Appearance.colors.colOnSecondaryContainer
    selectionColor: Appearance.colors.colSecondaryContainer

    background: Rectangle {
        id: background
        color: Appearance.m3colors.m3surfaceContainer
        radius: Appearance.rounding.full
    }
}