// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs
import qs.services
import qs.lockend4
import qs.common
import qs.common.widgets
import qs.common.functions

MouseArea {
    id: root
    required property LockContext context
    property bool active: false
    property bool showInputField: active || context.currentText.length > 0

    LockThingy {
        anchors.fill: parent
        z: 1 // make sure it's ABOVE everything but below the toolbar
    }

    function forceFieldFocus() {
        passwordBox.forceActiveFocus();
    }

    Component.onCompleted: {
        forceFieldFocus();
    }

    Connections {
        target: context
        function onShouldReFocus() {
            forceFieldFocus();
        }
    }

    Keys.onPressed: event => { // Esc to clear
        if (event.key === Qt.Key_Escape) {
            root.context.currentText = "";
        }
        forceFieldFocus();
    }

    hoverEnabled: true
    acceptedButtons: Qt.LeftButton
    onPressed: mouse => {
        forceFieldFocus();
    }
    onPositionChanged: mouse => {
        forceFieldFocus();
    }

    anchors.fill: parent

    // Controls
    Toolbar {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 20
        }
        Behavior on anchors.bottomMargin {
            animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
        }

        scale: 0.9
        opacity: 0
        Component.onCompleted: {
            scale = 1
            opacity = 1
        }
        Behavior on scale {
            NumberAnimation {
                duration: Appearance.animation.elementMove.duration
                easing.type: Appearance.animation.elementMove.type
                easing.bezierCurve: Appearance.animationCurves.expressiveFastSpatial
            }
        }
        Behavior on opacity {
            animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
        }

        ToolbarButton {
            id: sleepButton
            implicitWidth: height

            onClicked: Session.suspend()

            contentItem: MaterialSymbol {
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                iconSize: 24
                text: "dark_mode"
                color: Appearance?.m3colors?.m3onPrimaryContainer
            }
        }

        ToolbarTextField {
            id: passwordBox
            placeholderText: GlobalStates.screenUnlockFailed ? "Incorrect password" : "Enter password"

            // Style
            clip: true
            font.pixelSize: Appearance.font.pixelSize.small

            // Password
            enabled: !root.context.unlockInProgress
            echoMode: TextInput.Password
            inputMethodHints: Qt.ImhSensitiveData

            // Synchronizing (across monitors) and unlocking
            onTextChanged: root.context.currentText = this.text
            onAccepted: root.context.tryUnlock()
            Connections {
                target: root.context
                function onCurrentTextChanged() {
                    passwordBox.text = root.context.currentText;
                }
            }
        }

        ToolbarButton {
            id: confirmButton
            implicitWidth: height
            toggled: true
            enabled: !root.context.unlockInProgress
            colBackgroundToggled: Appearance?.m3colors?.m3primary

            onClicked: root.context.tryUnlock()

            contentItem: MaterialSymbol {
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                iconSize: 24
                text: "arrow_right_alt"
                color: confirmButton.enabled ? Appearance?.m3colors?.m3onPrimary : Appearance?.m3colors?.m3outline
            }
        }
    }
}