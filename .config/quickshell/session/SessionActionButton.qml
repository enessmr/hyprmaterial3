import qs.common
import qs.common.widgets
import QtQuick
import QtQuick.Layouts
import "../resources/colors.js" as Pallete

RippleButton {
    id: button

    property string buttonIcon
    property string buttonText
    property bool keyboardDown: false
    property real size: 120

    buttonRadius: (button.focus || button.down) ? size / 2 : Appearance.rounding.verylarge
    colBackground: button.keyboardDown ? Pallete.palette().primaryContainer : 
        button.focus ? Pallete.palette().primary : 
        Pallete.palette().secondaryContainer
    colBackgroundHover: Pallete.palette().primary
    colRipple: Pallete.palette().onPrimary
    // property color colText: (button.down || button.keyboardDown || button.focus || button.hovered) ?
    //    Pallete.palette().onPrimary : Pallete.palette().onSecondaryContainer

    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    background.implicitHeight: size
    background.implicitWidth: size

    Behavior on buttonRadius {
        animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
    }

    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            keyboardDown = true
            button.clicked()
            event.accepted = true;
        }
    }
    Keys.onReleased: (event) => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            keyboardDown = false
            event.accepted = true;
        }
    }

    contentItem: MaterialSymbol {
        id: icon
        anchors.fill: parent
        color: (button.focus || button.hovered) ? Pallete.palette().surface : Pallete.palette().onSecondaryContainer
        horizontalAlignment: Text.AlignHCenter
        iconSize: 45
        text: buttonIcon
    }

    StyledToolTip {
        content: buttonText
    }

}