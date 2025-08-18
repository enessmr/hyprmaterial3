import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs
import qs.lock as Lock
import "../resources/colors.js" as Pallete
import "./roundedcorner"

PanelWindow {
    id: root

    default property alias barItems: containment.data

    anchors {
        left: true
        top: true
        bottom: true
    }

    property real baseWidth: 55
    property real leftMargin: root.compactState * 10
    implicitWidth: baseWidth + 15
    exclusiveZone: baseWidth + (isFullscreenWorkspace ? 0 : 15) - margins.left

    mask: Region {
        height: root.height
        width: root.exclusiveZone
    }

    color: "transparent"

    WlrLayershell.namespace: "shell:bar"

    readonly property Tooltip tooltip: tooltip
    Tooltip {
        id: tooltip
        bar: root
    }

    readonly property real tooltipXOffset: root.baseWidth + root.leftMargin + 5

    function boundedY(targetY: real, height: real): real {
        return Math.max(barRect.anchors.topMargin + height, Math.min(barRect.height + barRect.anchors.topMargin - height, targetY))
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

	    // Rounded corners as siblings of barRect
    RoundCorner {
        id: topLeftCorner
        corner: RoundCorner.CornerEnum.TopLeft
        implicitSize: 15
        color: Pallete.palette().background
        anchors.left: barRect.right
        anchors.top: barRect.top
        z: 10
    }

    RoundCorner {
        id: bottomLeftCorner
        corner: RoundCorner.CornerEnum.BottomLeft
        implicitSize: 15
        color: Pallete.palette().background
        anchors.left: barRect.right
        anchors.bottom: barRect.bottom
		z: 10
    }

    Rectangle {
        id: barRect
		clip: false

        x: 0
        implicitWidth: parent.width - 15

        anchors {
            top: parent.top
            bottom: parent.bottom
        }

        color: Pallete.palette().background
        border.color: ShellGlobals.colors.barOutline
        border.width: 0

        Item {
            id: containment
            anchors.fill: parent
            anchors.margins: 5
        }
    }
}
