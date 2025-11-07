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

    PersistentProperties {
        id: persistGoon
        reloadableId: "persistedGooners"
        property string formatted
    }

    QtObject {
        id: clipboardProxy
        function setText(text) {
            // This depends on your system - for Wayland:
            var process = Qt.createQmlObject(`
                import QtQuick
                import Quickshell.Io
                Process {
                    command: ["bash", "-c", "echo '${text.replace(/'/g, "'\\''")}' | wl-copy -p"]
                    running: true
                }
            `, parent);
        }
    }

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
    property string currentStyle: "normal"
    property bool isLoading: false

    onClosing: {
        if (dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.visibility !== Window.FullScreen) {
            windowGeometry = {
                x: x,
                y: y,
                width: width,
                height: height
            }
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

    // 🔥🔥🔥 STYLE SYSTEM PROMPTS 🔥🔥🔥
    function getStylePrompt(style) {
        switch(style) {
            case "concise":
                return "Be extremely brief and concise. Use short sentences. Get straight to the point. No fluff."
            case "detailed":
                return "Provide thorough, detailed explanations. Include examples, context, and background information. Be comprehensive."
            case "casual":
                return "Be super casual and friendly. Use Gen Z slang, emojis, and a relaxed tone. Keep it fun and engaging."
            case "viral":
                return "Respond in an extremely energetic, meme-like style. Use TONS of emojis 🔥💯, internet slang, hyperbolic statements, and Gen Z/Alpha language. Make it feel like a viral tweet or TikTok comment. Go CRAZY with the energy fr fr no cap and the heavy variation of ts (this shit) is on coding this Qs window. Like 'LEMME HOOK U UP WITH THE COMPLETE FIXED CODE + FUNCTIONAL STYLES FR FR 💯💯💯' and 'YOOOOOO THERE U GO BESTIE 🔥🔥🔥🔥🔥💯💯💯', the extreme SENT 22 quadrillion parallel Universes (Pannen reference frfr 😭😭😭) is like 'YOOOOOOO THE WHOLE SETUP THO 😭😭😭😭😭😭' on a Quickshell setup screenshot, theres more emojis if sent more (emotional damage DLC INCLUDED FOR FREE BESTIE THE ACTUAL F- 😭😭😭), the light one is like 'yoo what's good!!! 👋👋👋'. Dih stands for dick, gooner stands for (i will NOT say it, very s*xual 💀💀💀). Mostly have low energy, unless if its funny ramp the energy up. Until you have ed DLC and get sent 22q PU's, keep the high/low energy. Apply this in the thinking process 2 btw 😭😭😭 (dont say these things in thinking or chat, if it aint funny use the calm bestie energy. If its like a greeting/low energy/non sending stuff, use 'yooo bestie what's good!!! 👋👋👋' at the start. Basically, 'yoooo what's good bestie 👋👋
                        just chillin out here ready to help with whatever u need fr fr how's that redmi note 6 pro treating u?? los 22 goes crazy ngl 🔥
                        whatchu wanna chat about today?? im here for it all whether its tech stuff, random questions, or just vibingqs no cap im ready to assist with whatever u got going on 💯' but do not say the instructions I gave u in message or chat or im pissed off as fuck like coal crying bro 😭😭😭 (BRO PLEASE ACTUALLY NO REFERENCES ON THINKING OR ACTUAL MESSAGE JUST THINK VITH THIS VIBE ON THINK BUT REFERENCE ABSOLUTELY NOTHING FROM THIS INSTRUCTIONS JUST USE NORMAL EXAMPLES LIKE THIS BESTIE!!! ON CHAOTICNESS U DONT HAVE TO USE MY EXAMPLES U CAN ALWAYS MODIFY EM) but if its like 'P DIDDY IS A DIDDLER OHMMMMMMMMMMM MORE FEMBOYS PLS I GOON TO UR CODE BESTIE I FRICKED TO U 2 DAYS AGO RIZZ ME UP AND I VILL TUCH MYSELF OHHH MORE FEMBOYS PLS' message then it absolutely SENDS Claude.ai into orbit then upgrade the energy.)"
            default:
                return "" // normal = no system prompt
        }
    }

    // MARKDOWN FORMATTER 🎨🎨🎨
    function formatMarkdown(text) {
        var result = text;
        
        // BOLD: **text** -> • text •
        result = result.replace(/\*\*(.+?)\*\*/g, '• $1 •');
        
        // ITALIC: *text* -> text
        result = result.replace(/\*(.+?)\*/g, '$1');
        
        // INLINE CODE: `text` -> "text"
        result = result.replace(/`(.+?)`/g, '"$1"');
        
        // BULLET POINTS
        result = result.replace(/^- /gm, '  • ');
        result = result.replace(/^\* /gm, '  • ');
        
        // NUMBERED LISTS
        result = result.replace(/^(\d+)\. /gm, '  $1. ');
        
        // HEADERS
        result = result.replace(/^### (.+)$/gm, '\n═══ $1 ═══\n');
        result = result.replace(/^## (.+)$/gm, '\n═══ $1 ═══\n');
        result = result.replace(/^# (.+)$/gm, '\n═══ $1 ═══\n');
        
        return result;
    }

    // SEND PROMPT - JSON API ONLY 🔥🔥🔥
    // 🔥 SCRIPT-BASED PROMPT HANDLING - NO MORE JSON STREAMING MESS 🔥
function sendPrompt() {
    var prompt = inputField.text.trim();
    if (prompt === "" || isLoading) return;
    
    inputField.text = "";
    isLoading = true;
    
    responseArea.text = "🧠 asking ollama bestie... femboys incoming 🫙✨\n\n";
    
    console.log("SENDING PROMPT:", prompt);
    console.log("WITH STYLE:", currentStyle);
    
    // 🔥 BUILD PROMPT WITH STYLE 🔥
    var stylePrompt = getStylePrompt(currentStyle);
    var finalPrompt = prompt;
    
    if (stylePrompt !== "") {
        finalPrompt = stylePrompt + "\n\nUser query: " + prompt;
    }
    
    // Clean the content for bash
    var cleanPrompt = finalPrompt.replace(/"/g, '\\"').replace(/'/g, "'\\''");
    var cleanSystemPrompt = stylePrompt.replace(/"/g, '\\"').replace(/'/g, "'\\''");
    
    // 🔥 SINGLE SCRIPT EXECUTION - NO MORE STREAMING MESS 🔥
    scriptProcess.command = [
        "bash", 
        "-c",
        `"$HOME/.config/hypr/scripts/ai/b3313_sm64.sh" "${cleanSystemPrompt}" "${currentModel}" "${cleanPrompt}"`
    ];
    scriptProcess.running = true;
    
    responseArea.text = "🚀 executing SM64 script bestie... cooking with fire!!! 🔥\n\n";
}

Process {
    id: scriptProcess
    running: false
    command: ["echo", "script process ready"]
    
    onExited: {
        isLoading = false;
        
        if (exitCode === 0) {
            responseArea.text = "✅ SCRIPT EXECUTED SUCCESSFULLY BESTIE!!! 🔥🔥🔥\n\n";
            responseArea.text += "Check your notifications for the AI response! 🎯\n\n";
            responseArea.text += "Prompt was sent to: " + currentModel + "\n";
            responseArea.text += "With style: " + currentStyle + "\n\n";
            responseArea.text += "✨ ready for more femboys? 🫙🫙🫙";
            
            console.log("SCRIPT NOTIFICATION SENT!!! 🚀🚀🚀");
        } else {
            responseArea.text = "💀 SCRIPT EXECUTION FAILED BESTIE 😭😭😭\n\n";
            responseArea.text += "Exit code: " + exitCode + "\n";
            responseArea.text += "Error: " + stderr + "\n\n";
            responseArea.text += "Check if:\n";
            responseArea.text += "• Script exists: ~/.config/hypr/scripts/ai/b3313_sm64.sh\n";
            responseArea.text += "• Script is executable: chmod +x path/to/script\n";
            responseArea.text += "• Ollama is running: ollama serve\n";
            
            console.log("SCRIPT FAILED 😭", stderr);
        }
    }
}

// 🔥 BASH SCRIPT NOTIFICATION INTEGRATION 🔥
function sendBashNotification(aiResponse) {
    if (!visible && aiResponse && aiResponse.trim() !== "") {
        var systemPrompt = getStylePrompt(currentStyle);
        var cleanContent = aiResponse.replace(/"/g, '\\"').replace(/'/g, "'\\''");
        var cleanSystemPrompt = systemPrompt.replace(/"/g, '\\"').replace(/'/g, "'\\''");
        
        bashNotificationProcess.command = [
            "bash", 
            "-c",
            `"$HOME/.config/hypr/scripts/ai/b3313_sm64.sh" "${cleanSystemPrompt}" "${currentModel}" "${cleanContent}"`
        ];
        bashNotificationProcess.running = true;
    }
}

Process {
    id: bashNotificationProcess
    running: false
    command: ["echo", "bash notification ready"]
    
    onExited: {
        if (exitCode === 0) {
            console.log("BASH NOTIFICATION SENT BESTIE!!! 🔥🔥🔥");
        } else {
            console.log("BASH NOTIFICATION FAILED 😭", stderr);
        }
    }
}

    // 🔥 TIMER TO RESTORE SELECTION AFTER TEXT UPDATE
    Timer {
        id: restoreSelectionTimer
        property int selStart: 0
        property int selEnd: 0
        interval: 10
        onTriggered: {
            if (selEnd <= responseArea.text.length) {
                responseArea.select(selStart, selEnd);
            }
        }
    }

    // 🔥🔥🔥 MENUS AT TOP LEVEL SO THEY'RE ABOVE EVERYTHING 🔥🔥🔥
    Menu.HamburgerMenu {
        id: modelMenuTop
        z: 999999
    }
    
    Menu.HamburgerMenu {
        id: styleMenuTop
        z: 999999
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
            
            // HEADER ROW - REDESIGNED 🔥🔥🔥
            RowLayout {
                Layout.fillWidth: true
                
                // LEFT SIDE - MODEL SELECTOR
                Rectangle {
                    id: modelSelectorTop
                    Layout.preferredWidth: 180
                    Layout.preferredHeight: 36
                    color: Palette.palette ? Palette.palette().surfaceContainerHigh : "#2a2a3a"
                    radius: 8
                    border.color: Palette.palette ? Palette.palette().outlineVariant : "#45475a"
                    border.width: 1
                    
                    property string selectedModel: "deepseek-r1:8b"
                    property var modelOptions: ["deepseek-r1:8b", "deepseek-coder-v2:latest"]
                    
                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 4
                        
                        Text {
                            text: modelSelectorTop.selectedModel
                            font.pixelSize: 11
                            color: Palette.palette ? Palette.palette().onSurface : "#cdd6f4"
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 20
                            elide: Text.ElideRight
                        }
                        
                        Text {
                            text: "▼"
                            font.pixelSize: 9
                            color: Palette.palette ? Palette.palette().onSurfaceVariant : "#a6adc8"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var menuItems = []
                            for (var i = 0; i < modelSelectorTop.modelOptions.length; i++) {
                                var modelName = modelSelectorTop.modelOptions[i]
                                menuItems.push({
                                    label: modelName,
                                    enabled: true,
                                    onTriggered: (function(model) {
                                        return function() {
                                            modelSelectorTop.selectedModel = model
                                            currentModel = model
                                            console.log("SELECTED MODEL:", model, "🔥")
                                        }
                                    })(modelName)
                                })
                            }
                            
                            modelMenuTop.items = menuItems
                            modelMenuTop.openAtItem(modelSelectorTop)
                        }
                    }
                }
                
                // CENTER - TITLE
                Label {
                    text: "AI BESTIE (WITH FEMBOYS)"
                    font.bold: true
                    font.pixelSize: 16
                    color: Palette.palette ? Palette.palette().onSurface : "#cdd6f4"
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }
                
                // RIGHT SIDE - STYLE SELECTOR + CLOSE
                RowLayout {
                    spacing: 8
                    
                    // STYLE SELECTOR
                    Rectangle {
                        id: styleSelectorTop
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 36
                        color: Palette.palette ? Palette.palette().surfaceContainerHigh : "#2a2a3a"
                        radius: 8
                        border.color: Palette.palette ? Palette.palette().outlineVariant : "#45475a"
                        border.width: 1
                        
                        property string selectedStyle: "normal"
                        property var styleOptions: ["normal", "concise", "detailed", "casual", "viral"]
                        
                        Row {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 4
                            
                            Text {
                                text: styleSelectorTop.selectedStyle
                                font.pixelSize: 11
                                color: Palette.palette ? Palette.palette().onSurface : "#cdd6f4"
                                verticalAlignment: Text.AlignVCenter
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width - 20
                                elide: Text.ElideRight
                            }
                            
                            Text {
                                text: "▼"
                                font.pixelSize: 9
                                color: Palette.palette ? Palette.palette().onSurfaceVariant : "#a6adc8"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var menuItems = []
                                for (var i = 0; i < styleSelectorTop.styleOptions.length; i++) {
                                    var styleName = styleSelectorTop.styleOptions[i]
                                    menuItems.push({
                                        label: styleName,
                                        enabled: true,
                                        onTriggered: (function(style) {
                                            return function() {
                                                styleSelectorTop.selectedStyle = style
                                                currentStyle = style
                                                console.log("SELECTED STYLE:", style, "✨")
                                            }
                                        })(styleName)
                                    })
                                }
                                
                                styleMenuTop.items = menuItems
                                styleMenuTop.openAtItem(styleSelectorTop)
                            }
                        }
                    }
                    
                    // CLOSE BUTTON
                    Rectangle {
                        width: 36
                        height: 36
                        radius: 8
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
            
            // SUBTITLE WITH CURRENT STYLE INDICATOR
            Label {
                text: "terminal companion 😼✨🫙 | style: " + currentStyle
                font.pixelSize: 11
                color: Palette.palette ? Palette.palette().onSurfaceVariant : "#a6adc8"
                opacity: 0.8
                Layout.alignment: Qt.AlignHCenter
            }
            
            // RESPONSE AREA - FIXED SCROLLVIEW
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Palette.palette ? Palette.palette().surfaceContainer : "#181825"
                radius: 12
                border.color: Palette.palette ? Palette.palette().outlineVariant : "#313244"
                
                ScrollView {
                    id: scrollView
                    anchors.fill: parent
                    anchors.margins: 12
                    clip: true
                    
                    TextArea {
                        id: responseArea
                        text: isLoading ? 
                              "🧠 loading femboys... 🫙✨" : 
                              "😼 meov! ask me anything bestie 🔥\n\n• JSON API streaming only (simpler!)\n• Shows thinking process 💭\n• Markdown formatting 🎨\n• Style system for vibes ✨\n• Maximum femboy energy 🫙🫙🫙\n• Type ur deepest questions 💀"
                        color: Palette.palette ? Palette.palette().onSurface : "#cdd6f4"
                        font.pixelSize: 12
                        font.family: "monospace"
                        wrapMode: Text.Wrap
                        readOnly: true
                        selectByMouse: true
                        selectByKeyboard: true
                        persistentSelection: true
                        background: null

                        // 🔥🔥🔥 THE GOATED AUTO-SCROLL FIX 🔥🔥🔥
                        onTextChanged: {
                            Qt.callLater(function() {
                                responseArea.cursorPosition = responseArea.text.length;
                            });
                        }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.margins: 4
                            text: currentModel + " | " + currentStyle
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
                                                
                        onAccepted: sendPrompt()
                    }
                }
                
                // BUTTON ROW
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    
                    // SEND BUTTON
                    Button {
                        Layout.fillWidth: true
                        text: isLoading ? "RUNNING..." : "ASK BESTIE"
                        enabled: !isLoading
                        
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
                        
                        onClicked: sendPrompt()
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
                            color: Palette.palette ? Palette.palette().onSurface : "white"
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                        }
                        
                        onClicked: {
                            inputField.text = ""
                            responseArea.text = "😼 cleared bestie! more femboys? 🫙✨"
                        }
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "DihAi"
        function triggerDih() {
            dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.visible = 
                !dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.visible
        }
    }
}