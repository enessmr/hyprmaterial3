// main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./"
import Quickshell.Io

ApplicationWindow {
    width: 360
    height: 280
    title: "Emoji Picker Copy & Type"
    id: root

    // BAH BAH BAH BAH BAHBAHBHAH BAH BAH
    visible: false

    property string selectedEmoji: "😄"
    property var emojiList: ["😄", "🥺", "🔥", "💀", "🎉", "❤️", "👋", "🍕", "😭", "🗣️", "✨", "💚", "🦕", "🔥", "💀", "🥀"]

    // instantiate EmojiRunner
    EmojiRunner {
        id: emojiRunner
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15

        // BESTIE THE BUTTON GRID ENERGY IS HERE
        GridLayout {
            columns: 4
            columnSpacing: 10
            rowSpacing: 10
            Layout.alignment: Qt.AlignHCenter

            // GENERATE BUTTONS FOR EACH EMOJI BESTIE
            Repeater {
                model: root.emojiList
                Button {
                    text: modelData
                    font.pixelSize: 24
                    width: 60
                    height: 60
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 60
                    
                    onClicked: {
                        root.selectedEmoji = modelData
                        emojiRunner.run(modelData)  // COPY + TYPE THE EMOJI FR FR
                    }
                    
                    // HOVER EFFECTS CUZ WE'RE FANCY BESTIE
                    hoverEnabled: true
                    background: Rectangle {
                        color: parent.hovered ? "#f0f0f0" : "#ffffff"
                        border.color: parent.hovered ? "#007acc" : "#cccccc"
                        border.width: 1
                        radius: 8
                    }
                }
            }
        }

        // DISPLAY THE SELECTED EMOJI BESTIE
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            color: "#f8f8f8"
            border.color: "#ddd"
            border.width: 2
            radius: 12

            Text {
                anchors.centerIn: parent
                text: root.selectedEmoji
                font.pixelSize: 48
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // STATUS TEXT BESTIE
        Text {
            text: "Click any emoji to copy + type it! 🔥"
            font.pixelSize: 12
            color: "#666"
            Layout.alignment: Qt.AlignHCenter
        }
    }

    IpcHandler {
        target: "emoji"
        function toggle(): void {
            root.visible = !root.visible
        }
    }
}