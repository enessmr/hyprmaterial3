import QtQuick
import QtQuick.Effects
import qs.common

Rectangle {
    required property var target
    anchors.fill: target
    radius: target.radius
    // offset: Qt.vector2d(0.0, 1.0)
    // spread: 1
    color: AppearanceRippleButton.m3colors.background
    border.width: 1
    border.color: AppearanceRippleButton.m3colors.outlineVariant
    // cached: true
}
