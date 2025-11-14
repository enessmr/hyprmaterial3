// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell
import Quickshell.Io
import QtCore
import qs.common
import "../../resources/components/Menu" as Menu
import "../../resources/components/actions" as Actions

ApplicationWindow {
    id: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling
    width: Screen.width
    height: Screen.height
    visible: false
    title: "HyprYoshi3 Gooner Artificial Unintelligence 💚🦕😍💦🥵"
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    PersistentProperties {
        id: persistGoon
        reloadableId: "persistedGooners"
        property string formatted
    }

    QtObject {
        id: dijProxy
        function setText(text) {
            // THE GOOBER SPAVNED THE GOON PROXY 😍💦🥵😍💦🥵😍💦🥵😍💦🥵😍💦🥵😍💦🥵😍💦🥵
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

    // THE DIH FOR THE GOOBER'S FRICKER GOONER 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍
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

    // STYLE GOON DIJ PROMPTS 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍
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
                return "" // GOOBER = NO STYLE DIH BESTIE 😭😭😭😭😭😭😭😭😭😭
        }
    }

    // MARKDOWN GOONER 🎨🎨🎨
    function formatMarkdown(text) {
        var result = text;
        
        // FAT GOONER 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍 **text** -> • text •
        result = result.replace(/\*\*(.+?)\*\*/g, '• $1 •');
        
        // PIZZA TOVER GOONER😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍 *text* -> text
        result = result.replace(/\*(.+?)\*/g, '$1');
        
        // INLINE GOOBER DIH DIJ SATAN GOONER 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍 `text` -> "text"
        result = result.replace(/`(.+?)`/g, '"$1"');
        
        // 39MM AK47 GOONER 🔫🔫🔫🥵🥵🥵💦💦💦
        result = result.replace(/^- /gm, '  • ');
        result = result.replace(/^\* /gm, '  • ');
        
        // NUMBERED DIHS 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦
        result = result.replace(/^(\d+)\. /gm, '  $1. ');
        
        // GIT COMMITS GOONING TO HEAD COMMITS 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦
        result = result.replace(/^### (.+)$/gm, '\n═══ $1 ═══\n');
        result = result.replace(/^## (.+)$/gm, '\n═══ $1 ═══\n');
        result = result.replace(/^# (.+)$/gm, '\n═══ $1 ═══\n');
        
        return result;
    }

    // FRICK TO GOONER - DIJ BESTIE BEEP BOOP IM A FICTIONAL TALKING DIH 🤖🤖🤖🤖
function sendPrompt() {
    var prompt = inputField.text.trim();
    if (prompt === "" || isLoading) return;
    
    inputField.text = "";
    isLoading = true;
    
    responseArea.text = "🧠 asking ollama bestie... femboys incoming 🫙✨\n\n";
    
    console.log("SENDING PROMPT:", prompt);
    console.log("WITH STYLE:", currentStyle);
    
    // COOK DIH VITH HOMEMADE SPECIAL GOON JARS 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭
    var stylePrompt = getStylePrompt(currentStyle);
    var finalPrompt = prompt;
    
    if (stylePrompt !== "") {
        finalPrompt = stylePrompt + "\n\nUser dih 😍😍😍 " + prompt;
    }
    
    // CLEAN THE DIJ FOR BASH TO GOON AND FRICK TO IT 😍😍😍😍😍😍😍😍😍😍😍
    var cleanPrompt = finalPrompt.replace(/"/g, '\\"').replace(/'/g, "'\\''");
    var cleanSystemPrompt = stylePrompt.replace(/"/g, '\\"').replace(/'/g, "'\\''");
    
    // SINGLE DIJ EXEC - FOR BASH TO GOON AND FRICK TO IT AND THE JSON NOT 2 GET GOOBERED AGAIN 😍😍😍😍😍😍😍😍😍😍😍
    scriptDijGoon.command = [
        "bash", 
        "-c",
        `"$HOME/.config/hypr/scripts/ai/b3313_sm64.sh" "${cleanSystemPrompt}" "${currentModel}" "${cleanPrompt}"`
    ];
    scriptDijGoon.running = true;
    
    responseArea.text = "🚀 executing beta mario 64 script bestie... femboys multiplying 🫙✨\n\n";
}

Process {
    id: scriptDijGoon
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
            
            console.log("NOOOOOOOOOO THE GOOOBER FELL INTO THE GOOBER POOP PIT OHMMMM NOOOOOOOOOOOOOOOOOO PLEASE BRO NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵", stderr);
        }
    }
}

// GOONER SCRIPT INT DIH BESTIE OHM DIJJ DIJJ DIJJJJJ L'KASJFIIAKLJ;D 🥵🥵🥵
function sendDihNotification(aiResponse) {
    if (!visible && aiResponse && aiResponse.trim() !== "") {
        var systemPrompt = getStylePrompt(currentStyle);
        var cleanContent = aiResponse.replace(/"/g, '\\"').replace(/'/g, "'\\''");
        var cleanSystemPrompt = systemPrompt.replace(/"/g, '\\"').replace(/'/g, "'\\''");
        
        goonerDihProcess.command = [
            "bash", 
            "-c",
            `"$HOME/.config/hypr/scripts/ai/b3313_sm64.sh" "${cleanSystemPrompt}" "${currentModel}" "${cleanContent}"`
        ];
        goonerDihProcess.running = true;
    }
}

Process {
    id: goonerDihProcess
    running: false
    command: ["echo", "bash notification ready"]
    
    onExited: {
        if (exitCode === 0) {
            console.log("BASH NOTIFICATION GOONED BESTIE!!! 🥵🥵🥵");
        } else {
            console.log("NOOOO THE BASH GOOBER FELL INTO THE GOON PIT NOOOOOOOOOOO 😭😭😭😭😭🥵🥵🥵", stderr);
        }
    }
}

    // TIMER TO GOON TO MY DIH 🥵🥵🥵
    Timer {
        id: restoreDihTimer
        property int selStart: 0
        property int selEnd: 0
        interval: 10
        onTriggered: {
            if (selEnd <= responseArea.text.length) {
                responseArea.select(selStart, selEnd);
            }
        }
    }

    // GOOBERS AND GOONERS AT TOP LEVEL SO THEY CAN TAKE A PIC OF FRICKING AND GOONING TO THERE DIJ BESTIE 😳😳😳😳😳😳😳😳😳😳😳😳
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
        color: Appearance?.m3colors?.m3background
        border.color: Appearance?.m3colors?.m3outlineVariant
        border.width: 2
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12
            
            // HEADER DIJ - I HAVE MY DIH GOONING ON MARIO KART 64 🥵🥵🥵💦💦💦
            RowLayout {
                Layout.fillWidth: true
                
                // LGOOBER DIHEFT FEMBOYS GOON BESTIE 🥵🥵🥵💦💦💦
                Rectangle {
                    id: modelSelectorTop
                    Layout.preferredWidth: 180
                    Layout.preferredHeight: 36
                    color: Appearance?.m3colors?.m3surfaceContainerHigh
                    radius: 8
                    border.color: Appearance?.m3colors?.m3outlineVariant
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
                            color: Appearance?.m3colors?.m3onSurface
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 20
                            elide: Text.ElideRight
                        }
                        
                        Text {
                            text: "▼"
                            font.pixelSize: 9
                            color: Appearance?.m3colors?.m3onSurfaceVariant
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
                
                // CGOOBER DIHTER FEMBOYS GOON BESTIE 🥵🥵🥵💦💦💦
                Label {
                    text: "AI BESTIE (WITH FEMBOYS)"
                    font.bold: true
                    font.pixelSize: 16
                    color: Appearance?.m3colors?.m3onSurface
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }
                
                // RGOOBER DIHGHT FEMBOYS GOON BESTIE 🥵🥵🥵💦💦💦
                RowLayout {
                    spacing: 8
                    
                    // DIJ SELECTER DIH BESTIE AK47 39MM ZECK FELMS OHM 🥵🥵🥵💦💦💦
                    Rectangle {
                        id: styleSelectorTop
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 36
                        color: Appearance?.m3colors?.m3surfaceContainerHigh
                        radius: 8
                        border.color: Appearance?.m3colors?.m3outlineVariant
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
                                color: Appearance?.m3colors?.m3onSurface
                                verticalAlignment: Text.AlignVCenter
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width - 20
                                elide: Text.ElideRight
                            }
                            
                            Text {
                                text: "▼"
                                font.pixelSize: 9
                                color: Appearance?.m3colors?.m3onSurfaceVariant
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
                    
                    // CGOOBER GOON DUGMESI 🥵🥵🥵💦💦💦
                    Rectangle {
                        width: 36
                        height: 36
                        radius: 8
                        color: "transparent"
                        border.color: Appearance?.m3colors?.m3outline
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dihOhmmmmmDingalingFrFrFartStationaryOhmPoopPeeFartOhmmmmDiddleMyDihGoonNoCapFrFrDingaling.close()
                        }
                        
                        Label {
                            anchors.centerIn: parent
                            text: "close"
                            font.family: "Material Symbols Outlined"
                            color: Appearance?.m3colors?.m3onSurface
                            font.pixelSize: 16
                            font.bold: true
                        }
                    }
                }
            }
            
            // SUBGOOBER VITH GOON GOOBER INDICATOR TO GOON BESTIE 🥵🥵🥵💦💦💦 
            Label {
                text: "terminal companion 😼✨🫙 | style: " + currentStyle
                font.pixelSize: 11
                color: Appearance?.m3colors?.m3onSurfaceVariant
                opacity: 0.8
                Layout.alignment: Qt.AlignHCenter
            }
            
            // RESPONSE GOON DIH BESTIE 😳😳😳😳😳😳💦💦💦💦💦💦
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Appearance?.m3colors?.m3surfaceContainer
                radius: 12
                border.color: Appearance?.m3colors?.m3outlineVariant
                
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
                        color: Appearance?.m3colors?.m3onSurface
                        font.pixelSize: 12
                        font.family: "monospace"
                        wrapMode: Text.Wrap
                        readOnly: true
                        selectByMouse: true
                        selectByKeyboard: true
                        persistentSelection: true
                        background: null

                        // DE 🐐ED GOOBER POS GOON FIX 😳😳😳😳😳😳💦💦💦💦💦💦
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
                            color: Appearance?.m3colors?.m3outline
                            font.pixelSize: 10
                            font.italic: true
                        }
                    }
                }
            }
            
            // ⌨️ GOOBER GOON SECT TO GOON 😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 8
                
                // PROMPT INPUT
                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    radius: 10
                    color: Appearance?.m3colors?.m3surfaceContainerHigh
                    border.color: inputField.activeFocus ? 
                                 (Appearance?.m3colors?.m3primary) : 
                                 (Appearance?.m3colors?.m3outlineVariant)
                    
                    TextInput {
                        id: inputField
                        anchors.fill: parent
                        anchors.margins: 12
                        color: Appearance?.m3colors?.m3onSurface
                        font.pixelSize: 12
                        verticalAlignment: TextInput.AlignVCenter
                        selectByMouse: true
                        focus: true
                                                
                        onAccepted: sendPrompt()
                    }
                }
                
                // BGOOBER GOON DIJ ROV AAAAAAA 😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦😳😳😳😳😳😳💦💦💦💦💦💦
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    
                    // SEND THE AI INTO THE GOOBER P DIDDY DIMENSION VHERE I AT 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭
                    Button {
                        Layout.fillWidth: true
                        text: isLoading ? "RUNNING..." : "ASK BESTIE"
                        enabled: !isLoading
                        
                        background: Rectangle {
                            radius: 8
                            color: parent.enabled ? 
                                   (Appearance?.m3colors?.m3primary) : 
                                   (Appearance?.m3colors?.m3surfaceVariant)
                        }
                        
                        contentItem: Label {
                            text: parent.text
                            color: Appearance?.m3colors?.m3surface
                            font.pixelSize: 12
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                        
                        onClicked: sendPrompt()
                    }
                    
                    // CLEAR THE SENDED AI INTO THAT DIMENSION NOOOO 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭
                    Button {
                        text: "delete"
                        font.family: "Material Symbols Outlined"
                        Layout.preferredWidth: 40
                        
                        background: Rectangle {
                            radius: 8
                            color: Appearance?.m3colors?.m3surfaceVariant
                        }
                        
                        contentItem: Label {
                            text: parent.text
                            color: Appearance?.m3colors?.m3onSurface
                            font.pixelSize: 20
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