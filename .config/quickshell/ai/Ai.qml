import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.0
import Quickshell.Io

ApplicationWindow {
    visible: true
    width: 600
    height: 500
    title: "QuickShell AI Chat"

    property string username: Qt.application.arguments.length > 1 ? Qt.application.arguments[1] : "user"
    property string selectedAI: "None"
    property string chatDir: Qt.homeDir + "/.local/share/hyprmaterial3/ai/chathist/"

    ListModel {
        id: chatModel
    }

    // Persistent storage for selected AI
    Settings {
        id: settings
        property string selectedAI: ""
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        padding: 10

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: chatList
                width: parent.width
                height: parent.height
                model: chatModel
                delegate: Text {
                    text: message
                    wrapMode: Text.Wrap
                    width: parent.width
                }
                clip: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 5

            ComboBox {
                id: aiSelector
                model: ["deepseek-r1:8b", "gemma3:4b"]

                Component.onCompleted: {
                    if (settings.selectedAI !== "" && model.indexOf(settings.selectedAI) !== -1) {
                        currentIndex = model.indexOf(settings.selectedAI)
                        selectedAI = settings.selectedAI
                        sendButton.enabled = true
                    } else {
                        currentIndex = -1
                        selectedAI = "None"
                        sendButton.enabled = false
                    }
                }

                onCurrentTextChanged: {
                    if (currentText === "" || currentText === "None") {
                        selectedAI = "None"
                        sendButton.enabled = false
                    } else {
                        selectedAI = currentText
                        sendButton.enabled = true
                        settings.selectedAI = currentText
                    }
                }
            }

            TextField {
                id: userInput
                Layout.fillWidth: true
                placeholderText: "Type your query..."
                enabled: sendButton.enabled
            }

            Button {
                id: sendButton
                text: "Send"
                enabled: false
                onClicked: {
                    if (userInput.text.trim() === "" || selectedAI === "None") return;

                    chatModel.append({message: username + ": " + userInput.text})
                    chatList.positionViewAtEnd()
                    aiProcess.start(["python3", "ai_backend.py", selectedAI, userInput.text])
                    userInput.text = ""
                }
            }

            Button {
                text: "New Chat"
                onClicked: chatModel.clear()
            }

            Button {
                text: "Delete Chat"
                onClicked: {
                    // Call Python backend to delete folder
                    if (chatModel.count === 0) return
                    aiProcess.start(["python3", "ai_delete_chat.py", chatDir])
                    chatModel.clear()
                }
            }
        }
    }

    IpcHandler {
        target: "ai"

        function toggle() {
            // Example toggle (you can implement real logic)
            console.log("AI toggled")
        }

        function sendQuery(query) {
            if (selectedAI === "None") return;
            chatModel.append({message: username + ": " + query})
            chatList.positionViewAtEnd()
            aiProcess.start(["python3", "ai_backend.py", selectedAI, query])
        }
    }

    Process {
        id: aiProcess
        onReadyReadStandardOutput: {
            let output = readAllStandardOutput()
            if (output.trim() !== "") {
                chatModel.append({message: selectedAI + ": " + output})
                chatList.positionViewAtEnd()
            }
        }
    }
}
