// main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell.Io
import Quickshell
import "../resources/components/toggles" as Toggles
import "./"

ApplicationWindow {
    width: 600
    height: 500
    minimumWidth: 400
    minimumHeight: 300
    title: "Lemme touch you"
    id: root
    flags: Qt.Window | Qt.WindowStaysOnTopHint
    
    // Property to store window geometry
    property var windowGeometry: ({
        x: 0,
        y: 0,
        width: 600,
        height: 500
    })

    // Save geometry when window is closed
    onClosing: {
        windowGeometry = {
            x: x,
            y: y,
            width: width,
            height: height
        }
    }

    // Restore geometry when shown
    onVisibleChanged: {
        if (visible) {
            x = windowGeometry.x
            y = windowGeometry.y
            width = windowGeometry.width
            height = windowGeometry.height
        }
    }

    // BAH BAH BAH BAH BAHBAHBHAH BAH BAH (but make it visible for testing)
    visible: false

    property string selectedEmoji
    property var emojiCategories: ({})
    property var currentCategoryEmojis: []
    property string currentCategory: "mood"
    property bool jsonLoaded: false

    // YOSHI LOVE BESTIE 💚🦕
    Component.onCompleted: {
        loadEmojiData()
    }

    // PROCESS TO READ THE EMOJI JSON BESTIE!! 🔥🔥
    Process {
        id: emojiProcess
        running: true
        command: ["cat", Qt.resolvedUrl("../json/emoji.json").toString().replace("file://", "")]
        
        stdout: StdioCollector {
            id: emojiCollector
            // target: emojiProcess
            
            onStreamFinished: {
                console.log("BESTIE WE GOT THE JSON DATA!! 🔥")
                try {
                    var jsonData = JSON.parse(data)
                    root.emojiCategories = jsonData
                    root.jsonLoaded = true
                    loadCategoryEmojis("mood")
                    console.log("JSON LOADED SUCCESSFULLY!! Categories:", Object.keys(jsonData))
                } catch (e) {
                    console.log("JSON PARSE ERROR BESTIE:", e)
                    // FALLBACK TO HARDCODED EMOJIS IF JSON FAILS
                    loadFallbackEmojis()
                }
            }
            
            /* onErrorOccurred: {
                console.log("ERROR LOADING JSON FILE BESTIE, USING FALLBACK!!")
                loadFallbackEmojis()
            } */
        }
    }

    function loadEmojiData() {
        console.log("EMOJI DATA WILL LOAD AUTOMATICALLY BESTIE!! 🔥")
        // Process starts automatically when running: true
        if (root.jsonLoaded === false) {
            console.log("WAITING FOR JSON TO LOAD...")
        }
    }

    function loadFallbackEmojis() {
        console.log("USING FALLBACK EMOJIS BESTIE!!")
        root.emojiCategories = {
            "smileys-emotion": {
                "face-smiling": {
                    "grinning-face": "😀",
                    "grinning-face-with-big-eyes": "😃", 
                    "grinning-face-with-smiling-eyes": "😄",
                    "beaming-face-with-smiling-eyes": "😁",
                    "grinning-squinting-face": "😆",
                    "grinning-face-with-sweat": "😅",
                    "rolling-on-the-floor-laughing": "🤣",
                    "face-with-tears-of-joy": "😂",
                    "slightly-smiling-face": "🙂",
                    "upside-down-face": "🙃",
                    "melting-face": "🫠",
                    "winking-face": "😉",
                    "smiling-face-with-smiling-eyes": "😊",
                    "smiling-face-with-halo": "😇"
                },
                "face-affection": {
                    "smiling-face-with-hearts": "🥰",
                    "face-with-heart-eyes": "😍",
                    "star-struck": "🤩",
                    "face-blowing-kiss": "😘",
                    "kissing-face": "😗"
                }
            },
            "people-body": {
                "hand-fingers-open": {
                    "waving-hand": "👋",
                    "raised-back-of-hand": "🤚",
                    "hand-with-fingers-splayed": "🖐️",
                    "raised-hand": "✋",
                    "vulcan-salute": "🖖"
                }
            },
            "animals-nature": {
                "animal-reptile": {
                    "turtle": "🐢",
                    "lizard": "🦎", 
                    "snake": "🐍",
                    "dragon-face": "🐲",
                    "dragon": "🐉",
                    "sauropod": "🦕"  // YOSHI BESTIE!! 💚
                }
            },
            "food-drink": {
                "food-prepared": {
                    "pizza": "🍕",
                    "hamburger": "🍔",
                    "fries": "🍟",
                    "hot-dog": "🌭",
                    "taco": "🌮"
                }
            },
            "activities": {
                "event": {
                    "party-popper": "🎉",
                    "confetti-ball": "🎊",
                    "balloon": "🎈",
                    "birthday-cake": "🎂"
                }
            },
            "objects": {
                "light-video": {
                    "fire": "🔥",
                    "flashlight": "🔦",
                    "candle": "🕯️"
                }
            },
            "symbols": {
                "heart": {
                    "red-heart": "❤️",
                    "orange-heart": "🧡", 
                    "yellow-heart": "💛",
                    "green-heart": "💚", // YOSHI LOVE!! 🦕
                    "blue-heart": "💙",
                    "purple-heart": "💜",
                    "brown-heart": "🤎",
                    "black-heart": "🖤",
                    "white-heart": "🤍"
                },
                "other-symbol": {
                    "skull": "💀",
                    "fire": "🔥",
                    "speaking-head": "🗣️",
                    "sparkles": "✨"
                }
            }
        }
        root.jsonLoaded = true
        loadCategoryEmojis("mood")
    }

    function loadCategoryEmojis(categoryName) {
        console.log("LOADING CATEGORY:", categoryName)
        root.currentCategory = categoryName
        var emojis = []
        
        if (root.emojiCategories[categoryName]) {
            var category = root.emojiCategories[categoryName]
            for (var subcategory in category) {
                var subcat = category[subcategory]
                for (var emojiName in subcat) {
                    emojis.push(subcat[emojiName])
                }
            }
        }
        
        root.currentCategoryEmojis = emojis
        console.log("LOADED", emojis.length, "EMOJIS FOR CATEGORY:", categoryName)
    }

    // instantiate EmojiRunner
    EmojiRunner {
        id: emojiRunner
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.margins: 20
        clip: true // Prevent content overflow

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            width: scrollView.width
            spacing: 20

            // CATEGORY SELECTOR BESTIE!! 🔥🔥
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: "#2d2d2d"
                radius: 12
                border.color: "#007acc"
                border.width: 2

                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 10
                    
                    Row {
                        spacing: 10
                        
                        Repeater {
                model: Object.keys(root.emojiCategories)
                
                Toggles.RoundIconToggleEmoji {
                    iconName: modelData.replace(/-/g, " ")
                    checked: root.currentCategory === modelData
                    onToggled: {
                        if (!checked) {
                            // If toggled off, do nothing to avoid breaking single-selection
                            return
                        }
                        root.loadCategoryEmojis(modelData)
                        // Update currentCategory to ensure only this toggle is checked
                        root.currentCategory = modelData
                    }
                }
            }
                    }
                }
            }

            // THE EPIC EMOJI GRID BESTIE!!! 🔥🔥🔥🔥
            GridLayout {
                columns: 8
                columnSpacing: 8
                rowSpacing: 8
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true

                Repeater {
                    model: root.currentCategoryEmojis
                    
                    Button {
                        text: modelData
                        font.pixelSize: 32
                        Layout.preferredWidth: 60
                        Layout.preferredHeight: 60
                        
                        onClicked: {
                            emojiRunner.run(modelData)
                            console.log("CLICKED EMOJI:", modelData, "🔥🔥🔥")
                        }
                        
                        hoverEnabled: true
                        
                        background: Rectangle {
                            color: parent.hovered ? "#007acc" : "#2d2d2d"
                            border.color: parent.hovered ? "#00ff88" : "#555"
                            border.width: 2
                            radius: 12
                            
                            // HOVER ANIMATION BESTIE
                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                            
                            Behavior on border.color {
                                ColorAnimation { duration: 150 }
                            }
                        }
                        
                        // CLICK ANIMATION CUZ WE'RE EXTRA
                        scale: pressed ? 0.95 : 1.0
                        Behavior on scale {
                            NumberAnimation { duration: 100 }
                        }
                    }
                }
            }
        }
    }

    // IPC HANDLER FOR TOGGLING BESTIE
    IpcHandler {
        target: "emoji"
        function toggle(): void {
            root.visible = !root.visible
            console.log("EMOJI PICKER TOGGLED!! VISIBLE:", root.visible)
        }
    }

    // BACKGROUND COLOR CUZ WE'RE AESTHETIC AF
    Rectangle {
        anchors.fill: parent
        color: "#0d1117"
        z: -1
    }
}