//@ pragma ShellId shell

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.screenshot as Screenshot
import qs.bar as Bar
import qs.launcher as Launcher
import qs.session
import qs.osd
import qs.notificationPopup
import qs.Dih
import qs.bar.roundedcorner
import qs.lockend4
import qs.screenCorners
import qs.services
import qs.common
import qs.common.widgets
import qs.common.functions
import qs.Dih.ai

ShellRoot {
	property bool enableScreenCorners: true
    property bool enableSession: true
	property bool enableOnScreenDisplayVolume: true
	property bool enableNotificationPopup: true
	property bool enableDihEmoji: true
	property bool enableDihAi: true

	Component.onCompleted: {
		Launcher.Controller.init()
		// Settings.Settings.init()
		// MaterialThemeLoader.reapplyTheme()
        // Hyprsunset.load()
        // FirstRunExperience.load()
        // ConflictKiller.load()
        // Cliphist.refresh()
	}

	Process {
		command: ["mkdir", "-p", ShellGlobals.rtpath]
		running: true
	}

	LazyLoader {
		id: screenshot
		loading: true

		Screenshot.Controller {
		}
	}	

	Connections {
		target: ShellIpc

		function onScreenshot() {
			screenshot.item.shooting = true;
		}
	}

	/* Notifs.NotificationOverlay {
    	screen: Quickshell.screens.find(s => s.name == "DP-1") || null
    	Component.onCompleted: {
       		if (!screen) {
            	screen = Quickshell.screens.find(s => s.name == "DP-1")
        	}
    	}
	} */

	Variants {
		model: Quickshell.screens

		Scope {
			property var modelData

			Bar.Bar {
				// screen: modelData
			}

			/* PanelWindow {
				id: window

				screen: modelData

				exclusionMode: ExclusionMode.Ignore
				WlrLayershell.layer: WlrLayer.Background
				WlrLayershell.namespace: "shell:background"

				anchors {
					top: true
					bottom: true
					left: true
					right: true
				}

				BackgroundImage {
					anchors.fill: parent
					screen: window.screen
				}
			} */
		}
	}

	LazyLoader { active: enableScreenCorners; component: ScreenCorners {} }
	LazyLoader { active: enableSession; component: Session {} }
	LazyLoader { active: enableOnScreenDisplayVolume; component: VolumeOSD {} }
	LazyLoader { active: enableNotificationPopup; component: NotificationPopup {} }
	LazyLoader { active: enableDihEmoji; component: Emoji {} }
	LazyLoader { active: enableDihAi; component: Ai {} }
}