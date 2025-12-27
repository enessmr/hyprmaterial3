// 💚 ✨ HyprYoshi3 ✨ 🦕

import qs.common
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs
import "./roundedcorner"
import qs.services
import qs.common.widgets
import qs.common.functions

PanelWindow {
    id: root
    default property alias barItems: containment.data
    
    anchors {
        top: true
        left: true
        right: true
    }
    
    property real baseHeight: 55
    property real topMargin: root.compactState * 10
    implicitHeight: baseHeight + 15
    exclusiveZone: baseHeight + (isFullscreenWorkspace ? 0 : 15) - margins.top
    
    mask: Region {
        width: root.width
        height: root.exclusiveZone
    }
    
    color: "transparent"
    WlrLayershell.namespace: "shell:bar"
    
    readonly property Tooltip tooltip: tooltip
    Tooltip {
        id: tooltip
        bar: root
    }
    
    readonly property real tooltipYOffset: root.baseHeight + root.topMargin + 5
    
    function boundedX(targetX: real, width: real): real {
        return Math.max(barRect.anchors.leftMargin + width, Math.min(barRect.width + barRect.anchors.leftMargin - width, targetX))
    }
    
    readonly property bool isFullscreenWorkspace:
        screen && Hyprland.monitorFor(screen) && Hyprland.monitorFor(screen).activeWorkspace
            ? Hyprland.monitorFor(screen).activeWorkspace.hasFullscreen
            : false
    
    property real compactState: isFullscreenWorkspace ? 0 : 1
    Behavior on compactState {
        NumberAnimation {
            duration: 600
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [0.0, 0.75, 0.15, 1.0, 1.0, 1.0]
        }
    }
    
    property int large: 23
    
    // Rounded corners as siblings of barRect
    RoundCorner {
        id: topLeftCorner
        corner: RoundCorner.CornerEnum.TopLeft
        implicitSize: 15
        implicitHeight: baseHeight + 15 - topMargin
        color: Appearance.m3colors.m3background
        anchors.top: barRect.bottom
        anchors.left: barRect.left
        z: 10
    }
    
    RoundCorner {
        id: topRightCorner
        corner: RoundCorner.CornerEnum.TopRight
        implicitSize: 15
        color: Appearance.m3colors.m3background
        anchors.top: barRect.bottom
        anchors.right: barRect.right
        z: 10
    }
    
    Rectangle {
        id: barRect
        clip: false
        y: 0
        implicitHeight: parent.height - 15
        
        anchors {
            left: parent.left
            right: parent.right
        }
        
        color: Appearance.m3colors.m3background
        border.color: ShellGlobals.colors.barOutline
        border.width: 0
        
        Item {
            id: containment
            anchors.fill: parent
            anchors.margins: 5
        }
    }
}