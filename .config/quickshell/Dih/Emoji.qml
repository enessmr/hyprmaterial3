// DihEmoji.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell.Io
import Quickshell
import "../resources/components/toggles" as Toggles
import "../resources/colors.js" as Palette
import "../resources/components/search" as DingalingSearch  // Add this import
import "./"

ApplicationWindow {
    width: 400
    height: 500
    minimumWidth: 400
    minimumHeight: 300
    title: "Ima Guna Tuch Obaeeas Dih 😍"
    id: root
    flags: Qt.Window | Qt.WindowStaysOnTopHint
    
    // FOUND A 12 INCH DINGALING HERE THO NGL?!?!? 😳😳😳
    property var windowGeometry: ({
        x: 0,
        y: 0,
        width: 475,
        height: 515
    })

    // KEEP THAT 12 INCH DINGALING!!! 🫙🫙🫙 
    onClosing: {
        windowGeometry = {
            x: x,
            y: y,
            width: width,
            height: height
        }
    }

    // LET THAT 12 INCH DINGALING ESCAPE BUT I FOUND IT AGAIN 😭😭😭
    onVisibleChanged: {
        if (visible) {
            x = windowGeometry.x
            y = windowGeometry.y
            width = windowGeometry.width
            height = windowGeometry.height
        }
    }

    // MEOV. MEE-OVVV.
    visible: false

    property string selectedEmoji
    property var emojiCategories: ({})
    property var currentCategoryEmojis: []
    property string currentCategory: "mood"
    property bool jsonLoaded: false
    property var categoryToggles: ({})
    property string searchQuery: ""  // THE GOONER SEARCH ENGINE 🔍🔍🔍

    // YOSHI LOVE BESTIE 💚🦕
    Component.onCompleted: {
        loadEmojiData()
    }

    // IS SYSTEMD KICKING MY ASS OR IS IT GOONING AT ME? 😳😳😳
    Process {
        id: emojiProcess
        running: true
        command: ["cat", Qt.resolvedUrl("../json/emoji.json").toString().replace("file://", "")]
        
        stdout: StdioCollector {
            id: emojiCollector
            
            onStreamFinished: {
                console.log("GOONERS DATA GET!! 🔥")
                try {
                    var jsonData = JSON.parse(data)
                    root.emojiCategories = jsonData
                    root.jsonLoaded = true
                    loadCategoryEmojis("mood")
                    console.log("GOONERS FILE LOADED TASK UNFAILED GOONER SUCESFULEY!!! GOONER CATEGORIES:", Object.keys(jsonData))
                } catch (e) {
                    console.log("NOOO GOONER FILE PARSE ERROR THE GOONERS DIED 😭😭😭:", e)
                    // IF GOONERS DIE LOAD BACKUP GOONERS IN THE SIMULATION 😧😧😧
                    loadFallbackEmojis()
                }
            }
        }
    }

    function loadEmojiData() {
        console.log("EMOJI DATA WILL LOAD AUTOMATICALLY BESTIE!! 🔥")
        // NAH NAH NAH NAH NAH VHO GOONED AT ME 😱😱😱
        if (root.jsonLoaded === false) {
            console.log("WAITING FOR THE GOONERS FILE TO LOAD...")
        }
    }

    function loadFallbackEmojis() {
        console.log("MY DIH GOT CUT 😭😭😭")
        root.emojiCategories = {
            "mood": {
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
            "emoji_people": {
                "hand-fingers-open": {
                    "waving-hand": "👋",
                    "raised-back-of-hand": "🤚",
                    "hand-with-fingers-splayed": "🖐️",
                    "raised-hand": "✋",
                    "vulcan-salute": "🖖"
                }
            },
            "pets": {
                "animal-reptile": {
                    "turtle": "🐢",
                    "lizard": "🦎", 
                    "snake": "🐍",
                    "dragon-face": "🐲",
                    "dragon": "🐉",
                    "sauropod": "🦕"  // YOSHI BESTIE!! 💚
                }
            },
            "emoji_food_beverage": {
                "food-prepared": {
                    "pizza": "🍕",
                    "hamburger": "🍔",
                    "fries": "🍟",
                    "hot-dog": "🌭",
                    "taco": "🌮"
                }
            },
            "sports_soccer": {
                "event": {
                    "party-popper": "🎉",
                    "confetti-ball": "🎊",
                    "balloon": "🎈",
                    "birthday-cake": "🎂"
                }
            },
            "emoji_objects": {
                "light-video": {
                    "fire": "🔥",
                    "flashlight": "🔦",
                    "candle": "🕯️"
                }
            },
            "emoji_symbols": {
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

    // THE GOONER SEARCH ALGORITHM THAT VILL FIND EVERY GOONER IN EXISTENCE 🔍🔥
    function searchEmojis(query) {
        console.log("SEARCHING FOR GOONERS:", query)
        
        if (query.trim() === "") {
            // IF NO SEARCH RELOAD THE CURRENT CATEGORY GOONERS 😳
            loadCategoryEmojis(root.currentCategory)
            return
        }
        
        var results = []
        var lowerQuery = query.toLowerCase()
        
        // SEARCH THROUGH ALL THE GOONER CATEGORIES 🔍🔍🔍
        for (var categoryName in root.emojiCategories) {
            var category = root.emojiCategories[categoryName]
            for (var subcategory in category) {
                var subcat = category[subcategory]
                for (var emojiName in subcat) {
                    if (emojiName.toLowerCase().indexOf(lowerQuery) !== -1 ||
                        subcategory.toLowerCase().indexOf(lowerQuery) !== -1 ||
                        categoryName.toLowerCase().indexOf(lowerQuery) !== -1) {
                        results.push(subcat[emojiName])
                    }
                }
            }
        }
        
        root.currentCategoryEmojis = results
        console.log("FOUND", results.length, "GOONERS MATCHING:", query, "🔥🔥🔥")
    }

    function loadCategoryEmojis(categoryName) {
        console.log("LOADING CATEGORY:", categoryName)
        
        // CLEAR THE SEARCH BAR WHEN SWITCHING CATEGORIES 🧹🧹🧹
        root.searchQuery = ""
        dingalingSearchBar.text = ""
        
        // UNTOGGLE ALL OTHER GOONERS!!! 🔥🔥
        for (var cat in root.categoryToggles) {
            if (cat !== categoryName && root.categoryToggles[cat]) {
                root.categoryToggles[cat].checked = false
            }
        }
        
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
        console.log("LOADED AN AK47", emojis.length, "GOONERS FOR GOONER CATEGORY:", categoryName)
    }

    // SOMENONE GOONED TO ME AND IT'S BASH 😳😳😳
    EmojiRunner {
        id: emojiRunner
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.margins: 20
        clip: true // PAYLEEY HAS A 2.7 INCH DINGALING AND IF YOU CUT IT YOU VILL FIND A GOONER TO SATAN IN IT! (payleey hater btv) 😱😱😱

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            width: scrollView.width
            spacing: 20

            // GOONERS IN HERE??? NO I'M NOT TOUCHING THIS VITH A 1000 FOOT POLE
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: Palette.palette().surfaceContainerHigh
                radius: 12
                visible: root.searchQuery === ""  // HIDE CATEGORIES WHEN SEARCHING 👀

                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 10
                    
                    Row {
                        spacing: 10
                        
                        Repeater {
                            model: Object.keys(root.emojiCategories)
                            
                            Toggles.RoundIconToggleEmoji {
                                id: categoryToggle
                                iconName: modelData.replace(/-/g, " ")
                                checked: root.currentCategory === modelData
                                
                                // THE OBJECT IS TRYING TO SKIP 9/11 BY GOONING 😱🤯🤯🤯
                                objectName: "toggle_" + modelData
                                
                                // oh so the complete tried turning his eyes red (if my eyes turn red run) [IMA GUNA TUCH U 😍]
                                Component.onCompleted: {
                                    root.categoryToggles[modelData] = categoryToggle
                                    console.log("REGISTERED TOGGLE FOR:", modelData)
                                }
                                
                                onToggled: {
                                    if (checked) {
                                        root.loadCategoryEmojis(modelData)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // THE SEARCH BAR FOR FINDING GOONERS FAST AS FUCK 🔍🔥🔥🔥
            DingalingSearch.Search {
                id: dingalingSearchBar
                Layout.fillWidth: true
                placeholderText: "search gooners..."
                behavior: "overlay"  // SNIFF YOUR FEET LIKE THE DEVICES DO 😨😨😨
    
                // ON DINGALING CHANGED 💀💀💀
                onTextChanged: {
                    root.searchQuery = text
                    searchEmojis(text)
                }
    
                // Handle cutting payleeys 😳
                onSubmitted: function(text) {
                    console.log("FLUDD GOONED:", text, "💦💦💦")
                }
    
                // OPTIONAL: INSTALL ARCH AND PLAYLEEY'S DIH INSIDE GOONER TO SATAN IN A GOONER IN A GOOBER IN A GOONER IN A TON 618 IN A CEREAL
                rightActions: [
                    {
                        iconName: "close",
                        onTriggered: function() {
                            dingalingSearchBar.text = ""
                            console.log("CLEARED THE GOONER SEARCH!! 🧹💦💦💦")
                        }
                    }
                ]
            }

            // OK SO I SHOVED UP MY ASS A BUTT PLUG INSIDE A GERMAN STICKY GRENADE 😭😭😭
            GridLayout {
                columns: 9
                columnSpacing: 8
                rowSpacing: 8
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true

                Repeater {
                    model: root.currentCategoryEmojis
                    
                    Button {
                        text: modelData
                        font.pixelSize: 24
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        
                        onClicked: {
                            emojiRunner.run(modelData)
                            console.log("GOONED EMOJI:", modelData, "💦💦💦")
                        }
                        
                        // hoverEnabled: true
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
        }
    }

    // NAH FAM I PUT THIS DIH IN A JAR SO IT BECOMES SAFE AND NEVER STOLEN AND BE CALLED EVERYTIME 🗣️🗣️🗣️🔥🔥🔥
    IpcHandler {
        target: "emoji"
        function toggle(): void {
            root.visible = !root.visible
            console.log("EMOJI PICKER TOGGLED!! VISIBLE:", root.visible)
        }
    }

    // SO A GOONER IN THE BG??? VHAT???? 😱😱😱😱😱😱
    Rectangle {
        anchors.fill: parent
        color: Palette.palette().background
        z: -1
    }
}