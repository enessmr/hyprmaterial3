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
    color: Appearance.m3colors.m3background
    property string username: Qt.application.arguments.length > 1 ? Qt.application.arguments[1] : "user"
    property string selectedAI: "None"
    property string chatDir: Qt.homeDir + "/.local/share/hyprmaterial3/ai/chathist/"
    property real contentPadding: 8 // ADDED THIS BACK CUZ YOU COMMENTED IT OUT BUT STILL USE IT

    ListModel { id: chatModel }

    ColumnLayout {
        anchors.fill: parent
        spacing: contentPadding
        anchors.margins: contentPadding // FIXED: was using padding which doesn't exist on ColumnLayout

        // Title
        Text {
            text: "AI Chat"
            font.pixelSize: Appearance.font.pixelSize.title
            color: Appearance.colors.colOnLayer0
        }

        // Chat view
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

        // Input row
        RowLayout {
            Layout.fillWidth: true
            spacing: 5

            // AI selector dropdown
            ComboBox {
                id: aiSelector
                model: ["deepseek-r1:8b", "gemma3:4b"]
                currentIndex: -1
                onCurrentTextChanged: {
                    if (!currentText || currentText === "None") {
                        selectedAI = "None"
                        sendButton.enabled = false
                    } else {
                        selectedAI = currentText
                        sendButton.enabled = true
                        // Starting new chat when AI changes
                        chatModel.clear()
                        // FIXED: Use proper Quickshell Process API
                        aiProcess.command = ["python3", "ai_backend.py", "select_ai", selectedAI]
                        aiProcess.running = true
                    }
                }
            }

            // User input
            TextField {
                id: userInput
                Layout.fillWidth: true
                placeholderText: "Type your query..."
                enabled: sendButton.enabled
                // BONUS: Add Enter key support cuz why not
                onAccepted: sendButton.clicked()
            }

            // Send button
            Button {
                id: sendButton
                text: "Send"
                enabled: false
                onClicked: {
                    if (!userInput.text.trim() || selectedAI === "None") return;
                    chatModel.append({message: username + ": " + userInput.text})
                    chatList.positionViewAtEnd()
                    // FIXED: Proper Process usage
                    aiProcess.command = ["python3", "ai_backend.py", selectedAI, userInput.text]
                    aiProcess.running = true
                    userInput.text = ""
                }
            }

            // New Chat
            Button {
                text: "New Chat"
                onClicked: {
                    chatModel.clear()
                    // FIXED: No more fake .start() method
                    aiProcess.command = ["python3", "ai_backend.py", selectedAI, "--new"]
                    aiProcess.running = true
                }
            }

            // Delete Chat
            Button {
                text: "Delete Chat"
                onClicked: {
                    // FIXED: Use proper Process API
                    aiProcess.command = ["python3", "ai_delete_chat.py", chatDir]
                    aiProcess.running = true
                    chatModel.clear()
                }
            }
        }
    }

    Process {
        id: aiProcess
    
        // Use stdout with SplitParser - the ACTUAL Quickshell way
        stdout: SplitParser {
            onRead: (data) => {
                if (data.trim() !== "") {
                    // Replace username/AI in output if needed
                    let lines = data.split("\n")
                    lines.forEach(line => {
                        if (line.trim()) { // only add non-empty lines
                            line = line.replace(/^USER:/, username + ":")
                            line = line.replace(/^AI:/, selectedAI + ":")
                            chatModel.append({message: line})
                        }
                    })
                    chatList.positionViewAtEnd()
                }
            }
        }
    
        // Handle when the process finishes
        onExited: (exitCode, exitStatus) => {
            console.log("AI process finished with exit code:", exitCode)
            // Reset running state so we can run it again
            running = false
        }
    }

    // IPC Handler
    // IPC Handler with proper type handling
IpcHandler {
    target: "ai"
    
    // Use a property to store the query instead of passing it as a parameter
    property string receivedQuery: ""
    
    onReceivedQueryChanged: {
        if (receivedQuery && receivedQuery.trim() && selectedAI !== "None") {
            chatModel.append({message: username + ": " + receivedQuery})
            chatList.positionViewAtEnd()
            aiProcess.command = ["python3", "ai_backend.py", selectedAI, receivedQuery]
            aiProcess.running = true
            receivedQuery = "" // Reset after processing
        }
    }
    
    function toggle() {
        GlobalStates.aiOpen = !GlobalStates.aiOpen
        root.visible = GlobalStates.aiOpen
        if (GlobalStates.aiOpen) {
            root.raise()
            root.requestActivate()
        }
    }
    
    // This function will be called from IPC but doesn't take parameters
    function triggerQueryProcessing() {
        // This would need to be connected to some external data source
        // or we need to use a different approach entirely
    }
}

// Alternative approach: Use a separate JavaScript file for IPC functions
// that can handle the type conversion properly
}