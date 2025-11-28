// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Widgets
import qs
import qs.bar
import qs.components
import qs.common

BarWidgetInner {
	id: root
	required property var bar;

	readonly property var chargeState: UPower.displayDevice.state
	readonly property bool isCharging: chargeState == UPowerDeviceState.Charging;
	readonly property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge;
	readonly property real percentage: UPower.displayDevice.percentage
	readonly property bool isLow: percentage <= 0.20

	readonly property UPowerDevice batteryDevice: UPower.devices.values
    	.find(device => device.isLaptopBattery) ?? null

	function statusStr() {
		return root.isPluggedIn ? `Plugged in, ${root.isCharging ? "Charging" : "Not Charging"}`
		                        : "Discharging";
	}

	property bool showMenu: false;

	implicitHeight: width
	color: isLow ? Appearance.m3colors.m3onError : Appearance.m3colors.m3onSecondary

	// color: "transparent"    // no background
    border.width: 0         // no border

	radius: 9999

	BarButton {
		id: button
		anchors.fill: parent
		baseMargin: 5
		fillWindowWidth: true
		acceptedButtons: Qt.LeftButton | Qt.RightButton
		directScale: true
		showPressed: root.showMenu

		onPressed: {
			root.showMenu = !root.showMenu
			Quickshell.execDetached(["bash", "-c", "pw-play ~/.config/hypr/sfx/yoshi-pam.mp3"])
		}

		BatteryIcon {
			device: UPower.displayDevice
		}
	}

	property TooltipItem tooltip: TooltipItem {
		id: tooltip
		tooltip: bar.tooltip
		owner: root
		show: button.containsMouse

		Loader {
			active: tooltip.visible

			sourceComponent: Label {
				color: Appearance.m3colors.m3onSurface
				text: {
					const status = root.statusStr();

					const percentage = Math.round(root.percentage * 100);

					let str = `${percentage}% - ${status}`;
					return str;
				}
			}
		}
	}

	property TooltipItem rightclickMenu: TooltipItem {
		id: rightclickMenu
		tooltip: bar.tooltip
		owner: root

		isMenu: true
		show: root.showMenu
		onClose: root.showMenu = false

		Loader {
			active: rightclickMenu.visible
			sourceComponent: ColumnLayout {
				spacing: 10

				FontMetrics { id: fm }

				component SmallLabel: Label {
					font.pointSize: fm.font.pointSize * 0.8
					color: Appearance.m3colors.m3onSurface
				}
			
				RowLayout {
					Label {
						color: Appearance.m3colors.m3onSurface
						font.family: "Material Symbols Outlined"
						text: "speed"
						font.pixelSize: 32
					}

					ColumnLayout {
						spacing: 0
						Label { 
							color: Appearance.m3colors.m3onSurface
							text: "Power Profile" 
						}

						OptionSlider {
							values: ["Power Save", "Balanced", "Performance"]
							index: PowerProfiles.profile
							onIndexChanged: PowerProfiles.profile = this.index;
							implicitWidth: 350
							color2: Appearance.m3colors.m3onSurface
						}
					}
				}

				RowLayout {
					Label {
						Layout.alignment: Qt.AlignTop
						font.family: "Material Symbols Outlined"
						text: {
        // USE TERNARY OR IF STATEMENTS BESTIE
        if (batteryIcon === 'battery-missing-symbolic') {
            return "battery_unknown"
        }
        return batteryIcon // fallback
    }
						color: Appearance.m3colors.m3onSurface
						font.pixelSize: 32
					}

					ColumnLayout {
						spacing: 0

						RowLayout {
							Label { 
								color: Appearance.m3colors.m3onSurface
								text: "Battery" 
							}
							Item { Layout.fillWidth: true }
							Label {
								text: `${root.statusStr()} -`
								color: Appearance.m3colors.m3onSurface
							}
							Label { 
								color: Appearance.m3colors.m3onSurface
								text: `${Math.round(root.percentage * 100)}%` 
							}
						}

						ProgressBar {
							Layout.topMargin: 5
							Layout.bottomMargin: 5
							Layout.fillWidth: true
							value: UPower.displayDevice.percentage
						}

						RowLayout {
							visible: remainingTimeLbl.text !== ""

							SmallLabel {
								color: Appearance.m3colors.m3onSurface
								text: "Time remaining"
							}
							Item { Layout.fillWidth: true }

				     	SmallLabel {
							color: Appearance.m3colors.m3onSurface
								id: remainingTimeLbl
				     		text: {
				     			const device = UPower.displayDevice;
				     			const time = device.timeToEmpty || device.timeToFull;

									if (time === 0) return "";
									const minutes = Math.floor(time / 60).toString().padStart(2, '0');
									return `${minutes} minutes`
				     		}
				     	}
						}

						RowLayout {
							visible: root.batteryDevice.healthSupported
							SmallLabel {
								color: Appearance.m3colors.m3onSurface
								text: "Health" 
							}
							Item { Layout.fillWidth: true }

				     	SmallLabel {
							color: Appearance.m3colors.m3onSurface
				     		text: `${Math.floor((root.batteryDevice?.healthPercentage ?? 0))}%`
				     	}
						}
					}
				}

				Repeater {
					model: ScriptModel {
						// external devices
						values: UPower.devices.values.filter(device => !device.powerSupply)
					}

			   	RowLayout {
						required property UPowerDevice modelData;

			   		Label {
			   			Layout.alignment: Qt.AlignTop
						font.family: "Material Symbols Outlined"
						color: Appearance.m3colors.m3onSurface
			   			text: {
								switch (modelData.type) {
								case UPowerDeviceType.Headset: return "headphones";
								}
								return Quickshell.iconPath(modelData.iconName)
							}
			   			font.pixelSize: 32
			   		}

			   		ColumnLayout {
			   			spacing: 0

			   			RowLayout {
			   				Label { 
								text: modelData.model 
								color: Appearance.m3colors.m3onSurface
							}
			   				Item { Layout.fillWidth: true }
			   				Label { 
								color: Appearance.m3colors.m3onSurface
								text: `${Math.round(modelData.percentage * 100)}%` 
							}
			   			}

			   			ProgressBar {
			   				Layout.topMargin: 5
			   				Layout.bottomMargin: 5
			   				Layout.fillWidth: true
			   				value: modelData.percentage
			   			}

			   			RowLayout {
			   				visible: modelData.healthSupported
			   				SmallLabel { 
								color: Appearance.m3colors.m3onSurface
								text: "Health" 
							}
			   				Item { Layout.fillWidth: true }

			   	     	SmallLabel {
							color: Appearance.m3colors.m3onSurface
			   	     		text: `${Math.floor(modelData.healthPercentage)}%`
			   	     	}
			   			}
			   		}
			   	}
				}
			}
		}
	}
}
