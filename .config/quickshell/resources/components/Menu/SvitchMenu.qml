import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Dropdown Menu"
    
    Rectangle {
        anchors.centerIn: parent
        width: 200
        height: 160
        color: "#f0f0f0"
        radius: 8
        border.color: "#ccc"
        border.width: 1
        
        Column {
            anchors.fill: parent
            anchors.margins: 10
            
            // Label
            Text {
                text: "Label"
                color: "#4a7c59"
                font.pixelSize: 14
                font.weight: Font.Medium
            }
            
            // Dropdown ComboBox
            ComboBox {
                id: dropdown
                width: parent.width - 20
                height: 40
                
                model: ["Item 1", "Item 2", "Item 3"]
                currentIndex: 1  // "Item 2" selected by default
                
                background: Rectangle {
                    color: dropdown.pressed ? "#e8e8e8" : "#ffffff"
                    border.color: "#4a7c59"
                    border.width: 2
                    radius: 4
                }
                
                contentItem: Text {
                    text: dropdown.displayText
                    font.pixelSize: 14
                    color: "#333"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 10
                }
                
                indicator: Canvas {
                    id: canvas
                    x: dropdown.width - width - 10
                    y: dropdown.topPadding + (dropdown.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"
                    
                    Connections {
                        target: dropdown
                        function onPressedChanged() { canvas.requestPaint(); }
                    }
                    
                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = "#4a7c59";
                        context.fill();
                    }
                }
                
                popup: Popup {
                    y: dropdown.height - 1
                    width: dropdown.width
                    implicitHeight: contentItem.implicitHeight
                    padding: 1
                    
                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: dropdown.popup.visible ? dropdown.delegateModel : null
                        currentIndex: dropdown.highlightedIndex
                        
                        ScrollIndicator.vertical: ScrollIndicator { }
                    }
                    
                    background: Rectangle {
                        border.color: "#4a7c59"
                        border.width: 1
                        radius: 4
                        color: "#ffffff"
                    }
                }
                
                delegate: ItemDelegate {
                    width: dropdown.width
                    contentItem: Text {
                        text: modelData
                        color: parent.hovered ? "#ffffff" : "#333"
                        font.pixelSize: 14
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                    }
                    
                    background: Rectangle {
                        color: parent.hovered ? "#4a7c59" : "transparent"
                        radius: 2
                    }
                }
            }
        }
    }
}