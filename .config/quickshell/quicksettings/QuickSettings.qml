import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell
import Quickshell.Wayland

Scope {
    id: root
    property bool visible: false // controls quicksettings

    Loader {
        id: qsLoader
        active: true
        sourceComponent: PanelWindow {
            id: qsRoot
            color: "transparent"
            visible: root.visible
            
            // The 'interactive' property doesn't exist in PanelWindow
            // Instead, we'll handle click behavior through other means
            // We can use a MouseArea to make the window non-interactive when hidden
            MouseArea {
                anchors.fill: parent
                enabled: root.visible
                // This prevents clicks from passing through when visible
                onPressed: mouse.accepted = true
            }

            WlrLayershell.namespace: "quickshell:osdQS"
            WlrLayershell.layer: WlrLayer.Overlay
            width: Screen.width
            height: Screen.height * 0.5 // half-screen overlay
            anchors.top: parent.top

            Rectangle {
                anchors.fill: parent
                color: "#22222288"
                radius: 20
                
                // Add some example settings content
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    
                    Text {
                        text: "Quick Settings"
                        font.bold: true
                        font.pixelSize: 24
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        Button {
                            text: "Wi-Fi"
                            icon.source: "qrc:/wifi-icon.svg"
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 100
                        }
                        
                        Button {
                            text: "Bluetooth"
                            icon.source: "qrc:/bluetooth-icon.svg"
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 100
                        }
                        
                        Button {
                            text: "Brightness"
                            icon.source: "qrc:/brightness-icon.svg"
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 100
                        }
                    }
                    
                    Slider {
                        Layout.fillWidth: true
                        value: 0.7
                        onValueChanged: console.log("Brightness changed to:", value)
                    }
                    
                    Switch {
                        text: "Dark Mode"
                        checked: true
                        onCheckedChanged: console.log("Dark mode:", checked)
                    }
                    
                    Item {
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "quicksettings"
        function toggle() {
            root.visible = !root.visible
        }
    }
}