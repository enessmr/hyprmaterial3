import Quickshell
import Quickshell.Io
import QtQuick
import "./settings" as SettingsA

ShellRoot {

    // DUMMY GOOBER WINDOW TO BOOTSTRAP THE SCENE GRAPH 😍🔥 (invisible af, 1x1 pixel ghost)
    PanelWindow {
        width: 1
        height: 1
        color: "transparent"
        visible: false  // gotta be visible to count as "first window" fr fr
        // WlrLayershell.layer: WlrLayershell.LayerBottom  // tuck it away in the void
    }

    Component.onCompleted: {
        SettingsA.Settings.init()
    }
}