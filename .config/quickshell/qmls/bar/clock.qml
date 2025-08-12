import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 100
    height: 40

    Timer {
        id: clockTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clock.text = Qt.formatDateTime(new Date(), "hh:mm:ss")
        }
    }

    Text {
        id: clock
        anchors.centerIn: parent
        font.pixelSize: 18
        text: Qt.formatDateTime(new Date(), "hh:mm:ss")
        color: "white"
    }
}
