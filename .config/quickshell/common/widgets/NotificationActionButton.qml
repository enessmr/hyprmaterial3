// 💚 ✨ HyprYoshi3 ✨ 🦕

import qs.common
import qs.services
import QtQuick
import Quickshell.Services.Notifications

RippleButton {
    id: button
    property string buttonText
    property string urgency

    implicitHeight: 30
    leftPadding: 15
    rightPadding: 15
    buttonRadius: Appearance.rounding.small
    colBackground: Appearance.m3colors.m3secondaryContainer 
    colBackgroundHover: Appearance.colors.colSecondaryContainerHover
    colRipple: Appearance.colors.colLayer4Active

    contentItem: StyledText {
        horizontalAlignment: Text.AlignHCenter
        text: buttonText
        color: Appearance.m3colors.m3onSurfaceVariant
    }
}