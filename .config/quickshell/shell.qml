//@ pragma ShellId shell

//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1

// 💚 ✨ HyprYoshi3 ✨ 🦕

import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Window
import Quickshell
import qs.services
import QtQuick.Layouts
import qs.screenshot as Screenshot
import qs.verticalDijBestie as VertBar
import qs.launcher as Launcher
import qs.session
import qs.osd
import qs.notificationPopup
import qs.Dih
import qs.roundedcorner
import qs.lockend4
import qs.screenCorners
import qs.common
import qs.Dih.sidebars.rightydijbestoe
import qs.common.widgets
import qs.common.functions
import qs.Dih.cetgeptetesceshet
import qs.Dih.ai
import qs.Dih.calc
import qs.Dih.Odaslkskdjkvevnjekjdfeybiaskirasjhdidjncjdbbejstijjdsjiyjtrieos
import qs

ShellRoot {
	property bool enableScreenCorners: true
    property bool enableSession: true
	property bool enableOnScreenDisplayVolume: true
	property bool enableNotificationPopup: true
	property bool enableDihEmoji: true
	property bool enableDihAi: true
	property bool enableReloadPopup: true
	property bool enableCetGptDIJBestieQ: true
	property bool enableUnCalc: true
	property bool enableNonOSK: true

	Component.onCompleted: {
		Launcher.Controller.init()
		RightRoot.init()
		MaterialThemeLoader.reapplyTheme()
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

			VertBar.Bar {
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
	LazyLoader { active: enableSession; component: PauseBufferDijBestie {} }
	LazyLoader { active: enableOnScreenDisplayVolume; component: VolumeOSD {} }
	LazyLoader { active: enableNotificationPopup; component: NotificationPopup {} }
	LazyLoader { active: enableDihEmoji; component: EmojiDijBestie {} }
	LazyLoader { active: enableDihAi; component: Ai {} }
	LazyLoader { active: enableReloadPopup; component: ReloadPopup {} }
	LazyLoader { active: enableCetGptDIJBestieQ; component: CetGptDIJbestieQ {} }
	LazyLoader { active: enableUnCalc; component: Calc {} 
	LazyLoader { active: enableUnOSK; component: Osk {} }}
}