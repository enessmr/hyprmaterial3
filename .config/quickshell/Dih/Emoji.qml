// DihEmoji.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell.Io
import Quickshell
import "../resources/components/toggles" as Toggles
import "../resources/colors.js" as Palette
import "../resources/components/search" as DingalingSearch
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
    property var categoryCache: ({})  // CACHE THE PARSED EMOJIS SO WE DONT STROKE OUT!! 🧠🔥
    property var currentCategoryEmojis: []
    property string currentCategory: "Smileys & Emotion"
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
        running: false  // DONT RUN AUTOMATICALLY!! WE CONTROL THIS!! 🔥
        command: ["cat", Qt.resolvedUrl("../json/emoji.json").toString().replace("file://", "")]
        
        stdout: StdioCollector {
            id: emojiCollector
            
            onStreamFinished: {
                console.log("GOONERS DATA GET!! 🔥")
                try {
                    var jsonData = JSON.parse(data)
                    
                    // PRE-CACHE ALL CATEGORIES SO WE DONT HAVE A STROKE LATER!! 💯💯💯
                    console.log("STARTING TO CACHE ALL THE GOONERS IN RAM!! 🧠🔥")
                    var categoryNames = []
                    
                    for (var categoryName in jsonData) {
                        var categoryData = jsonData[categoryName]
                        var cachedEmojis = []
                        
                        // HANDLE BOTH ARRAY AND OBJECT FORMATS!! 🧠⚡
                        if (Array.isArray(categoryData)) {
                            // DIRECT ARRAY FORMAT (Smileys & Emotion)
                            for (var i = 0; i < categoryData.length; i++) {
                                var emoji = categoryData[i]
                                if (emoji && emoji.char) {
                                    cachedEmojis.push({
                                        char: emoji.char,
                                        name: emoji.name || "unknown"
                                    })
                                }
                            }
                        } else if (typeof categoryData === 'object') {
                            // NESTED OBJECT FORMAT (People & Body, etc.)
                            for (var subcategory in categoryData) {
                                var subcategoryData = categoryData[subcategory]
                                if (Array.isArray(subcategoryData)) {
                                    for (var j = 0; j < subcategoryData.length; j++) {
                                        var subEmoji = subcategoryData[j]
                                        if (subEmoji && subEmoji.char) {
                                            cachedEmojis.push({
                                                char: subEmoji.char,
                                                name: subEmoji.name || "unknown"
                                            })
                                        }
                                    }
                                } else if (typeof subcategoryData === 'object') {
                                    // DEEPLY NESTED (like hand-fingers-open -> waving-hand)
                                    for (var emojiKey in subcategoryData) {
                                        var deepEmoji = subcategoryData[emojiKey]
                                        if (deepEmoji && typeof deepEmoji === 'string') {
                                            cachedEmojis.push({
                                                char: deepEmoji,
                                                name: emojiKey.replace(/-/g, ' ') || "unknown"
                                            })
                                        }
                                    }
                                }
                            }
                        }
                        
                        if (cachedEmojis.length > 0) {
                            root.categoryCache[categoryName] = cachedEmojis
                            categoryNames.push(categoryName)
                            console.log("CACHED", cachedEmojis.length, "GOONERS FOR:", categoryName, "🔥")
                        } else {
                            console.log("NO EMOJIS FOUND FOR CATEGORY:", categoryName, "😭")
                        }
                    }
                    
                    // SET EMOJI CATEGORIES FROM CACHE ONLY - NO DIRECT JSON ACCESS!! 🧠⚡
                    root.emojiCategories = categoryNames
                    root.jsonLoaded = true
                    
                    // STOP THE PROCESS SO IT NEVER RUNS AGAIN!! RAM CACHE ONLY NOW!! 🧠💯
                    emojiProcess.running = false
                    
                    loadCategoryEmojis("Smileys & Emotion")
                    console.log("GOONERS FILE LOADED TASK UNFAILED GOONER SUCESFULEY!!! GOONER CATEGORIES:", categoryNames, "💯💯💯")
                    console.log("PROCESS KILLED!! RUNNING FROM RAM CACHE ONLY NOW!! ⚡⚡⚡")
                    
                    // DEBUG: CHECK PEOPLE & BODY CACHE
                    if (root.categoryCache["People & Body"]) {
                        console.log("PEOPLE & BODY CACHE SUCCESS!! EMOJIS:", root.categoryCache["People & Body"].length, "🔥")
                    } else {
                        console.log("PEOPLE & BODY CACHE MISS - CHECKING ALTERNATIVE NAMES...")
                        for (var cat in root.categoryCache) {
                            if (cat.toLowerCase().includes("people") || cat.toLowerCase().includes("body")) {
                                console.log("FOUND SIMILAR CATEGORY:", cat, "WITH", root.categoryCache[cat].length, "EMOJIS")
                            }
                        }
                    }
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
        
        // ONLY LOAD IF NOT ALREADY CACHED!! 🧠💯
        if (root.jsonLoaded === false) {
            console.log("LOADING GOONERS FROM FILE FOR THE FIRST TIME...")
            emojiProcess.running = true
        } else {
            console.log("GOONERS ALREADY IN RAM CACHE!! SKIPPING FILE READ!! ⚡⚡⚡")
            // EVEN IF ALREADY LOADED, MAKE SURE WE'RE USING CACHE!!
            loadCategoryEmojis(root.currentCategory)
        }
    }

    function loadFallbackEmojis() {
        console.log("MY DIH GOT CUT 😭😭😭")
        // CREATE FALLBACK DATA THAT'S ALREADY IN THE CACHE FORMAT
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
            "Activities": [
                {char: "🎉", name: "party popper"},
                {char: "🎊", name: "confetti ball"},
                {char: "🎈", name: "balloon"},
                {char: "🎂", name: "birthday cake"}
            ],
            "Objects": [
                {char: "🔥", name: "fire"},
                {char: "🔦", name: "flashlight"},
                {char: "🕯️", name: "candle"}
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
        
        // DIRECTLY CACHE THE FALLBACK DATA - NO PARSING NEEDED!! ⚡⚡⚡
        root.categoryCache = fallbackCache
        root.emojiCategories = Object.keys(fallbackCache)  // ONLY STORE CATEGORY NAMES
        root.jsonLoaded = true
        
        loadCategoryEmojis("Smileys & Emotion")
        console.log("FALLBACK GOONERS LOADED DIRECTLY INTO CACHE!! ⚡🔥")
        console.log("PEOPLE & BODY FALLBACK EMOJIS:", fallbackCache["People & Body"].length, "🔥")
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
        
        // SEARCH THE CACHED DATA SUPER FAST!! ⚡⚡⚡
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
        console.log("LOADING CATEGORY FROM CACHE:", categoryName)
        
        root.searchQuery = ""
        if (dingalingSearchBar) {
            dingalingSearchBar.text = ""
        }
        
        // UNTOGGLE ALL OTHER GOONERS!!! 🔥🔥
        for (var cat in root.categoryToggles) {
            if (cat !== categoryName && root.categoryToggles[cat]) {
                root.categoryToggles[cat].checked = false
            }
        }
        
        root.currentCategory = categoryName
        
        // ONLY USE THE CACHE - NO JSON PARSING EVER!! ⚡⚡⚡
        if (root.categoryCache[categoryName]) {
            root.currentCategoryEmojis = root.categoryCache[categoryName]
            console.log("YOINKED", root.currentCategoryEmojis.length, "GOONERS FROM CACHE FOR", categoryName, "!! INSTANT LOAD!! ⚡🔥")
        } else {
            console.log("CACHE MISS FOR:", categoryName, "😭 - USING EMPTY ARRAY")
            console.log("AVAILABLE CACHED CATEGORIES:", Object.keys(root.categoryCache))
            root.currentCategoryEmojis = []
        }
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
                            model: root.emojiCategories
                            
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
                        text: modelData.char
                        font.pixelSize: 24
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40

                        // HOVER TOOLTIP WITH THE NAME!! 💯💯💯
                        hoverEnabled: true
                        ToolTip.visible: hovered
                        ToolTip.text: modelData.name
                        ToolTip.delay: 500
                        
                        onClicked: {
                            emojiRunner.run(modelData.char)
                            console.log("GOONED EMOJI:", modelData.char, "NAME:", modelData.name, "💦💦💦")
                        }
                        
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