import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell
import Quickshell.Io
import QtCore
import "../../resources/colors.js" as Palette
import "../../resources/components/Menu" as Menu
import "../../resources/components/actions" as Actions

ApplicationWindow {
    id: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling
    width: Screen.width
    height: Screen.height
    visible: false
    title: "I Have Tons Of Gooners On My Code 😍"
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    // KEEP THAT 12 INCH DINGALING AND GOONER!!! 🫙🫙🫙 
    property var windowGeometry: ({
        x: Screen.width / 2 - 450,
        y: Screen.height / 2 - 300,
        width: 900,
        height: 600
    })

    // PROPERTIES
    property string ollamaUrl: "http://localhost:11434/api/generate"
    property string currentModel: "deepseek-r1:8b"
    property bool isLoading: false
    property var activeProcess: null


    onClosing: {
        if (dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.visibility !== Window.FullScreen) {
            windowGeometry = {
                x: x,
                y: y,
                width: width,
                height: height
            }
        }
        // KILL ANY RUNNING PROCESS
        if (activeProcess) {
            activeProcess.running = false;  // 🔥 FIXED: USE running = false INSTEAD OF .kill()
            activeProcess = null;
        }
    }

    onVisibleChanged: {
        if (visible) {
            x = windowGeometry.x
            y = windowGeometry.y
            width = windowGeometry.width
            height = windowGeometry.height
        }
    }

    // OLLAMA RUN EXECUTION FUNCTION 🔥
    function sendPrompt() {
        var prompt = inputField.text.trim();
        if (prompt === "" || dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading) return;
        
        inputField.text = "";
        dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading = true;
        responseArea.text = "🧠 executing: ollama run " + currentModel + " \"" + prompt + "\"\n\n";
        
        // KILL EXISTING PROCESS
        if (activeProcess) {
            activeProcess.running = false;  // 🔥 FIXED: USE running = false INSTEAD OF .kill()
            activeProcess = null;
        }
        
        // CREATE PROCESS USING SHELL COMMAND (BEST WORKAROUND) 😼
        var shellCommand = "ollama run " + currentModel + " \"" + prompt.replace(/"/g, '\\"') + "\"";
        
        activeProcess = Qt.createQmlObject(`
            import QtCore
            import Quickshell.Io
            Process {
                id: ollamaProcess
                running: true
                command: [ "sh", "-c", "${shellCommand.replace(/"/g, '\\"').replace(/\n/g, ' ')}" ]

                stdout: StdioCollector {
                    onStreamFinished: {
                        console.log("OLLAMA STREAM FINISHED");
                        dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading = false;
                    }
                }

                onExited: function() {
                    console.log("OLLAMA EXITED WITH CODE:", ollamaProcess.exitCode);
                    dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading = false;
                    
                    if (ollamaProcess.exitCode >= 1) {
                        var error = "";
                        if (ollamaProcess.stderr) {
                            error = String(ollamaProcess.stderr.read());
                        }
                        console.log("OLLAMA STDERR:", error);
                        if (error) {
                            responseArea.text += "\\n💀 ERROR: " + error;
                        }
                        if (error.includes("not running") || error.includes("connection refused") || error.includes("Error")) {
                            responseArea.text += "\\n\\n💀 Ollama not running, starting fallback...";
                            dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.fallbackToJsonApi("${prompt.replace(/"/g, '\\"')}");
                        }    
                    }
                    if (ollamaProcess.exitCode === 0) {
                        responseArea.text += "\\n\\n😼 OLLAMA FINISHED! MEOV AGAIN? ✨";
                    } else {
                        responseArea.text += "\\n\\n💀 OLLAMA EXITED WITH CODE: " + ollamaProcess.exitCode;
                        if (!responseArea.text.includes("falling back to API")) {
                            dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.fallbackToJsonApi("${prompt.replace(/"/g, '\\"')}");
                        }
                    }
                }
            }
        `, dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling);    
        }

    // FALLBACK TO JSON API
    function fallbackToJsonApi(prompt) {
        console.log("🔄 FALLING BACK TO JSON API...");
        dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading = true;
        responseArea.text += "\n\n🧠 Trying JSON API fallback...\n";
        
        var xhr = new XMLHttpRequest();
        xhr.open("POST", ollamaUrl);
        xhr.setRequestHeader("Content-Type", "application/json");
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading = false;
                
                if (xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText);
                        responseArea.text += "😼 JSON API RESPONSE:\n\n" + response.response;
                    } catch (e) {
                        responseArea.text += "💀 JSON PARSE ERROR: " + e;
                    }
                } else {
                    responseArea.text += "💀 JSON API FAILED TOO! Status: " + xhr.status + "\n\n";
                    responseArea.text += "Make sure ollama is running:\n";
                    responseArea.text += "• ollama serve\n";
                    responseArea.text += "• ollama pull " + currentModel + "\n";
                    responseArea.text += "• Check port 11434 😴";
                }
            }
        };
        
        xhr.onerror = function() {
            dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading = false;
            responseArea.text += "💀 NETWORK ERROR - Can't connect to Ollama";
        };
        
        var requestData = {
            model: currentModel,
            prompt: prompt,
            stream: false
        };
        
        xhr.send(JSON.stringify(requestData));
    }

    Rectangle {
        id: superIdolGoonDihYumYUmDoUrMomFRICKKKKK
        width: parent.width
        height: parent.height
        radius: 20
        color: Palette.palette ? Palette.palette().background : "#1e1e2e"
        border.color: Palette.palette ? Palette.palette().outlineVariant : "#45475a"
        border.width: 2
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12
            
            // HEADER ROW
            RowLayout {
                Layout.fillWidth: true
                
                // MATERIAL ICON
                Rectangle {
                    width: 36
                    height: 36
                    radius: 10
                    color: Palette.palette ? Palette.palette().primary : "#ff6b9d"
                    
                    Label {
                        anchors.centerIn: parent
                        text: "neurology"
                        font.pixelSize: 18
                        font.family: "Material Symbols Outlined"
                        color: Palette.palette ? Palette.palette().onPrimary : "white"
                    }
                }
                
                // TITLE - CENTERED
                Label {
                    text: "AI BESTIE"
                    font.bold: true
                    font.pixelSize: 16
                    color: Palette.palette ? Palette.palette().onSurface : "#cdd6f4"
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }
                
                // CONTROLS
                RowLayout {
                    spacing: 6
                    
                    // CLOSE BUTTON
                    Rectangle {
                        width: 24
                        height: 24
                        radius: 6
                        color: "transparent"
                        border.color: Palette.palette ? Palette.palette().outline : "#585b70"
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.close()
                        }
                        
                        Label {
                            anchors.centerIn: parent
                            text: "×"
                            color: Palette.palette ? Palette.palette().onSurface : "#a6adc8"
                            font.pixelSize: 16
                            font.bold: true
                        }
                    }
                }
            }
            
            // SUBTITLE
            Label {
                text: "terminal companion 😼✨"
                font.pixelSize: 11
                color: Palette.palette ? Palette.palette().onSurfaceVariant : "#a6adc8"
                opacity: 0.8
                Layout.alignment: Qt.AlignHCenter
            }
            
            // RESPONSE AREA
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Palette.palette ? Palette.palette().surfaceContainer : "#181825"
                radius: 12
                border.color: Palette.palette ? Palette.palette().outlineVariant : "#313244"
                
                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 12
                    clip: true
                    
                    TextArea {
                        id: responseArea
                        text: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading ? 
                              "🧠 preparing to execute ollama run... ✨" : 
                              "😼 meov! ask me anything bestie 🔥\n\n• Uses 'ollama run' directly for raw output\n• Auto-fallback to JSON API if needed\n• Drag to move, Esc to close\n• Type ur deepest questions 💀"
                        color: Palette.palette ? Palette.palette().onSurface : "#cdd6f4"
                        font.pixelSize: 12
                        wrapMode: Text.Wrap
                        readOnly: true
                        selectByMouse: true
                        background: null
                        
                        Text {
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.margins: 4
                            text: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.currentModel
                            color: Palette.palette ? Palette.palette().outline : "#585b70"
                            font.pixelSize: 10
                            font.italic: true
                        }
                    }
                }
            }
            
            // INPUT SECTION
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 8
                
                // PROMPT INPUT
                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    radius: 10
                    color: Palette.palette ? Palette.palette().surfaceContainerHigh : "#181825"
                    border.color: inputField.activeFocus ? 
                                 (Palette.palette ? Palette.palette().primary : "#ff6b9d") : 
                                 (Palette.palette ? Palette.palette().outlineVariant : "#45475a")
                    
                    TextInput {
                        id: inputField
                        anchors.fill: parent
                        anchors.margins: 12
                        color: Palette.palette ? Palette.palette().onSurface : "#cdd6f4"
                        font.pixelSize: 12
                        verticalAlignment: TextInput.AlignVCenter
                        selectByMouse: true
                        focus: true
                                                
                        onAccepted: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.sendPrompt()
                    }
                }
                
                // BUTTON ROW - WITH DIH COMBOBOX ON THE LEFT 🔥🔥🔥
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    
                    // DIH COMBOBOX - POINTING UP FROM SEND BUTTON'S LEFT 😳😳😳
                    Rectangle {
                        id: colorComboContainer
                        Layout.preferredWidth: 140
                        Layout.preferredHeight: 40
                        color: Palette.palette ? Palette.palette().surfaceContainerHigh : "#2a2a3a"
                        radius: 6
                        border.color: Palette.palette ? Palette.palette().outlineVariant : "#45475a"
                        border.width: 1
                        
                        // THE CUSTOM HAMBURGER MENU COMBOBOX REPLACEMENT 🔥🔥🔥
                        property string selectedColor: "deepseek-r1:8b"
                        property var colorOptions: ["deepseek-r1:8b", "llama3.1:8b"]
                        
                        // THE DISPLAY TEXT AND ARROW 🗣️🗣️🗣️
                        Row {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 4
                            
                            Text {
                                id: colorCombo
                                text: colorComboContainer.selectedColor
                                font.pixelSize: 12
                                color: Palette.palette ? Palette.palette().onSurface : "#cdd6f4"
                                verticalAlignment: Text.AlignVCenter
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width - 20
                                elide: Text.ElideRight
                                
                                property string displayText: text
                            }
                            
                            Text {
                                text: "▲"
                                font.pixelSize: 10
                                color: Palette.palette ? Palette.palette().onSurfaceVariant : "#a6adc8"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        
                        // CLICK TO OPEN THE HAMBURGERMENU 🍔🍔🍔
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var menuItems = []
                                for (var i = 0; i < colorComboContainer.colorOptions.length; i++) {
                                    var modelName = colorComboContainer.colorOptions[i]
                                    menuItems.push({
                                        label: modelName,
                                        enabled: true,
                                        onTriggered: (function(model) {
                                            return function() {
                                                colorComboContainer.selectedColor = model
                                                dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.currentModel = model
                                                console.log("SELECTED MODEL:", model, "🔥")
                                            }
                                        })(modelName)
                                    })
                                }
                                
                                colorSchemeMenu.items = menuItems
                                colorSchemeMenu.openAtItem(colorComboContainer)
                            }
                        }
                        
                        // THE HAMBURGERMENU OVERLAY
                        Menu.HamburgerMenu {
                            id: colorSchemeMenu
                            anchors.fill: parent
                            minWidth: 140
                            z: 99999
                        }
                    }
                    
                    // SEND BUTTON
                    Button {
                        Layout.fillWidth: true
                        text: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading ? 
                              "🔄 RUNNING OLLAMA..." : "🚀 EXECUTE OLLAMA RUN"
                        enabled: !dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.isLoading
                        
                        background: Rectangle {
                            radius: 8
                            color: parent.enabled ? 
                                   (Palette.palette ? Palette.palette().primary : "#ff6b9d") : 
                                   (Palette.palette ? Palette.palette().surfaceVariant : "#585b70")
                        }
                        
                        contentItem: Label {
                            text: parent.text
                            color: Palette.palette ? Palette.palette().surface : "white"
                            font.pixelSize: 12
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                        
                        onClicked: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.sendPrompt()
                    }
                    
                    // CLEAR BUTTON
                    Button {
                        text: "🗑️"
                        Layout.preferredWidth: 40
                        
                        background: Rectangle {
                            radius: 8
                            color: Palette.palette ? Palette.palette().surfaceVariant : "#585b70"
                        }
                        
                        contentItem: Label {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                        }
                        
                        onClicked: {
                            inputField.text = ""
                            responseArea.text = "😼 conversation cleared bestie! meov again? ✨"
                        }
                    }
                }
            }
        }
    }
    
    // KEYBOARD SHORTCUTS
    Shortcut {
        sequence: "Ctrl+L"
        onActivated: inputField.text = ""
    }
    
    Shortcut {
        sequence: "Escape"
        onActivated: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.close()
    }

    IpcHandler {
        target: "DihAi"
        function triggerDih() {
            dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.visible = 
                !dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.visible
        }
    }
}