//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
//@ pragma Env QT_SCALE_FACTOR=1

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell.Io
import qs
import qs.common.functions as CF

ApplicationWindow {
    id: root
    visible: GlobalStates.aiOpen
    title: "QuickShell AI Chat"
    width: 700
    height: 500
    color: "white"

    property string username: Qt.application.arguments.length > 1 ? Qt.application.arguments[1] : "user"
    property string selectedAI: "None"
    property string receivedQuery: ""   // global query
    property string chatDir: Qt.homeDir + "/.local/share/hyprmaterial3/ai/chathist/"
    property real contentPadding: 8
    property string scriptsPath: Qt.homeDir + "/.config/quickshell/scripts/"

    ListModel { id: chatModel }

    ColumnLayout {
        anchors.fill: parent
        spacing: contentPadding
        anchors.margins: contentPadding

        // --- Title ---
        Text {
            text: "AI Chat"
            font.bold: true
            font.pointSize: 16
            color: "black"
        }

        // --- Chat view ---
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: chatList
                model: chatModel
                delegate: Text {
                    text: message
                    wrapMode: Text.Wrap
                    width: parent.width
                }
                clip: true
            }
        }

        // --- Input row ---
        RowLayout {
            Layout.fillWidth: true
            spacing: 5

            // AI selector
            ComboBox {
                id: aiSelector
                model: ["deepseek-r1:8b", "gemma3:4b"]
                currentIndex: -1
                onCurrentTextChanged: {
                    if (!currentText || currentText === "None") {
                        root.selectedAI = "None"
                        sendButton.enabled = false
                    } else {
                        root.selectedAI = currentText
                        sendButton.enabled = true
                        chatModel.clear()
                        root.aiProcess.command = ["python3", root.scriptsPath + "ai_backend.py", "select_ai", root.selectedAI]
                        root.aiProcess.running = true
                    }
                }
            }

            // User input
            TextField {
                id: userInput
                Layout.fillWidth: true
                placeholderText: "Type your query..."
                enabled: sendButton.enabled
                onAccepted: sendButton.clicked()
            }

            // Send button
            Button {
                id: sendButton
                text: "Send"
                enabled: false
                onClicked: {
                    if (!userInput.text.trim() || root.selectedAI === "None") return;

                    let message = userInput.text.trim()
                    root.receivedQuery = message

                    chatModel.append({message: root.username + ": " + message})
                    chatList.positionViewAtEnd()

                    root.aiProcess.command = ["python3", root.scriptsPath + "ai_backend.py", root.selectedAI, message]
                    root.aiProcess.running = true

                    console.log("Selected AI:", root.selectedAI)
                    console.log("Processing query:", message)

                    userInput.text = ""
                }
            }

            // New Chat
            Button {
                text: "New Chat"
                onClicked: {
                    chatModel.clear()
                    root.aiProcess.command = ["python3", root.scriptsPath + "ai_backend.py", root.selectedAI, "--new"]
                    root.aiProcess.running = true
                }
            }

            // Delete Chat
            Button {
                text: "Delete Chat"
                onClicked: {
                    root.aiProcess.command = ["python3", root.scriptsPath + "ai_delete_chat.py", root.chatDir]
                    root.aiProcess.running = true
                    chatModel.clear()
                }
            }
        }
    }

    // --- AI Process ---
    Process {
        id: aiProcess
        stdout: SplitParser {
            onRead: (data) => {
                if (data.trim() !== "") {
                    let lines = data.split("\n")
                    lines.forEach(line => {
                        if (line.trim()) {
                            line = line.replace(/^USER:/, root.username + ":")
                            line = line.replace(/^AI:/, root.selectedAI + ":")
                            chatModel.append({message: line})
                        }
                    })
                    chatList.positionViewAtEnd()
                }
            }
        }

        onExited: (exitCode, exitStatus) => {
            console.log("AI process finished with exit code:", exitCode)
            running = false
        }
    }

    // --- IPC Handler ---
    IpcHandler {
        target: "ai"

        function sendQuery(query) {
            let q = query === null || query === undefined ? "" : String(query)
            if (q && root.selectedAI !== "None") {
                chatModel.append({message: root.username + ": " + q})
                chatList.positionViewAtEnd()

                root.aiProcess.command = ["python3", root.scriptsPath + "ai_backend.py", root.selectedAI, q]
                root.aiProcess.running = true
            }
        }
    }
}
