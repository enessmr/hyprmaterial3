// 💚 ✨ HyprYoshi3 Gooner Emoji Picker ✨ 🦕
// FIXED SERVICE LOADING - NOW IT WON'T BE LAGGY LIKE PAYLEEY'S 2.7 INCH DIH 😭😭😭

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell
import Quickshell.Io
import "../resources/components/toggles" as Toggles
import "../resources/components/search" as DingalingSearch
import qs.common
import qs.services

ApplicationWindow {
    width: 475
    height: 515
    minimumWidth: 400
    minimumHeight: 300
    title: "HyprYoshi3 Gooner Emoji Picker 💚🦕😍💦🥵"
    id: root
    flags: Qt.Window | Qt.WindowStaysOnTopHint
    
    // KEEP THAT 12 INCH DINGALING!!! 🫙🫙🫙 
    property var windowGeometry: ({
        x: 0,
        y: 0,
        width: 475,
        height: 515
    })

    // LET THAT 12 INCH DINGALING ESCAPE BUT I FOUND IT AGAIN 😭😭😭
    onClosing: {
        windowGeometry = {
            x: x,
            y: y,
            width: width,
            height: height
        }
    }

    // MEOV. MEE-OVVV.
    onVisibleChanged: {
        if (visible) {
            x = windowGeometry.x
            y = windowGeometry.y
            width = windowGeometry.width
            height = windowGeometry.height
            // PRELOAD GOONERS WHEN SHOWING BUT FROM SERVICE NOT JSON 😍😍😍
            loadEmojiData()
        }
    }

    visible: false

    property string selectedEmoji
    property string currentCategory: "Smileys & Emotion"
    property string searchQuery: ""
    property var currentCategoryEmojis: []
    
    // USE THE EXISTING EMOJI SERVICE - NO JSON PARSING NEEDED!! 🧠⚡⚡
    property var emojiService: null
    
    // GET CATEGORIES FROM SERVICE - INSTANT LOAD NO LAG!! 🔥🔥🔥
    property var emojiCategories: []
    property var categoryCache: ({}) // LOCAL CACHE COPY FOR SAFETY

    Component.onCompleted: {
        console.log("EMOJI PICKER INITIALIZED - FINDING SERVICE... 🔍")
        findEmojiService()
    }

    // FIND THAT DAMN SERVICE BESTIE!! 🔍🔥
    function findEmojiService() {
        console.log("LOOKING FOR EMOJI SERVICE...")
        
        // TRY DIFFERENT WAYS TO GET THE SERVICE 😭😭😭
        var service = Quickshell.singletonInstance("emoji", "EmojiSingleton")
        if (!service) {
            console.log("SERVICE NOT FOUND WITH SINGLETON INSTANCE, TRYING DIRECT ACCESS...")
            // MAYBE IT'S REGISTERED DIFFERENTLY???
            service = Quickshell.singletonInstance("EmojiSingleton")
        }
        
        if (service) {
            console.log("🎉 EMOJI SERVICE FOUND BESTIE!! 🎉")
            root.emojiService = service
            syncServiceData()
        } else {
            console.log("😭 SERVICE STILL NOT FOUND, USING FALLBACK GOONERS...")
            loadFallbackEmojis()
        }
    }

    // SYNC DATA FROM SERVICE TO OUR LOCAL CACHE 🧠⚡
    function syncServiceData() {
        if (!root.emojiService) {
            console.log("NO SERVICE TO SYNC FROM 😭")
            return
        }
        
        console.log("SYNCING DATA FROM SERVICE...")
        
        // WAIT A BIT FOR SERVICE TO BE READY 🫙
        if (!root.emojiService.jsonLoaded) {
            console.log("SERVICE NOT LOADED YET, WAITING...")
            serviceReadyTimer.start()
            return
        }
        
        // COPY THE CACHE FROM SERVICE 🎯
        if (root.emojiService.categoryCache) {
            root.categoryCache = root.emojiService.categoryCache
            root.emojiCategories = Object.keys(root.categoryCache)
            console.log("SYNCED", root.emojiCategories.length, "CATEGORIES FROM SERVICE!! 🔥")
            
            // LOAD INITIAL CATEGORY
            loadCategoryEmojis("Smileys & Emotion")
        } else {
            console.log("SERVICE HAS NO CACHE 😭 - USING FALLBACK")
            loadFallbackEmojis()
        }
    }

    // TIMER TO WAIT FOR SERVICE TO BE READY 🕐
    Timer {
        id: serviceReadyTimer
        interval: 500
        repeat: true
        running: root.emojiService && !root.emojiService.jsonLoaded
        onTriggered: {
            console.log("CHECKING IF SERVICE IS READY...")
            if (root.emojiService.jsonLoaded) {
                console.log("SERVICE IS NOW READY!! SYNCING DATA... 🚀")
                syncServiceData()
                stop()
            }
            
            // TIMEOUT AFTER 5 SECONDS 😭
            if (repeatCount > 10) {
                console.log("SERVICE TIMEOUT - USING FALLBACK GOONERS")
                loadFallbackEmojis()
                stop()
            }
        }
    }

    // FALLBACK GOONERS IN CASE SERVICE IS DEAD 😭😭😭
    function loadFallbackEmojis() {
        console.log("LOADING FALLBACK GOONERS BESTIE!! 🆘")
        
        var fallbackCache = {
            "Smileys & Emotion": [
                {char: "😀", name: "grinning face"},
                {char: "😃", name: "grinning face with big eyes"},
                {char: "😄", name: "grinning face with smiling eyes"},
                {char: "😁", name: "beaming face with smiling eyes"},
                {char: "😆", name: "grinning squinting face"},
                {char: "😅", name: "grinning face with sweat"},
                {char: "🤣", name: "rolling on the floor laughing"},
                {char: "😂", name: "face with tears of joy"},
                {char: "🙂", name: "slightly smiling face"},
                {char: "🙃", name: "upside-down face"},
                {char: "😉", name: "winking face"},
                {char: "😊", name: "smiling face with smiling eyes"},
                {char: "😇", name: "smiling face with halo"},
                {char: "🥰", name: "smiling face with hearts"},
                {char: "😍", name: "smiling face with heart-eyes"},
                {char: "🤩", name: "star-struck"},
                {char: "😘", name: "face blowing a kiss"},
                {char: "😗", name: "kissing face"}
            ],
            "People & Body": [
                {char: "👋", name: "waving hand"},
                {char: "🤚", name: "raised back of hand"},
                {char: "🖐️", name: "hand with fingers splayed"},
                {char: "✋", name: "raised hand"},
                {char: "🖖", name: "vulcan salute"},
                {char: "👌", name: "OK hand"},
                {char: "🤌", name: "pinched fingers"},
                {char: "🤏", name: "pinching hand"},
                {char: "✌️", name: "victory hand"},
                {char: "🤞", name: "crossed fingers"},
                {char: "🫰", name: "hand with index finger and thumb crossed"},
                {char: "🤟", name: "love-you gesture"},
                {char: "🤘", name: "sign of the horn"},
                {char: "🤙", name: "call me hand"},
                {char: "👈", name: "backhand index pointing left"},
                {char: "👉", name: "backhand index pointing right"},
                {char: "👆", name: "backhand index pointing up"},
                {char: "🖕", name: "middle finger"},
                {char: "👇", name: "backhand index pointing down"},
                {char: "☝️", name: "index pointing up"},
                {char: "👍", name: "thumbs up"},
                {char: "👎", name: "thumbs down"},
                {char: "✊", name: "raised fist"},
                {char: "👊", name: "oncoming fist"},
                {char: "🤛", name: "left-facing fist"},
                {char: "🤜", name: "right-facing fist"},
                {char: "👏", name: "clapping hands"},
                {char: "🙌", name: "raising hands"},
                {char: "🫶", name: "heart hands"},
                {char: "👐", name: "open hands"},
                {char: "🤲", name: "palms up together"},
                {char: "🤝", name: "handshake"},
                {char: "🙏", name: "folded hands"}
            ],
            "Animals & Nature": [
                {char: "🐢", name: "turtle"},
                {char: "🦎", name: "lizard"},
                {char: "🐍", name: "snake"},
                {char: "🐲", name: "dragon face"},
                {char: "🐉", name: "dragon"},
                {char: "🦕", name: "sauropod"}  // YOSHI BESTIE!! 💚
            ],
            "Food & Drink": [
                {char: "🍕", name: "pizza"},
                {char: "🍔", name: "hamburger"},
                {char: "🍟", name: "fries"},
                {char: "🌭", name: "hot dog"},
                {char: "🌮", name: "taco"}
            ],
            "Symbols": [
                {char: "❤️", name: "red heart"},
                {char: "🧡", name: "orange heart"},
                {char: "💛", name: "yellow heart"},
                {char: "💚", name: "green heart"}, // YOSHI LOVE!! 🦕
                {char: "💙", name: "blue heart"},
                {char: "💜", name: "purple heart"},
                {char: "🤎", name: "brown heart"},
                {char: "🖤", name: "black heart"},
                {char: "🤍", name: "white heart"},
                {char: "💀", name: "skull"},
                {char: "🗣️", name: "speaking head"},
                {char: "✨", name: "sparkles"}
            ]
        }
        
        root.categoryCache = fallbackCache
        root.emojiCategories = Object.keys(fallbackCache)
        console.log("LOADED", root.emojiCategories.length, "FALLBACK CATEGORIES WITH GOONERS!! 🆘🔥")
        
        loadCategoryEmojis("Smileys & Emotion")
    }

    // LOAD EMOJI DATA FROM SERVICE - SUPER FAST NO LAG!! ⚡⚡⚡
    function loadEmojiData() {
        console.log("LOADING GOONERS BESTIE!! 🚀")
        
        if (root.emojiService && root.emojiService.jsonLoaded) {
            console.log("SERVICE ALREADY HAS GOONERS IN RAM CACHE!! INSTANT LOAD!! ⚡")
            syncServiceData()
        } else if (root.emojiCategories.length > 0) {
            console.log("USING LOCAL CACHE - INSTANT LOAD!! ⚡")
            loadCategoryEmojis("Smileys & Emotion")
        } else {
            console.log("NO SERVICE OR CACHE - USING FALLBACK GOONERS 🆘")
            loadFallbackEmojis()
        }
    }

    // THE GOONER SEARCH ALGORITHM THAT VILL FIND EVERY GOONER IN EXISTENCE 🔍🔥
    function searchEmojis(query) {
        console.log("SEARCHING FOR GOONERS:", query)
        
        if (query.trim() === "") {
            // WHEN SEARCH IS EMPTY, JUST USE THE CACHED CATEGORY DATA!! ⚡
            loadCategoryEmojis(root.currentCategory)
            return
        }
        
        var results = []
        var lowerQuery = query.toLowerCase()
        
        // SEARCH OUR LOCAL CACHE SUPER FAST!! ⚡⚡⚡
        for (var categoryName in root.categoryCache) {
            var cachedArray = root.categoryCache[categoryName]
            for (var i = 0; i < cachedArray.length; i++) {
                var emoji = cachedArray[i]
                if (emoji.name && emoji.name.toLowerCase().indexOf(lowerQuery) !== -1) {
                    results.push(emoji)
                }
            }
        }
        
        root.currentCategoryEmojis = results
        console.log("FOUND", results.length, "GOONERS MATCHING:", query, "🔥🔥🔥")
    }

    function loadCategoryEmojis(categoryName) {
        console.log("LOADING CATEGORY:", categoryName)
        
        root.searchQuery = ""
        if (dingalingSearchBar) {
            dingalingSearchBar.text = ""
        }
        
        root.currentCategory = categoryName
        
        // USE OUR LOCAL CACHE - NO SERVICE DEPENDENCY!! ⚡⚡⚡
        if (root.categoryCache[categoryName]) {
            root.currentCategoryEmojis = root.categoryCache[categoryName]
            console.log("LOADED", root.currentCategoryEmojis.length, "GOONERS FOR", categoryName, "!! INSTANT LOAD!! ⚡🔥")
        } else {
            console.log("CACHE MISS FOR:", categoryName, "😭 - USING EMPTY ARRAY")
            console.log("AVAILABLE CATEGORIES:", root.emojiCategories)
            root.currentCategoryEmojis = []
        }
    }

    // SOMENONE GOONED TO ME AND IT'S BASH 😳😳😳
    Process {
        id: emojiRunner
        command: ["bash", "-c", "echo -n \"%1\" | wl-copy"]
        
        function run(emojiChar) {
            // CLEAN THE EMOJI FOR BASH TO GOON AND FRICK TO IT 😍😍😍
            var cleanEmoji = emojiChar.replace(/"/g, '\\"').replace(/'/g, "'\\''")
            emojiRunner.command = ["bash", "-c", `echo -n "${cleanEmoji}" | wl-copy`]
            emojiRunner.running = true
            root.visible = false
            console.log("GOONED EMOJI TO CLIPBOARD:", emojiChar, "💦💦💦")
        }
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.margins: 20
        clip: true // PAYLEEY HAS A 2.7 INCH DINGALING AND IF YOU CUT IT YOU VILL FIND A GOONER TO SATAN IN IT! 😱😱😱

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            width: scrollView.width
            spacing: 20

            // GOONERS IN HERE??? NO I'M NOT TOUCHING THIS VITH A 1000 FOOT POLE
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: Appearance?.m3colors?.m3surfaceContainerHigh
                radius: 12
                visible: root.searchQuery === "" && root.emojiCategories.length > 0  // HIDE IF NO CATEGORIES OR SEARCHING

                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 10
                    
                    Row {
                        spacing: 10
                        
                        Repeater {
                            model: root.emojiCategories
                            
                            Toggles.RoundIconToggleEmoji {
                                id: categoryToggle
                                iconName: {
                                    var iconMap = {
                                        "Smileys & Emotion": "mood",
                                        "People & Body": "emoji_people", 
                                        "Animals & Nature": "pets",
                                        "Food & Drink": "emoji_food_beverage",
                                        "Travel & Places": "emoji_transportation",
                                        "Activities": "sports_soccer",
                                        "Objects": "emoji_objects",
                                        "Symbols": "emoji_symbols",
                                        "Flags": "flag"
                                    }
                                    return iconMap[modelData] || "emoji_emotions"
                                }
                                checked: root.currentCategory === modelData
                                
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
                behavior: "overlay"
    
                onTextChanged: {
                    root.searchQuery = text
                    searchEmojis(text)
                }
    
                onSubmitted: function(text) {
                    console.log("FLUDD GOONED:", text, "💦💦💦")
                }
    
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
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        
                        contentItem: Text {
                            text: modelData.char
                            font.pixelSize: 24
                            font.family: "Noto Color Emoji"
                            renderType: Text.NativeRendering
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        background: Rectangle {
                            color: parent.hovered ? (Appearance?.m3colors?.m3surfaceVariant || "#313244") : "transparent"
                            radius: 999
                        }
                        
                        hoverEnabled: true
                        ToolTip.visible: hovered
                        ToolTip.text: modelData.name
                        ToolTip.delay: 500
                        
                        onClicked: {
                            emojiRunner.run(modelData.char)
                            console.log("GOONED EMOJI:", modelData.char, "NAME:", modelData.name, "💦💦💦")
                        }
                    }
                }
            }

            // SHOW MESSAGE IF NO GOONERS FOUND 😭😭😭
            Label {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                text: root.emojiCategories.length === 0 ? 
                      "NO GOONERS LOADED BESTIE 😭😭😭\n(check if emoji service is running)" : 
                      "NO GOONERS FOUND FOR SEARCH 😭😭😭"
                color: Appearance?.m3colors?.m3onSurfaceVariant
                horizontalAlignment: Text.AlignHCenter
                visible: root.currentCategoryEmojis.length === 0
            }
        }
    }

    // NAH FAM I PUT THIS DIH IN A JAR SO IT BECOMES SAFE AND NEVER STOLEN AND BE CALLED EVERYTIME 🗣️🗣️🗣️🔥🔥🔥
    IpcHandler {
        target: "emoji"
        function toggle(): void {
            root.visible = !root.visible
            console.log("EMOJI PICKER TOGGLED!! VISIBLE:", root.visible, 
                       "CATEGORIES:", root.emojiCategories.length,
                       "SERVICE:", !!root.emojiService, "🔥")
        }
    }

    // SO A GOONER IN THE BG??? VHAT???? 😱😱😱😱😱😱
    Rectangle {
        anchors.fill: parent
        color: Appearance?.m3colors?.m3background
        z: -1
    }
}