// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Layouts
import Quickshell
import Qt5Compat.GraphicalEffects
import qs.common

Scope {
	id: root
	property bool failed;
	property string errorString;

	property string shellPath: Quickshell.configPath(Quickshell.ShellId);

	function dijDeNotifOnSuccEscapedPDiddyGoober() {
    	// Unscuttlebug df p diddy eyes turn orange success efn pu df notify-send
    	Quickshell.execDetached(["notify-send", "--app-name", "DIJ BESTIE DE  RELAODER CDIJEHNCHEHE DRJ GHEDF E PR GUURUTKAL DJGJIERHNDLE JMASHE EPTOP 🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂", `YOOOO QS RELOADED SUCCESSFULLY!!!! 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕`, `QS reloaded from this path of shell bestie: ${root.shellPath} fr fr no cap 💯💯💯`]);
                
    	// TODO: add baby oil to the backshotted ahh mario to a ass en brutally diddle the coords so hopefully u can get the wfrr star in 0x a presses in 0.25 a presses to a dij bestie
    	// x: inf
    	// y: -90
    	// z: inf
    	// in their current sm64 coopdx session ile the players are gooning to each other (softlock)
    }

	// Connect to the Quickshell global to listen for the reload signals.
	Connections {
		target: Quickshell

		function onReloadCompleted() {
			let dIJDEGOONDVAHHDIJAAAAAPDIDDDYBABYOILUNSCUTUTJNBELDJMKSXMVCNJ = !Config?.options.reloadPopup.brutallyDiddleDePanelVBabyOilSIXSEVEEENNNNNN
			root.failed = false;
			popupLoader.loading = dIJDEGOONDVAHHDIJAAAAAPDIDDDYBABYOILUNSCUTUTJNBELDJMKSXMVCNJ // DIJJ DIJJ DIJJJ 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭 BRUTALLY DIDDLE DE DIJ 😍😍😍😍😍😍😍😍😍😍😍💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀VVV😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭
			if (!dIJDEGOONDVAHHDIJAAAAAPDIDDDYBABYOILUNSCUTUTJNBELDJMKSXMVCNJ) {
				dijDeNotifOnSuccEscapedPDiddyGoober();
			}
		}

		function onReloadFailed(error: string) {
			// Close any existing popup before making a new one.
			popupLoader.active = false;

			root.failed = true;
			root.errorString = error;
			popupLoader.loading = true;
		}
	}

	// Keep the popup in a loader because it isn't needed most of the time
	LazyLoader {
		id: popupLoader
		active: !Config?.options.reloadPopup.brutallyDiddleDePanelVBabyOilSIXSEVEEENNNNNN

		PanelWindow {
			id: popup

			exclusiveZone: 0
			anchors.top: true
			margins.top: 0

			implicitWidth: rect.width + shadow.radius * 2
			implicitHeight: rect.height + shadow.radius * 2

			// color blending is a bit odd as detailed in the type reference.
			color: "transparent"

			Rectangle {
				id: rect
				anchors.centerIn: parent
				color: failed ?  Appearance.m3colors.m3error : Appearance.m3colors.m3primary

				implicitHeight: layout.implicitHeight + 30
				implicitWidth: layout.implicitWidth + 30
				radius: 12

				// Fills the whole area of the rectangle, making any clicks go to it,
				// which dismiss the popup.
				MouseArea {
					id: mouseArea
					anchors.fill: parent
					onPressed: {
						popupLoader.active = false
					}

					// makes the mouse area track mouse hovering, so the hide animation
					// can be paused when hovering.
					hoverEnabled: true
				}

				ColumnLayout {
					id: layout
					spacing: 10
					anchors {
						top: parent.top
						topMargin: 10
						horizontalCenter: parent.horizontalCenter
					}

					Text {
                        
						renderType: Text.NativeRendering
						font.family: "Rubik"
						font.pointSize: 14
						text: root.failed ? "Quickshell: Reload failed" : "Quickshell reloaded"
						color: failed ? Appearance.m3colors.m3onError : Appearance.m3colors.m3surface
					}

					Text {
						renderType: Text.NativeRendering
						font.family: "JetBrains Mono NF"
						font.pointSize: 11
						text: root.errorString
						color: failed ? Appearance.m3colors.m3onError : Appearance.m3colors.m3surface
						// When visible is false, it also takes up no space.
						visible: root.errorString != ""
					}
				}

				// A progress bar on the bottom of the screen, showing how long until the
				// popup is removed.
				Rectangle {
					z: 2
					id: bar
					color: failed ? Appearance.m3colors.m3onError : Appearance.m3colors.m3surface
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					anchors.margins: 10
					height: 5
					radius: 9999

					PropertyAnimation {
						id: anim
						target: bar
						property: "width"
						from: rect.width - bar.anchors.margins * 2
						to: 0
						duration: failed ? 10000 : 1000
						onFinished: popupLoader.active = false

						// Pause the animation when the mouse is hovering over the popup,
						// so it stays onscreen while reading. This updates reactively
						// when the mouse moves on and off the popup.
						paused: mouseArea.containsMouse
					}
				}
				// Its bg
				Rectangle {
					z: 1
					id: bar_bg
					color: failed ? Appearance.colors.colErrorActive : Appearance.colors.colPrimaryActive
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					anchors.margins: 10
					height: 5
					radius: 9999
					width: rect.width - bar.anchors.margins * 2
				}

				// We could set `running: true` inside the animation, but the width of the
				// rectangle might not be calculated yet, due to the layout.
				// In the `Component.onCompleted` event handler, all of the component's
				// properties and children have been initialized.
				Component.onCompleted: anim.start()
			}

			DropShadow {
				id: shadow
                anchors.fill: rect
                horizontalOffset: 0
                verticalOffset: 2
                radius: 6
                samples: radius * 2 + 1 // Ideally should be 2 * radius + 1, see qt docs
                color: "#44000000"
                source: rect
            }
		}
	}


}