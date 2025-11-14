// 💚 ✨ HyprYoshi3 ✨ 🦕

//@ pragma ShellId lock

//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1

import QtQuick
import Quickshell
import qs.lockend4
import qs.services

ShellRoot {
    // no firstvindov means no gooner display and fuck it :/
    PanelWindow {
        implicitWidth: 0
        implicitHeight: 0
        visible: false
    }

    property bool enableLock: true

    LazyLoader { active: enableLock; component: Lock {} }

    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme()
    }
}