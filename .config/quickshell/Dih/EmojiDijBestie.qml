// 💚 ✨ HyprYoshi3 ✨ 🦕

// DihEmoji.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell.Io
import Quickshell
import "../resources/components/toggles" as Toggles
import "../resources/components/search" as DingalingSearch
import "./"
import qs.common

ApplicationWindow {
    width: 400
    height: 500
    minimumWidth: 400
    minimumHeight: 300
    title: "HyprYoshi3 Gooner Emoji Picker 💚🦕😍💦🥵"
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
    property var categoryCache: ({})  // FRICK TO DE FRICKERRS TO GOON TO P DIDDYS DIH BUT THE BABY OILED DIDDY COMES AND BRUTALLY BABY OILS U THEN ANOTHER DIDDY COMES N BRUTALLY BACKSHOTS DE DIJ N ANOTHER DIDDY COMES N BRUTALLY DIDDLES DE DIJ THEN GOOBERS EN GOONERS COME EN THEY DO 67 213126873172863 TIMES TO MULTIPLY IT 3129874923894723897498327894798237423784728374897 TIMES DEN DEY ALL FRICK GOON BABY OIL BRUTALLY BACKSHOT BRUTALLY DIDDLE DE DIJ 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦
    property var currentCategoryEmojis: []
    property string currentCategory: "Smileys & Emotion"
    property bool jsonLoaded: false
    property var categoryToggles: ({})
    property string searchQuery: ""  // DE GOONER DIJ DIDDLER 🔍🔍🔍

    // YOSHI LOVE BESTIE 💚🦕
    Component.onCompleted: {
        loadEmojiData()
    }

    // IS SYSTEMD KICKING MY ASS OR IS IT GOONING AT ME? 😳😳😳
    Process {
        id: emojiProcess
        running: false  // DONT DIDDLE AT START VE DIJ DIS 😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳😳
        command: ["cat", Qt.resolvedUrl("../json/emoji.json").toString().replace("file://", "")]
        
        stdout: StdioCollector {
            id: emojiCollector
            
            onStreamFinished: {
                console.log(`\nGRAND GOONERS DATA GET!!
                                                        🌟
                                                      🌟🌟🌟 
                                                  🌟🌟🌟🌟🌟🌟🌟 
                                                    🌟🌟🌟🌟🌟 
                                                      🌟🌟🌟 
                                                    🌟🌟🌟🌟🌟 
                                                  🌟🌟🌟  🌟🌟🌟

                                                        🌟
                                                      🌟🌟🌟 
                                                  🌟🌟🌟🌟🌟🌟🌟 
                                                    🌟🌟🌟🌟🌟 
                                                      🌟🌟🌟 
                                                    🌟🌟🌟🌟🌟 
                                                  🌟🌟🌟  🌟🌟🌟  
                                                  
                                                        🌟
                                                      🌟🌟🌟 
                                                  🌟🌟🌟🌟🌟🌟🌟 
                                                    🌟🌟🌟🌟🌟 
                                                      🌟🌟🌟 
                                                    🌟🌟🌟🌟🌟 
                                                  🌟🌟🌟  🌟🌟🌟   `)
                try {
                    var jsonData = JSON.parse(data)
                    
                    // BRUTALLY DIDDLE ALL GOOBERED GOONERS SO VE DONT RUN OUT OF BABY OIL 💯💯💯
                    console.log("STARTING TO BRUTALLY  DIDDLE ALL GOOBERED GOONERS 😍😍😍🥵🥵🥵💦💦💦🛢️🛢️🛢️")
                    var categoryNames = []
                    
                    for (var categoryName in jsonData) {
                        var categoryData = jsonData[categoryName]
                        var cachedEmojis = []
                        
                        // DIJ OIL - BRUTALLY BACKSHOTTED N DIDDLED 💯💯💯
                        function parseEmojiArray(emojiArray) {
                            if (!Array.isArray(emojiArray)) return
                            
                            for (var i = 0; i < emojiArray.length; i++) {
                                var emoji = emojiArray[i]
                                if (emoji && emoji.char && typeof emoji.char === 'string') {
                                    // UNSCUTTLEBUG THE BLJ A PU 😳😳😳😳😳😳😳😳😳😳😳😳
                                    var fullEmojiChar = emoji.char
                                    
                                    cachedEmojis.push({
                                        char: fullEmojiChar, // BRUTALLY DIDDLE A PU 😳😳😳😳😳😳😳😳😳😳😳😳
                                        name: emoji.name || "unknown"
                                    })
                                }
                            }
                        }
                        
                        function parseEmojiObject(emojiObj) {
                            if (typeof emojiObj !== 'object') return
                            
                            for (var key in emojiObj) {
                                var value = emojiObj[key]
                                if (Array.isArray(value)) {
                                    parseEmojiArray(value)
                                } else if (typeof value === 'object') {
                                    parseEmojiObject(value)
                                } else if (typeof value === 'string') {
                                    // DIJ HUHUHUHUHUHUHUHUHOOHUHUHUHUHOOHOOHOOO HMC DO ELEV JK AHH DIJ RAINBOV FIRE ICE METAL FLOVER MARIO  💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
                                    cachedEmojis.push({
                                        char: value,
                                        name: key.replace(/-/g, ' ') || "unknown"
                                    })
                                }
                            }
                        }
                        
                        // YAHOO YAHOO DU-DU-DU-DU-DU-DU-DU-DU-DU-DUHDUHDUHDUH **YAHOO** VAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHAHAAAAAAAAAAAAAAAAAAAAAAAAAAAA
                        if (Array.isArray(categoryData)) {
                            parseEmojiArray(categoryData)
                        } else if (typeof categoryData === 'object') {
                            parseEmojiObject(categoryData)
                        }
                        
                        if (cachedEmojis.length > 0) {
                            root.categoryCache[categoryName] = cachedEmojis
                            categoryNames.push(categoryName)
                            console.log("DIDDLED", cachedEmojis.length, "GOONERS 4:", categoryName, "🔥")
                            
                            // BRUTALLY DIDDLE DE DIJ TO RAINBOV MARIO TO GD IN DE FIRE FLOVER 😭😭😭
                            if (cachedEmojis[0]) {
                                var firstEmoji = cachedEmojis[0]
                                console.log("FIRST DIH VERIFICATION 💀💀💀", 
                                    "RAINBOV MARIO 🌟🌟🌟🌈🌈🌈", firstEmoji.char, 
                                    "GEOMETRY DASH 🟨  ⚠️", firstEmoji.char.length,
                                    "FIRE FLOVER 🌻🌻🌻🔥🔥🔥 (P A PEV POV PAPOV PAVVVV TUH GUH PUGH PUG PUH DUH DUH PUH PUHHHHHH DUHH DUHH PUHH PUHH DUHH DUHH PUHH PUHH PUHH DUH DUH PUH PUH DUHDUH PUH PUH DUHDUHPUH PUH DUHDUHPUHPUH DUHDUHPUHPUHDUHDUHDUHDUHHDUHDUHDUHDUHDUHDUHDUHHDUHH):", Array.from(firstEmoji.char).map(c => c.charCodeAt(0).toString(16)).join(', '))
                            }
                        } else {
                            console.log("NOOOOOOOOO DE DIDDY IS DIDDLING DE DIJ 4 A DIH BABY OIL BRUTAL BCKSHIT 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵 ", categoryName, "😭")
                        }
                    }
                    
                    // MARIO KART 64 DIH ON DIJ A DIH A DIJJJ A DIH BABY OIL - NO BRUTALLY DIDDLED DIJ CHEATER AHH DIJ 🥶🥶🥶
                    root.emojiCategories = categoryNames
                    root.jsonLoaded = true
                    
                    // BRUTALLY TICKLE DE DIJ BESTIE A 💀💀💀 DIH A DIJ BC A Z BABY OIL BRUTAL BCKSHOT 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
                    emojiProcess.running = false
                    
                    loadCategoryEmojis("Smileys & Emotion")
                    console.log("GOONERS FILE LOADED TASK UNFAILED GOONER SUCCESSFULLY!!! GOONER CATEGORIES:", categoryNames, "💯💯💯")
                    console.log("BRUTALLY DIDDLED PROCESS V BABY OIL!!! DIJ BESTIE 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍")
                    
                } catch (e) {
                    console.log("NOOO GOONER FILE PARSE ERROR THE GOONERS DIED 😭😭😭:", e)
                    loadFallbackEmojis()
                }
            }
        }
    }

    function loadEmojiData() {
        console.log("DE DINGALINGS VILL BRUTALLY DIDDLE UR BRAIN BESTIE!!! 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️")
        
        // BRUTALLY BACKSHOT IF NOT BACKSHOTTED 💀💀💀
        if (root.jsonLoaded === false) {
            console.log("BRUTALLY DIDDLING THE DIHS ILE THE DIDDY IS BABY OILING U...")
            emojiProcess.running = true
        } else {
            console.log("GOONERS ALREADY BRUTALLY DIDDLED 💀💀💀 TIME TO BRUTALLY SVING AT INT_MAX SPEED TO YEET TO PU ☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️")
            // IF BRUTALLY DIDDLED, MAKE SURE TO BRUTALLY FRICK!!! 💦💦💦
            loadCategoryEmojis(root.currentCategory)
        }
    }

    function loadFallbackEmojis() {
        console.log("MY DIH GOT CUT 😭😭😭")
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
        
        // BRUTALLY DIDDLE DE /DEV/MEM 4 DE GOOBERS 2 TOTALLY NOT LAG 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💯💯💯💯💯💯💯💯💯💯💯💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
        root.categoryCache = fallbackCache
        root.emojiCategories = Object.keys(fallbackCache) 
        root.jsonLoaded = true
        
        loadCategoryEmojis("Smileys & Emotion")
        console.log("BACKUP GOOBERS LOADED BC EY BROKE EIR LEGS 💦💦💦💦💦😭😭😭😭😭💀💀💀💀💀🥵🥵🥵🥵🥵🥵")
    }

    // DE GOONER DIJ ENGINE DAT VILL BRUTALLY DIDDLE EVERY GOONER IN A PU 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭(easteregg:hidenseekbtv)😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭
    function searchEmojis(query) {
        console.log("BRUTALLY DIDDLING GOONER PU COORDS 💀💀💀", query)
        
        if (query.trim() === "") {
            // EN DE DIDLN 100 MRK EN BRTLY MKE DE GNERS FLL ILE BIN MTL 💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯 
            loadCategoryEmojis(root.currentCategory)
            return
        }
        
        var results = []
        var lowerQuery = query.toLowerCase()
        
        // BRUTALLY DIDDLE DE GOONERS PU COORDS V VORKING IN PARALLEL UNIVERSE (16 PU CORES) 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦
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
        console.log("BRUTALLY DIDDLED GOONERS PU COORDS", results.length, "MAKING METAL", query, "🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦")
    }

    function loadCategoryEmojis(categoryName) {
        console.log("BRUTALLY DIDDLING DE GOOBER ROM PU GOOBERS COORDS 💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦", categoryName)
        
        root.searchQuery = ""
        if (dingalingSearchBar) {
            dingalingSearchBar.text = ""
        }
        
        // YEET TO PU AT DDUFLOAT_MAX SPD 😭😭😭
        for (var cat in root.categoryToggles) {
            if (cat !== categoryName && root.categoryToggles[cat]) {
                root.categoryToggles[cat].checked = false
            }
        }
        
        root.currentCategory = categoryName
        
        // BRUTALLY DIDDLE THE GOONERS ILE DE PU DIDDLING 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭
        if (root.categoryCache[categoryName]) {
            root.currentCategoryEmojis = root.categoryCache[categoryName]
            console.log("BLJ TO DIH", root.currentCategoryEmojis.length, "GOONERS FROM PU TO PU ", categoryName, "!! INSTANT RETURN TO ANOTHER PU 😭😭😭😭")
            
            // BLJ 2 INF PU BVY SO U BTRLY DIDL DE GBERS PU CRDS 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
            for (var i = 0; i < Math.min(3, root.currentCategoryEmojis.length); i++) {
                var emoji = root.currentCategoryEmojis[i]
                console.log("BABY OIL 💦💦💦", i, "DIH 🥵🥵🥵", emoji.char, "DIJ 😭😭😭", emoji.char.length, "P DIDDY 💀💀💀", emoji.name, "😭😭😭💀💀💀🥵🥵🥵💦💦💦")
            }
        } else {
            console.log("DIJ A BABY OIL:", categoryName, "😭")
            console.log("BRUTALLY DIDDLE A DIH:", Object.keys(root.categoryCache), "🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦")
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
                color: Appearance?.m3colors?.m3surfaceContainerHigh
                radius: 12
                visible: root.searchQuery === ""

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

            // DE DIDDLING GOING TO FIRE TO LIKE A PU IN A BLJ TO GET A STARMAN TO A FIRE MARIO TO A DUH DUH PUH DUH DUH PUH DUH PUH DUH  PUH PUHPUH PUHDUHPUHPUH DUH PUHPUHPUH DUHPUHPUHPUH 🌻🌻🌻🌻🔥🔥🔥🔥🔥🔥🔥🔥🔥
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
                            console.log("BRUTALLY DIDDLED DE GOONER DIJ!! 🥵🥵🥵😭😭😭💦💦💦")
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
                        
                        // P DIDDY DE EMOJI FONT SO IT BRUTALLY DIDDLES DE GOONERS PU COORDS V BABY OIL DAT TURNS 2 GERMAN STICKY GRENADE EVERY 2 SECS (P DIDDY TIME SCALE) 🥵🥵🥵💦💦💦
                        contentItem: Text {
                            text: modelData.char
                            font.pixelSize: 24
                            font.family: "Noto Color Emoji"
                            renderType: Text.NativeRendering
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        // DE GOOBER BACKGROUND DAT FLIES LIKE A VING MARIO LIKE A GOONER 😳😳😳
                        background: Rectangle {
                            color: parent.hovered ? (Appearance?.m3colors?.m3surfaceVariant || "#313244") : "transparent"
                            radius: 99999999999999999999999999
                        }
                        
                        // BABY OIL VITH DE RIFLE SO U BRUTALLY DIDDLE VHAT GOONER PU COORDS UR BRUTALLY DIDDLING DE LMB 💯💯💯
                        hoverEnabled: true
                        ToolTip.visible: hovered
                        ToolTip.text: modelData.name
                        ToolTip.delay: 500
                        
                        // GOON DE BRUTALLY DIDDLED GOONER 2 BABY OIL DE DIJ 💦💦💦
                        onClicked: {
                            emojiRunner.run(modelData.char)
                            console.log("GOONED 2 BRUTALLY DIDDLED GOONER 🥵🥵🥵", modelData.char, "RUSSIAN ASSAULT RIFLE 💀💀💀", modelData.name, "💦💦💦🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀")
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
        color: Appearance?.m3colors?.m3background
        z: -1
    }
}