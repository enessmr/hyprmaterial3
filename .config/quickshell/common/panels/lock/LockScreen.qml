pragma ComponentBehavior: Bound
import qs
import qs.services
import qs.common
import qs.common.functions
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.settings
import qs.lockend4

Scope {
    id: root

    property string wallpaperPath: ""
    property bool imageLoaded: false

    // FIXED: Better wallpaper path handling
    Process {
        id: goonerFinder
        running: true
        command: [ "bash", "-c", "swww query 2>/dev/null | grep -oP 'image: \\K.*' || echo ''" ]

        stdout: StdioCollector {
            onStreamFinished: {
                var rawPath = this.text.trim();
                console.log(`RAW WALLPAPER PATH: ${rawPath}`);
                
                if (rawPath && rawPath.length > 0) {
                    // FIXED: Don't double-resolve if already absolute
                    if (rawPath.startsWith('/')) {
                        wallpaperPath = "file://" + rawPath;
                    } else {
                        wallpaperPath = Qt.resolvedUrl(rawPath);
                    }
                    console.log(`RESOLVED WALLPAPER: ${wallpaperPath}`);
                } else {
                    console.log("NO WALLPAPER FOUND, using fallback");
                    // Fallback to Pictures folder
                    wallpaperPath = "file://" + StandardPaths.writableLocation(StandardPaths.PicturesLocation) + "/.Wallpapers/wallpaper.jpg";
                }
                
                goonerFinder.running = false;
            }
        }
        
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text.length > 0) {
                    console.log(`SWWW ERROR: ${this.text}`);
                }
            }
        }
    }

    required property Component lockSurface
    property alias context: lockContext
    property Component sessionLockSurface: WlSessionLockSurface {
        id: sessionLockSurface
        color: "transparent"
        Loader {
            active: GlobalStates.screenLocked
            anchors.fill: parent
            opacity: active ? 1 : 0
            Behavior on opacity {
                animation: Appearance.animation.elementMoveFast.colorAnimation.createObject(this)
            }
            sourceComponent: Component {
                Rectangle {
                    anchors.fill: parent
                    color: "#1a1b26"

                    // FIXED: More robust image loading
                    Image {
                        id: lockImage
                        anchors.fill: parent
                        source: root.wallpaperPath
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        mipmap: true
                        cache: false  // FIXED: Don't cache in case wallpaper changes
                        z: 0

                        onStatusChanged: {
                            console.log(`Image status changed: ${status} (Loading=${Image.Loading}, Ready=${Image.Ready}, Error=${Image.Error})`);
                            if (status === Image.Ready) {
                                console.log("✅ Wallpaper loaded successfully!");
                                root.imageLoaded = true;
                            } else if (status === Image.Error) {
                                console.log(`❌ Wallpaper failed to load from: ${source}`);
                                root.imageLoaded = false;
                            } else if (status === Image.Loading) {
                                console.log("⏳ Loading wallpaper...");
                            }
                        }
                        
                        onSourceChanged: {
                            console.log(`Image source changed to: ${source}`);
                        }
                    }

                    // Fallback rectangle (shown when image fails)
                    Rectangle {
                        anchors.fill: parent
                        color: Appearance?.m3colors?.m3onPrimary ?? "#1a1b26"
                        opacity: lockImage.status === Image.Ready ? 0 : 1
                        Behavior on opacity { NumberAnimation { duration: 300 } }
                        z: 1
                    }

                    // Clock always on top
                    Clock {
                        anchors.centerIn: parent
                        z: 2
                    }

                    // Lock surface content
                    Loader {
                        anchors.fill: parent
                        sourceComponent: root.lockSurface
                        z: 3
                    }

                    // Debug info
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.margins: 10
                        width: 300
                        height: 100
                        color: Appearance?.m3colors?.m3background ?? "#1a1b26"
                        border.width: 2
                        border.color: Appearance?.m3colors?.m3outlineVariant ?? "#444"
                        radius: 16
                        visible: true  // CHANGED: Always visible for debugging
                        z: 999

                        Column {
                            anchors.fill: parent
                            anchors.margins: 5
                            spacing: 2
                            Text { text: "Status: " + lockImage.status; color: "white"; font.pixelSize: 10 }
                            Text { text: "Loaded: " + root.imageLoaded; color: "white"; font.pixelSize: 10 }
                            Text { text: "Source: " + lockImage.source; color: "white"; font.pixelSize: 8; elide: Text.ElideRight; width: parent.width }
                            Text { text: "Path: " + root.wallpaperPath; color: "white"; font.pixelSize: 8; elide: Text.ElideRight; width: parent.width }
                        }
                    }
                }
            }
        }
    }

    Process {
        id: unlockKeyringProc
        onExited: (exitCode, exitStatus) => {
            KeyringStorage.fetchKeyringData();
        }
    }
    
    function unlockKeyring() {
        unlockKeyringProc.exec({
            environment: ({
                "UNLOCK_PASSWORD": lockContext.currentText
            }),
            command: ["bash", "-c", Quickshell.shellPath("scripts/keyring/unlock.sh")]
        })
    }

    LockContext {
        id: lockContext

        Connections {
            target: GlobalStates
            function onScreenLockedChanged() {
                if (GlobalStates.screenLocked) {
                    lockContext.reset();
                    lockContext.tryFingerUnlock();
                }
            }
        }

        onUnlocked: (targetAction) => {
            console.log(`🔓 UNLOCK TRIGGERED with action: ${targetAction}`);
            
            // CRITICAL FIX: Prevent re-entry
            if (!GlobalStates.screenLocked) {
                console.log("Already unlocked, ignoring");
                return;
            }
            
            // Perform the target action if it's not just unlocking
            if (targetAction == LockContext.ActionEnum.Poweroff) {
                console.log("Powering off...");
                Session.poweroff();
                return;
            } else if (targetAction == LockContext.ActionEnum.Reboot) {
                console.log("Rebooting...");
                Session.reboot();
                return;
            }

            // Unlock the keyring if configured
            if (Config.options.lock.security.unlockKeyring) {
                console.log("Unlocking keyring...");
                root.unlockKeyring();
            }

            // CRITICAL FIX: Unlock screen FIRST
            console.log("Unlocking screen...");
            GlobalStates.screenLocked = false;
            
            // Refocus last window (async, non-blocking)
            Qt.callLater(function() {
                Quickshell.execDetached(["bash", "-c", 
                    `sleep 0.2; hyprctl --batch "dispatch togglespecialworkspace; dispatch togglespecialworkspace"`
                ]);
            });

            // Reset context
            lockContext.reset();

            // Post-unlock idle inhibit
            if (lockContext.alsoInhibitIdle) {
                lockContext.alsoInhibitIdle = false;
                Idle.toggleInhibit(true);
            }
        }
    }

    WlSessionLock {
        id: lock
        locked: GlobalStates.screenLocked
        surface: root.sessionLockSurface
    }

    function lock() {
        if (Config.options.lock.useHyprlock) {
            Quickshell.execDetached(["bash", "-c", "pidof hyprlock || hyprlock"]);
            return;
        }
        GlobalStates.screenLocked = true;
    }

    IpcHandler {
        target: "lock"
        function activate(): void {
            root.lock();
        }
        function focus(): void {
            lockContext.shouldReFocus();
        }
    }

    GlobalShortcut {
        name: "lock"
        description: "Locks the screen"
        onPressed: {
            root.lock()
        }
    }

    GlobalShortcut {
        name: "lockFocus"
        description: "Re-focuses the lock screen"
        onPressed: {
            lockContext.shouldReFocus();
        }
    }

    function initIfReady() {
        if (!Config.ready || !Persistent.ready) return;
        if (Config.options.lock.launchOnStartup && Persistent.isNewHyprlandInstance) {
            root.lock();
        } else {
            KeyringStorage.fetchKeyringData();
        }
    }
    
    Connections {
        target: Config
        function onReadyChanged() {
            root.initIfReady();
        }
    }
    
    Connections {
        target: Persistent
        function onReadyChanged() {
            root.initIfReady();
        }
    }
}