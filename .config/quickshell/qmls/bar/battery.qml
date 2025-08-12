import QtQuick 2.15
import Quickshell 0.2

Item {
    id: batteryWidget
    width: 100
    height: 30

    property string percent: "100"
    property string status: "Full"

    Timer {
        interval: 5000 // update every 5s
        running: true
        repeat: true
        onTriggered: {
            percent = Process.readFile("/sys/class/power_supply/BAT0/capacity").trim()
            status  = Process.readFile("/sys/class/power_supply/BAT0/status").trim()
        }
    }

    Text {
        anchors.centerIn: parent
        text: percent + "% (" + status + ")"
        color: "white"
    }

    Component.onCompleted: {
        percent = Process.readFile("/sys/class/power_supply/BAT0/capacity").trim()
        status  = Process.readFile("/sys/class/power_supply/BAT0/status").trim()
    }
}
