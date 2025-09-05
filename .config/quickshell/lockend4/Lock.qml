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

    // This stores all the information shared between the lock surfaces on each screen.
    LockContext {
        id: lockContext

        onUnlocked: {
            GlobalStates.screenLocked = false;
            Quickshell.execDetached(["bash", "-c", "sleep 0.2; hyprctl --batch 'dispatch togglespecialworkspace; dispatch togglespecialworkspace'"]);
        }
    }

    WlSessionLock {
        id: lock
        locked: GlobalStates.screenLocked

        WlSessionLockSurface {
            color: "transparent"
            Loader {
                active: GlobalStates.screenLocked
                anchors.fill: parent
                opacity: active ? 1 : 0
                Behavior on opacity {
                    NumberAnimation { duration: 300 }
                }
                sourceComponent: LockSurface {
                    context: lockContext
                }
                
                // Background with proper error handling
                Rectangle {
                    anchors.fill: parent
                    color: "#1a1b26" // Nice dark fallback color
                    
                    Image {
                        id: lockImage
                        anchors.fill: parent
                        source: "file://" + root.wallpaperPath
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        mipmap: true
                        
                        onStatusChanged: {
                            console.log("Image status:", status, "source:", source);
                            if (status === Image.Ready) {
                                console.log("Wallpaper loaded successfully!");
                                root.imageLoaded = true;
                            } else if (status === Image.Error) {
                                console.log("Failed to load wallpaper");
                                console.log("Path:", root.wallpaperPath);
                                root.imageLoaded = false;
                            } else if (status === Image.Loading) {
                                console.log("Loading wallpaper...");
                            }
                        }
                    }

                    // Fallback gradient if image doesn't load
                    Rectangle {
                        anchors.fill: parent
                        visible: !root.imageLoaded
                        color: Palette.palette().onPrimary
                        
						Clock {
							anchors.centerIn: parent
						}
                    }

                    // Debug info
                    Rectangle {
                        anchors {
                            top: parent.top
                            left: parent.left
                            margins: 10
                        }
                        width: 250
                        height: 80
                        color: AppearanceRippleButton.m3colors.shadow
                        radius: 5
                        visible: false  // Set to true to show debug info
                        
                        Column {
                            anchors.fill: parent
                            anchors.margins: 5
                            spacing: 2
                            
                            Text {
                                text: "Status: " + lockImage.status
                                color: "white"
                                font.pixelSize: 10
                            }
                            Text {
                                text: "Loaded: " + root.imageLoaded
                                color: "white"
                                font.pixelSize: 10
                            }
                            Text {
                                text: "Source: " + lockImage.source
                                color: "white"
                                font.pixelSize: 8
                                elide: Text.ElideRight
                                width: parent.width
                            }
                        }
                    }
                }
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
                anchors {
                    top: true
                    left: true
                    right: true
                }
                implicitHeight: 1
                exclusiveZone: screen.height * 3
            }
        }
    }

    IpcHandler {
        target: "lock"

        function activate() {
            GlobalStates.screenLocked = true;
        }
        function focus() {
            lockContext.shouldReFocus();
        }
    }

    GlobalShortcut {
        name: "lock"
        description: "Locks the screen"

        onPressed: {
            GlobalStates.screenLocked = true;
        }
    }

    GlobalShortcut {
        name: "lockFocus"
        description: "Re-focuses the lock screen"

        onPressed: {
            console.log("Refocusing lock screen");
            lockContext.shouldReFocus();
        }
    }

    Component.onCompleted: {
        console.log("Lockscreen initialized");
        console.log("Wallpaper path: file://" + wallpaperPath);
        
        // Test if file is readable
        Quickshell.execDetached(["bash", "-c", "if [ -r \"" + wallpaperPath + "\" ]; then echo \"File is readable\"; else echo \"Cannot read file\"; fi"]);
    }
}