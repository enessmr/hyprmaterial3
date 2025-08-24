//@ pragma ShellId shell

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "screenshot" as Screenshot
import "bar" as Bar
import "lock" as Lock
import "notifications" as Notifs
import "launcher" as Launcher
import "background"
import "resources/colors.js" as Palette
import "./session/"
import "resources/components/DialogService.js" as DialogService
import "views/Shell.qml" as AppShell
import "bar/roundedcorner"
import qs.ai
import qs.screenCorners
import qs.services
import qs.common
import qs.common.widgets
import qs.common.functions

ShellRoot {
	property bool enableScreenCorners: true
    property bool enableSession: true
	property bool enableAi: true

	Component.onCompleted: {
		Lock.Controller
		Launcher.Controller.init()
		// MaterialThemeLoader.reapplyTheme()
        Hyprsunset.load()
        FirstRunExperience.load()
        ConflictKiller.load()
        Cliphist.refresh()
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

	Notifs.NotificationOverlay {
    	screen: Quickshell.screens.find(s => s.name == "DP-1") || null
    	Component.onCompleted: {
       		if (!screen) {
            	screen = Quickshell.screens.find(s => s.name == "DP-1")
        	}
    	}
	}

	Variants {
		model: Quickshell.screens

		Scope {
			property var modelData

			Bar.Bar {
				// screen: modelData
			}

			PanelWindow {
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
			}
		}
	}

	LazyLoader { active: enableScreenCorners; component: ScreenCorners {} }
	LazyLoader { active: enableSession; component: Session {} }
	LazyLoader { active: enableAi; component: AiChatbot {} }
}