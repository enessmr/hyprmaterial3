// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.common
import qs
import "../services" as DihServices
import qs.common.widgets
import qs.common.functions
import "../resources/colors.js" as Pallete

Scope {
    id: root
    property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)
    property bool packageManagerRunning: false
    property bool downloadRunning: false

    function closeAllWindows() {
        (DihServices.HyprlandData.windowList || []).forEach(w => {
            if (!w.className.includes("Settings") && !w.className.includes("Launcher")) {
                Quickshell.execDetached(["kill", w.pid]);
            }
        });
    }

    function detectRunningStuff() {
        packageManagerRunning = false;
        downloadRunning = false;
        detectPackageManagerProc.running = true;
        detectDownloadProc.running = true;
    }

    Process {
        id: detectPackageManagerProc
        command: ["pidof", "pacman", "yay", "paru", "dnf", "zypper", "apt", "apx", "xbps", "flatpak", "snap", "apk",
                  "yum", "epsi", "pikman"]
        onExited: (exitCode) => { root.packageManagerRunning = (exitCode === 0); }
    }

    Process {
        id: detectDownloadProc
        command: ["bash", "-c", "pidof curl wget aria2c yt-dlp || ls ~/Downloads | grep -E '\\.crdownload$|\\.part$'"]
        onExited: (exitCode) => { root.downloadRunning = (exitCode === 0); }
    }

    Loader {
        id: sessionLoader
        active: GlobalStates.sessionOpen
        onActiveChanged: {
            if (sessionLoader.active) root.detectRunningStuff();
        }
        Connections {
            target: GlobalStates
            function onScreenLockedChanged() {
                if (GlobalStates.screenLocked) GlobalStates.sessionOpen = false;
            }
        }

        sourceComponent: PanelWindow {
            id: sessionRoot
            visible: sessionLoader.active
            property string subtitle
            function hide() { GlobalStates.sessionOpen = false; }
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "quickshell:session"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            color: ColorUtils.transparentize(Appearance?.m3colors?.m3shadow, 0.1)

            anchors {
                top: true
                left: true
                right: true
            }
            implicitWidth: root.focusedScreen?.width ?? 0
            implicitHeight: root.focusedScreen?.height ?? 0

            MouseArea {
                anchors.fill: parent
                onClicked: { sessionRoot.hide(); }
            }

            // Centered container with Android 12 styling
            Item {
                anchors.centerIn: parent
                width: Math.min(parent.width * 2.9, 400)
                height: Math.min(parent.height * 2.8, 725)

                Rectangle {
                    anchors.fill: parent
                    color: Appearance?.m3colors?.m3surfaceContainerLowest
                    radius: 28
                }

                ColumnLayout {
                    id: contentColumn
                    anchors.centerIn: parent
                    anchors.margins: 40
                    spacing: 32

                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Escape) sessionRoot.hide();
                    }

                    // Android 12 style grid with larger, centered buttons
                    GridLayout {
                        Layout.alignment: Qt.AlignHCenter
                        columns: 2
                        columnSpacing: 24
                        rowSpacing: 24
                        Layout.preferredWidth: 400
                        anchors.leftMargin: 15
                        anchors.left: parent.left

                        // Components for Android 12 style buttons
                        Component {
                            id: sessionLockComp
                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 12
                                
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    width: 160
                                    height: 120
                                    radius: 20
                                    color: "transparent"
                                    
                                    SessionActionButton {
                                        id: sessionLock
                                        anchors.centerIn: parent
                                        buttonIcon: "lock"
                                        buttonText: "Lock"
                                        
                                        onClicked: { 
                                            Quickshell.execDetached(["loginctl", "lock-session"]); 
                                            sessionRoot.hide() 
                                        }
                                        onFocusChanged: {
                                            if (focus) sessionRoot.subtitle = buttonText
                                        }
                                        
                                        KeyNavigation.right: sessionSleep
                                        KeyNavigation.down: sessionHibernate
                                    }
                                }
                                
                                StyledText {
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Lock screen"
                                    font.pixelSize: 14
                                    font.family: "Roboto"
                                    font.weight: Font.Medium
                                    color: Appearance?.m3colors?.m3onSurface
                                }
                            }
                        }

                        Component {
                            id: sessionSleepComp
                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 12
                                
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    width: 160
                                    height: 120
                                    radius: 20
                                    color: "transparent"
                                    
                                    SessionActionButton {
                                        id: sessionSleep
                                        anchors.centerIn: parent
                                        buttonIcon: "dark_mode"
                                        buttonText: "Sleep"
                                        
                                        scale: focus ? 0.8 : 1.0
                                        Behavior on scale {
                                            NumberAnimation { 
                                                duration: 150 
                                                easing.type: Easing.OutCubic 
                                            }
                                        }
                                        
                                        onClicked: { 
                                            Quickshell.execDetached(["bash", "-c", "systemctl suspend || loginctl suspend"]); 
                                            sessionRoot.hide() 
                                        }
                                        onFocusChanged: { 
                                            if (focus) sessionRoot.subtitle = buttonText 
                                        }
                                        
                                        KeyNavigation.left: sessionLock
                                        KeyNavigation.right: sessionLogout
                                        KeyNavigation.down: sessionShutdown
                                    }
                                }
                                
                                StyledText {
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Sleep"
                                    font.pixelSize: 14
                                    font.family: "Roboto"
                                    font.weight: Font.Medium
                                    color: Appearance?.m3colors?.m3onSurface
                                }
                            }
                        }

                        Component {
                            id: sessionLogoutComp
                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 12
                                
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    width: 160
                                    height: 120
                                    radius: 20
                                    color: "transparent"
                                    
                                    SessionActionButton {
                                        id: sessionLogout
                                        anchors.centerIn: parent
                                        buttonIcon: "logout"
                                        buttonText: "Logout"
                                        
                                        scale: focus ? 0.8 : 1.0
                                        Behavior on scale {
                                            NumberAnimation { 
                                                duration: 150 
                                                easing.type: Easing.OutCubic 
                                            }
                                        }
                                        
                                        onClicked: { 
                                            root.closeAllWindows(); 
                                            Quickshell.execDetached(["pkill", "Hyprland"]); 
                                            sessionRoot.hide() 
                                        }
                                        onFocusChanged: {
                                            if (focus) sessionRoot.subtitle = buttonText
                                        }
                                        
                                        KeyNavigation.left: sessionSleep
                                        KeyNavigation.right: sessionTaskManager
                                        KeyNavigation.down: sessionReboot
                                    }
                                }
                                
                                StyledText {
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Sign out"
                                    font.pixelSize: 14
                                    font.family: "Roboto"
                                    font.weight: Font.Medium
                                    color: Appearance?.m3colors?.m3onSurface
                                }
                            }
                        }

                        Component {
                            id: sessionTaskManagerComp
                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 12
                                
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    width: 160
                                    height: 120
                                    radius: 20
                                    color: "transparent"
                                    
                                    SessionActionButton {
                                        id: sessionTaskManager
                                        anchors.centerIn: parent
                                        buttonIcon: "browse_activity"
                                        buttonText: "Task Manager"
                                        
                                        scale: focus ? 0.8 : 1.0
                                        Behavior on scale {
                                            NumberAnimation { 
                                                duration: 150 
                                                easing.type: Easing.OutCubic 
                                            }
                                        }
                                        
                                        onClicked: { 
                                            Quickshell.execDetached(["bash", "-c", `${Config.options.apps.taskManager}`]); 
                                            sessionRoot.hide() 
                                        }
                                        onFocusChanged: { 
                                            if (focus) sessionRoot.subtitle = buttonText 
                                        }
                                        
                                        KeyNavigation.left: sessionLogout
                                        KeyNavigation.down: sessionFirmwareReboot
                                    }
                                }
                                
                                StyledText {
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Task manager"
                                    font.pixelSize: 14
                                    font.family: "Roboto"
                                    font.weight: Font.Medium
                                    color: Appearance?.m3colors?.m3onSurface
                                }
                            }
                        }

                        Component {
                            id: sessionHibernateComp
                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 12
                                
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    width: 160
                                    height: 120
                                    radius: 20
                                    color: "transparent"
                                    
                                    SessionActionButton {
                                        id: sessionHibernate
                                        anchors.centerIn: parent
                                        buttonIcon: "downloading"
                                        buttonText: "Hibernate"
                                        
                                        scale: focus ? 0.8 : 1.0
                                        Behavior on scale {
                                            NumberAnimation { 
                                                duration: 150 
                                                easing.type: Easing.OutCubic 
                                            }
                                        }
                                        
                                        onClicked: { 
                                            Quickshell.execDetached(["bash", "-c", `systemctl hibernate || loginctl hibernate`]); 
                                            sessionRoot.hide() 
                                        }
                                        onFocusChanged: { 
                                            if (focus) sessionRoot.subtitle = buttonText 
                                        }
                                        
                                        KeyNavigation.up: sessionLock
                                        KeyNavigation.right: sessionShutdown
                                    }
                                }
                                
                                StyledText {
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Hibernate"
                                    font.pixelSize: 14
                                    font.family: "Roboto"
                                    font.weight: Font.Medium
                                    color: Appearance?.m3colors?.m3onSurface
                                }
                            }
                        }

                        Component {
                            id: sessionShutdownComp
                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 12
                                
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    width: 160
                                    height: 120
                                    radius: 20
                                    color: "transparent"
                                    
                                    SessionActionButton {
                                        id: sessionShutdown
                                        anchors.centerIn: parent
                                        buttonIcon: "power_settings_new"
                                        buttonText: "Shutdown"
                                        
                                        scale: focus ? 0.8 : 1.0
                                        Behavior on scale {
                                            NumberAnimation { 
                                                duration: 150 
                                                easing.type: Easing.OutCubic 
                                            }
                                        }
                                        
                                        onClicked: { 
                                            root.closeAllWindows(); 
                                            Quickshell.execDetached(["bash", "-c", `systemctl poweroff || loginctl poweroff`]); 
                                            sessionRoot.hide() 
                                        }
                                        onFocusChanged: { 
                                            if (focus) sessionRoot.subtitle = buttonText 
                                        }
                                        
                                        KeyNavigation.left: sessionHibernate
                                        KeyNavigation.right: sessionReboot
                                        KeyNavigation.up: sessionSleep
                                    }
                                }
                                
                                StyledText {
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Power off"
                                    font.pixelSize: 14
                                    font.family: "Roboto"
                                    font.weight: Font.Medium
                                    color: Appearance?.m3colors?.m3onSurface
                                }
                            }
                        }

                        Component {
                            id: sessionRebootComp
                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 12
                                
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    width: 160
                                    height: 120
                                    radius: 20
                                    color: "transparent"
                                    
                                    SessionActionButton {
                                        id: sessionReboot
                                        anchors.centerIn: parent
                                        buttonIcon: "restart_alt"
                                        buttonText: "Reboot"
                                        
                                        scale: focus ? 0.8 : 1.0
                                        Behavior on scale {
                                            NumberAnimation { 
                                                duration: 150 
                                                easing.type: Easing.OutCubic 
                                            }
                                        }
                                        
                                        onClicked: { 
                                            root.closeAllWindows(); 
                                            Quickshell.execDetached(["bash", "-c", `reboot || loginctl reboot`]); 
                                            sessionRoot.hide() 
                                        }
                                        onFocusChanged: { 
                                            if (focus) sessionRoot.subtitle = buttonText 
                                        }
                                        
                                        KeyNavigation.left: sessionShutdown
                                        KeyNavigation.right: sessionFirmwareReboot
                                        KeyNavigation.up: sessionLogout
                                    }
                                }
                                
                                StyledText {
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Restart"
                                    font.pixelSize: 14
                                    font.family: "Roboto"
                                    font.weight: Font.Medium
                                    color: Appearance?.m3colors?.m3onSurface
                                }
                            }
                        }

                        Component {
                            id: sessionFirmwareRebootComp
                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 12
                                
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    width: 160
                                    height: 120
                                    radius: 20
                                    color: "transparent"
                                    
                                    SessionActionButton {
                                        id: sessionFirmwareReboot
                                        anchors.centerIn: parent
                                        buttonIcon: "settings_applications"
                                        buttonText: "Reboot to firmware settings"
                                        
                                        scale: focus ? 0.8 : 1.0
                                        Behavior on scale {
                                            NumberAnimation { 
                                                duration: 150 
                                                easing.type: Easing.OutCubic 
                                            }
                                        }
                                        
                                        onClicked: { 
                                            root.closeAllWindows(); 
                                            Quickshell.execDetached(["bash", "-c", `systemctl reboot --firmware-setup || loginctl reboot --firmware-setup`]); 
                                            sessionRoot.hide() 
                                        }
                                        onFocusChanged: { 
                                            if (focus) sessionRoot.subtitle = buttonText 
                                        }
                                        
                                        KeyNavigation.left: sessionReboot
                                        KeyNavigation.up: sessionTaskManager
                                    }
                                }
                                
                                StyledText {
                                    Layout.alignment: Qt.AlignHCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Boot to BIOS"
                                    font.pixelSize: 14
                                    font.family: "Roboto"
                                    font.weight: Font.Medium
                                    color: Appearance?.m3colors?.m3onSurface
                                }
                            }
                        }

                        // Loaders to instantiate buttons in the centered grid
                        Loader { sourceComponent: sessionLockComp }
                        Loader { sourceComponent: sessionSleepComp }
                        Loader { sourceComponent: sessionLogoutComp }
                        Loader { sourceComponent: sessionTaskManagerComp }
                        Loader { sourceComponent: sessionHibernateComp }
                        Loader { sourceComponent: sessionShutdownComp }
                        Loader { sourceComponent: sessionRebootComp }
                        Loader { sourceComponent: sessionFirmwareRebootComp }
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "session"
        function toggle(): void { GlobalStates.sessionOpen = !GlobalStates.sessionOpen; }
        function close(): void { GlobalStates.sessionOpen = false; }
        function open(): void { GlobalStates.sessionOpen = true; }
    }

    GlobalShortcut {
        name: "sessionToggle"
        description: "Toggles session screen on press"
        onPressed: { GlobalStates.sessionOpen = !GlobalStates.sessionOpen; }
    }
    GlobalShortcut {
        name: "sessionOpen"
        description: "Opens session screen on press"
        onPressed: { GlobalStates.sessionOpen = true; }
    }
    GlobalShortcut {
        name: "sessionClose"
        description: "Closes session screen on press"
        onPressed: { GlobalStates.sessionOpen = false; }
    }
}