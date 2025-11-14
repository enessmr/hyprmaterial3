// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import QtQuick.Controls 2.15
import qs.common

Item {
    id: digitalClock

    // Size of the gooner's dih 😍
    width: Screen.width      // smol gooner 🥺
    height: Screen.height
    property color primaryColor: Appearance.m3colors.m3primary

    // ohh the gooner's dih is ticking
    readonly property string hours: Qt.formatDateTime(new Date(), "hh")
    readonly property string minutes: Qt.formatDateTime(new Date(), "mm")

    // smol goober inside my dih
    Text {
        id: hoursText
        text: digitalClock.hours
        font.family: "Product Sans"
        font.weight: Font.Light
        font.pixelSize: 200
        color: digitalClock.primaryColor
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - 170 
        renderType: Text.NativeRendering
    }

    // smol goober 2 inside my dih
    Text {
        id: minutesText
        text: digitalClock.minutes
        font.family: "Product Sans"
        font.weight: Font.Light
        font.pixelSize: 200
        color: digitalClock.primaryColor
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - 20
        renderType: Text.NativeRendering
    }

    // update the dih every gooner gooning to my dih
    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            // restart the smol dingaling
            hoursText.text = Qt.formatDateTime(new Date(), "hh")
            minutesText.text = Qt.formatDateTime(new Date(), "mm")
        }
    }

    // dih 😍
    Component.onCompleted: {
        hoursText.text = Qt.formatDateTime(new Date(), "hh")
        minutesText.text = Qt.formatDateTime(new Date(), "mm")
    }
}   