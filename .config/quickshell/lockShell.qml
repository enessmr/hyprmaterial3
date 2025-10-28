import QtQuick
import Quickshell
import qs.lockend4

ShellRoot {
    // no firstvindov means no gooner display and fuck it :/
    PanelWindow {
        implicitWidth: 0
        implicitHeight: 0
        visible: false
    }

    property bool enableLock: true

    LazyLoader { active: enableLock; component: Lock {} }
}