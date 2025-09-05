import QtQuick 2.15
import QtQuick.Controls 2.15
import "../resources/colors.js" as Pallete

Item {
    id: digitalClock

    // Size of the clock
    width: Screen.width      // ✅ lowercase!
    height: Screen.height
    property color primaryColor: Pallete.palette().primary

    // Individual time components
    readonly property string hours: Qt.formatDateTime(new Date(), "hh")
    readonly property string minutes: Qt.formatDateTime(new Date(), "mm")

    // Text for hours (top)
    Text {
        id: hoursText
        text: digitalClock.hours
        font.family: "Product Sans"
        font.weight: Font.Light  // Matches "Product Sans Light"
        font.pixelSize: 200
        color: digitalClock.primaryColor
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - 170  // 90px below center (like your `position = 0, 90`)
        renderType: Text.NativeRendering
    }

    // Text for minutes (bottom)
    Text {
        id: minutesText
        text: digitalClock.minutes
        font.family: "Product Sans"
        font.weight: Font.Light
        font.pixelSize: 200
        color: digitalClock.primaryColor
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - 20 // 90px below center → visually "below"
        renderType: Text.NativeRendering
    }

    // Optional: Add a colon blinking in the middle (cool effect!)
    // Text {
    //     text: ":"
    //     font.family: "Product Sans"
    //     font.weight: Font.Light
    //     font.pixelSize: 150
    //     color: digitalClock.primaryColor
    //     opacity: 0.8
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     anchors.verticalCenter: parent.verticalCenter
    //     Behavior on opacity { PulseAnimation { duration: 1000; from: 0.2; to: 1; running: true } }
    // }

    // Update every second
    Timer {
        interval: 1000  // Update every second
        repeat: true
        running: true
        onTriggered: {
            // Force refresh of bindings
            hoursText.text = Qt.formatDateTime(new Date(), "hh")
            minutesText.text = Qt.formatDateTime(new Date(), "mm")
        }
    }

    // Initialize on start
    Component.onCompleted: {
        hoursText.text = Qt.formatDateTime(new Date(), "hh")
        minutesText.text = Qt.formatDateTime(new Date(), "mm")
    }
}   