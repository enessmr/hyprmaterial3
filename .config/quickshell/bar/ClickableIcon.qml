// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Controls
import qs.common

BarButton {
    id: root
	property string icon
    property string image
    property alias cache: imageComponent.cache
    property alias asynchronous: imageComponent.asynchronous
    property bool scaleIcon: !asynchronous
    
    // New properties for text icon
    property bool useTextIcon: true
    property string textIcon: icon  // Can be overridden if icon name differs from image path

    // Text-based icon (Material Symbols)
    Text {
        id: textComponent
        // visible: useTextIcon
        anchors.fill: parent
        text: root.textIcon
		color: Appearance.m3colors.m3onSurface
        font.family: "Material Symbols Outlined"
        font.pixelSize: Math.min(parent.width, parent.height) - baseMargin
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        visible: useTextIcon && font.family === "Material Symbols Outlined"
        
        // Optional: Add color binding
        // color: root.pressed ? pressedColor : (root.hovered ? hoveredColor : normalColor)
    }

    // Fallback image icon
    Image {
        id: imageComponent
        // visible: !textComponent.visible
        anchors.fill: parent
        source: root.image
        sourceSize.width: scaleIcon ? width : (root.width - baseMargin)
        sourceSize.height: scaleIcon ? height : (root.height - baseMargin)
        cache: false
    }
}