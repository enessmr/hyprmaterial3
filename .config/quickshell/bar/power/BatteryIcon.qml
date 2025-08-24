import QtQuick
import Quickshell.Services.UPower
import qs
import "../../resources/colors.js" as Pallete

Item {
	id: root
	required property UPowerDevice device;
	property real scale: 1;

	readonly property bool isCharging: root.device.state == UPowerDeviceState.Charging;
	readonly property bool isPluggedIn: isCharging || root.device.state == UPowerDeviceState.PendingCharge;
	readonly property bool isLow: root.device.percentage <= 0.20;

	width: 35 * root.scale
	height: 35 * root.scale

	Rectangle {
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: parent.bottom
			bottomMargin: 4 * root.scale
		}

		width: 13 * root.scale
		height: 23 * root.device.percentage * root.scale
		radius: 2 * root.scale

		color: root.isPluggedIn ? "#359040"
		     : ShellGlobals.interpolateColors(Math.min(1.0, Math.min(0.5, root.device.percentage) * 2), "red", "white")
	}

	Text {
    	id: batteryIcon
    	anchors.fill: parent
    	horizontalAlignment: Text.AlignHCenter
    	verticalAlignment: Text.AlignVCenter

    	// Font setup
    	font.family: "Material Symbols Outlined"
    	font.pixelSize: Math.min(parent.width, parent.height)

    	// Dynamically select the icon by name
    	text: root.isCharging ? "battery_charging_full"
         	: root.isPluggedIn ? "battery_plus"
         	: root.isLow ? "battery_alert"
         	: "battery_alert"

		color: Pallete.palette().onSurface

    	visible: true
	}

}
