// 💚 ✨ HyprYoshi3 ✨ 🦕

pragma ComponentBehavior: Bound
import QtQuick
import qs
import qs.services
import qs.common
import qs.common.widgets
import qs.common.functions
import Quickshell

Item {
    id: root

    required property int length
    property int selectionStart: 0
    property int selectionEnd: 0
    property int cursorPosition: 0

    property color color: Appearance?.colors?.colPrimary ?? "#bb86fc"
    property color selectedTextColor: Appearance?.colors?.colOnSecondaryContainer ?? "#ffffff"
    property color selectionColor: Appearance?.colors?.colSecondaryContainer ?? "#3700B3"

    property int charSize: 20

    // FIXED: Force visibility
    clip: false
    visible: true
    opacity: 1
    z: 999  // FIXED: Make sure we're on top

    Component.onCompleted: {
        console.log("✨ PasswordChars loaded! length:", length);
    }

    onLengthChanged: {
        console.log("🔢 Password length changed to:", length);
    }

    // Scrollable content
    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: dotsRow.width
        contentHeight: root.charSize
        clip: true
        
        onContentWidthChanged: {
            if (contentWidth > width) {
                contentX = Math.max(0, contentWidth - width);
            }
        }

        // FIXED: Cursor now always visible
        Rectangle {
            id: cursor
            x: root.charSize * root.cursorPosition + 4
            y: (root.charSize - height) / 2
            color: root.color
            width: 2
            height: root.charSize
            visible: true  // FIXED: Always visible
            opacity: 1
            z: 1000
            
            Behavior on x {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            // Blinking animation
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                running: true  // FIXED: Always running
                NumberAnimation { to: 0.2; duration: 500 }
                NumberAnimation { to: 1; duration: 500 }
            }
        }

        // The actual password chars
        Row {
            id: dotsRow
            y: (root.charSize - root.charSize) / 2
            spacing: 0
            visible: true
            opacity: 1

            Repeater {
                model: root.length

                delegate: Rectangle {
                    id: charItem
                    required property int index
                    width: root.charSize
                    height: root.charSize
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    visible: true  // FIXED: Force visible
                    opacity: 1
                    
                    property bool selected: index >= root.selectionStart && index < root.selectionEnd

                    // Selection background
                    Rectangle {
                        anchors.fill: parent
                        color: root.selectionColor
                        opacity: charItem.selected ? 0.5 : 0  // FIXED: Semi-transparent when selected
                        radius: height / 2
                        
                        Behavior on opacity {
                            NumberAnimation { duration: 150 }
                        }
                    }
                    
                    // The material shape
                    MaterialShape {
                        id: materialShape
                        anchors.centerIn: parent
                        visible: true
                        
                        property list<var> charShapes: [
                            MaterialShape.Shape.Clover4Leaf,
                            MaterialShape.Shape.Arrow,
                            MaterialShape.Shape.Pill,
                            MaterialShape.Shape.SoftBurst,
                            MaterialShape.Shape.Diamond,
                            MaterialShape.Shape.ClamShell,
                            MaterialShape.Shape.Pentagon,
                        ]
                        
                        shape: charShapes[charItem.index % charShapes.length]
                        color: charItem.selected ? root.selectedTextColor : root.color
                        
                        // FIXED: Start at proper size, still animate
                        implicitSize: 14
                        opacity: 0
                        scale: 0.5
                        
                        Component.onCompleted: {
                            console.log(`🎨 Shape ${charItem.index} created`);
                            appearAnim.start();
                        }
                        
                        ParallelAnimation {
                            id: appearAnim
                            
                            NumberAnimation {
                                target: materialShape
                                property: "opacity"
                                to: 1
                                duration: 150
                                easing.type: Easing.OutCubic
                            }
                            
                            NumberAnimation {
                                target: materialShape
                                property: "scale"
                                to: 1
                                duration: 300
                                easing.type: Easing.OutBack
                            }
                        }
                        
                        // Smooth color transition
                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }
            }
        }
    }
}