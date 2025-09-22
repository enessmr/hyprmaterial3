// main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./"
import Quickshell.Io

ApplicationWindow {
    width: 320
    height: 220
    title: "Emoji Picker Copy & Type"
    id: root
    visible: false

    property string selectedEmoji: "😄"

    // instantiate EmojiRunner
    EmojiRunner {
        id: emojiRunner
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        ComboBox {
            id: emojiCombo
            Layout.fillWidth: true
            model: ["😄", "🥺", "🔥", "💀", "🎉", "❤️", "👋", "🍕"]
            currentIndex: 0
            onCurrentIndexChanged: {
                root.selectedEmoji = emojiCombo.currentText
            }
        }

        Button {
            text: "Copy + Type Emoji"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                emojiRunner.run(emojiCombo.currentText)  // call the run() function
            }
        }

        Text {
            text: root.selectedEmoji
            font.pixelSize: 72
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignHCenter
            width: parent.width
        }
    }

    IpcHandler {
        target: "emoji"
        function toggle(): void {
            root.visible = !root.visible
        }
    }
}
