// 💚 ✨ HyprYoshi3 ✨ 🦕

//@ pragma ShellId settings

//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1

import Quickshell
import Quickshell.Io
import QtQuick
import qs.services
import "./settings" as SettingsDingalingAAAAAAAAAAAAAAANotTuff76SuperLuigi46DihGoonFrNoCap

ShellRoot {
    PanelWindow {
        implicitWidth: 0
        implicitHeight: 0
        visible: false
    }
    
    // DIH DEIGHHSADNJABSDKsabh J👲👲👲
    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme()
        SettingsDingalingAAAAAAAAAAAAAAANotTuff76SuperLuigi46DihGoonFrNoCap.Settings.init()
    }
}