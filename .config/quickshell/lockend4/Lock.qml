import qs
import qs.common
import qs.common.functions
import qs.lockend4
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt.labs.platform 1.1
import "../resources/colors.js" as Palette

Scope {
    id: root

    property string wallpaperPath: StandardPaths.writableLocation(StandardPaths.PicturesLocation) + "/.Wallpapers/wallpaper.jpg"
    property bool imageLoaded: false

    // Shared lock context
    LockContext {
        id: lockContext

        onUnlocked: {
            GlobalStates.screenLocked = false
            Quickshell.execDetached(["bash", "-c", "sleep 0.2; hyprctl --batch 'dispatch togglespecialworkspace; dispatch togglespecialworkspace'"])
        }
    }

    WlSessionLock {
        id: lock
        locked: GlobalStates.screenLocked

        WlSessionLockSurface {
            color: "transparent"

            // Loader for the actual lockscreen, initially inactive
            Loader {
                id: lockLoader
                active: false
                anchors.fill: parent
                opacity: active ? 1 : 0
                Behavior on opacity { NumberAnimation { duration: 300 } }
                sourceComponent: LockSurface {
                    context: lockContext
                }

                // Background rectangle inside the loader
                Rectangle {
                    anchors.fill: parent
                    color: "#1a1b26"

                    // Full wallpaper image
                    Image {
                        id: lockImage
                        anchors.fill: parent
                        source: Qt.resolvedUrl(root.wallpaperPath)
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        mipmap: true
                        z: 0

                        onStatusChanged: {
                            if (status === Image.Ready) {
                                console.log("Wallpaper loaded!")
                                root.imageLoaded = true
                                lockLoader.active = true // show lockscreen
                            } else if (status === Image.Error) {
                                console.log("Wallpaper failed to load")
                                root.imageLoaded = false
                                lockLoader.active = true // still show lockscreen
                            }
                        }
                    }

                    // Fallback rectangle behind clock (always present)
                    Rectangle {
                        anchors.fill: parent
                        color: Palette.palette().onPrimary
                        opacity: lockImage.status === Image.Ready ? 0 : 1
                        Behavior on opacity { NumberAnimation { duration: 300 } }
                        z: 1
                    }

                    // Clock always on top
                    Clock {
                        anchors.centerIn: parent
                        z: 2
                    }

                    // Debug info (optional)
                    Rectangle {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        // margins: 10
                        width: 250
                        height: 80
                        color: AppearanceRippleButton.m3colors.shadow
                        radius: 5
                        visible: false
                        z: 3

                        Column {
                            anchors.fill: parent
                            anchors.margins: 5
                            spacing: 2
                            Text { text: "Status: " + lockImage.status; color: "white"; font.pixelSize: 10 }
                            Text { text: "Loaded: " + root.imageLoaded; color: "white"; font.pixelSize: 10 }
                            Text { text: "Source: " + lockImage.source; color: "white"; font.pixelSize: 8; elide: Text.ElideRight; width: parent.width }
                        }
                    }
                }
            }

            // Hidden preload image for smooth startup (optional)
            Image {
                id: preloadImage
                visible: false
                source: Qt.resolvedUrl(root.wallpaperPath)
                asynchronous: true
                mipmap: true
            }
        }
    }

    // Blur layer hack
    Variants {
        model: Quickshell.screens

        LazyLoader {
            id: blurLayerLoader
            required property var modelData
            active: GlobalStates.screenLocked
            component: PanelWindow {
                screen: blurLayerLoader.modelData
                WlrLayershell.namespace: "quickshell:lockWindowPusher"
                color: "transparent"
                anchors.top: true
                anchors.left: true
                anchors.right: true
                implicitHeight: 1
                exclusiveZone: screen.height * 3
            }
        }
    }

    // IPC handler
    IpcHandler {
        target: "lock"
        function activate() { GlobalStates.screenLocked = true }
        function focus() { lockContext.shouldReFocus() }
    }

    // Global shortcuts
    GlobalShortcut { name: "lock"; description: "Locks the screen"; onPressed: { GlobalStates.screenLocked = true } }
    GlobalShortcut { name: "lockFocus"; description: "Refocuses lock screen"; onPressed: { lockContext.shouldReFocus() } }

    Component.onCompleted: {
        console.log("Lockscreen initialized")
        console.log("Wallpaper path: file://" + wallpaperPath)

        // Test if file is readable
        Quickshell.execDetached(["bash", "-c", "if [ -r \"" + wallpaperPath + "\" ]; then echo \"File is readable\"; else echo \"Cannot read file\"; fi"])
    }
}
