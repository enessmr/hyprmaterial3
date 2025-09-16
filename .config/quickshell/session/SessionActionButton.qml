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
    property real size: button.down ? 105 : 120

    buttonRadius: 9999
    colBackground: Pallete.palette().surfaceContainer
    colBackgroundHover: Pallete.palette().surfaceContainer
    property color colText: Pallete.palette().onSurface
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    background.implicitHeight: size
    background.implicitWidth: size

    Behavior on size {
        NumberAnimation { 
            duration: 150 
            easing.type: Easing.OutCubic 
        }
    }

    /* Behavior on buttonRadius {
        animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
    } */

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
        color: Pallete.palette().onSurface
        horizontalAlignment: Text.AlignHCenter
        iconSize: button.down ? 40 : 45
        Behavior on iconSize {
            NumberAnimation { 
                duration: 150 
                easing.type: Easing.OutCubic 
            }
        }
        text: buttonIcon
    }
}