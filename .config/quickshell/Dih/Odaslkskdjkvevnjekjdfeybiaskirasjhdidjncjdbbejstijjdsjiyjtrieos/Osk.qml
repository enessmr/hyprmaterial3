// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import Quickshell
import Quickshell.Io

Window {
    id: dihOskRootFrFrNoCapBestie
    width: 1200
    height: 400
    visible: false
    title: "HyprYoshi3 On't Screen Keyboard 💚🦕😍💦🥵"
    color: Appearance.m3colors.surface
    
    property string homeDir: Quickshell.env("HOME") || ""
    property string dictPath: homeDir + "/.local/share/hypryoshi3/quickshell/dict/"
    
    // de bab oil 😍
    property var customDict: []
    property var slangDict: []
    property bool shiftPressed: false
    property bool capsLock: false
    
    Component.onCompleted: {
        console.log("BRUTALLY MAKING HARAM 😭😭😭😭😭 GOD HATES ME 😕")
        loadDictionaries()
    }
    
    // BRUTALLY DIDDLE THE FART IN THE STATIONARY OHM 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭
    function loadDictionaries() {
        // BRUTALLY DIDDLE DE FILE IN DE MINING EMPIRE 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍
        loadDictFile(dictPath + "custom/01-default.dict", function(content) {
            if (content.trim() !== "") {
                customDict = content.split('\n').filter(function(w) { return w.trim() !== '' })
                console.log("BRUATALLY SDAS D FF S /DEV/SDA1, /DEV/SDA2, /DEV/SDA3", customDict.length, "HMM 🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔")
            } else {
                // DIDDLED FR FR CAP 🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶
                customDict = ['yoshi', 'hypryoshi', 'bestie', 'luma', 'blj', 'pu', 'qpu', 'dih', 'goober', 'gooner', 'dingaling']
                console.log("ur default aint there bestie :(")
            }
        })
        
        // BRUTALLY DIDDLE DE FILE IN DE MINING EMPIRE 🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩
        loadDictFile(dictPath + "slang/01-default.dict", function(content) {
            if (content.trim() !== "") {
                var words = content.split('\n').filter(function(w) { return w.trim() !== '' })
                slangDict = slangDict.concat(words)
                console.log("DIJ SLANG 31 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭", words.length, "AS'L;DJASLKJDLKASJK 😭😭😭😭😭😭😭😭😭")
            } else {
                // DIDDLED FR FR NO CAP 🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶
                slangDict = ['fr', 'ngl', 'lowkey', 'highkey', 'tbh', 'imo', 'imho', 'brb', 'omg', 'lol', 'lmao', 'smh', 'idk', 'iirc', 'tho', 'rn', 'btw']
                console.log("ur baby oil isnt there bestie heres a dict 💀💀💀💀💀💀")
            }
        })
        
        // BRUTALLY DIDDLE DE FILE IN DE MINING EMPIRE 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
        loadDictFile(dictPath + "slang/02-userslang.dict", function(content) {
            if (content.trim() !== "") {
                var words = content.split('\n').filter(function(w) { return w.trim() !== '' })
                slangDict = slangDict.concat(words)
                console.log("DIDDLER SLAND BRUTALLY GOONED DID 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭", words.length, "DIJJ 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀")
            }
        })
    }
    
    // DE GALAXY 1 ENDIN BLACK HOL SCENE NOOOOO AAAAAAAAAAAAAAAAAAAAA 😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭
    function loadDictFile(path, callback) {
        console.log("AHUUU 😭😭😭😭", path)
        var proc = Qt.createQmlObject('import Quickshell.Io; Process { id: fileReader }', dihOskRootFrFrNoCapBestie)
        
        proc.command = ["cat", path]
        proc.running = true
        
        var collector = Qt.createQmlObject('import Quickshell.Io; StdioCollector {}', proc)
        proc.stdout = collector
        
        collector.onStreamFinished.connect(function() {
            callback(collector.text)
            proc.destroy()
        })
        
        // UNSCUTTLE BUG A DIJ Z S PFC XKXJJRKJF 😍
        Timer.singleShot(100, function() {
            if (!proc.running) {
                console.log("AGHUUU:", path, "😭😭😭")
                callback("")
            }
        })
    }
    
    // DIDDLE SEGGS DIDDLED ON GOONER 67 (DE DIDDY SEGGS) 🥵🥵🥵
    function getSuggestions(text) {
        if (!text || text.length < 1) return []
        
        var lower = text.toLowerCase()
        var results = []
        
        // A🥲
        for (var i = 0; i < customDict.length && results.length < 5; i++) {
            if (customDict[i].toLowerCase().startsWith(lower)) {
                results.push(customDict[i])
            }
        }
        
        // MARIO 🫥
        for (var j = 0; j < slangDict.length && results.length < 5; j++) {
            if (slangDict[j].toLowerCase().startsWith(lower)) {
                // BRUTALLY DIDDLE GOOMBAS 🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩
                var isDupe = false
                for (var k = 0; k < results.length; k++) {
                    if (results[k] === slangDict[j]) {
                        isDupe = true
                        break
                    }
                }
                if (!isDupe) {
                    results.push(slangDict[j])
                }
            }
        }
        
        return results
    }
    
    // DIDDLE OSURUK NNB OTUZBIR CADASASADASS 🫣🫣🫣
    function getCurrentWord() {
        var pos = textInput.cursorPosition
        var txt = textInput.text
        var start = pos
        var end = pos
        
        // das baby (oil) 💀
        while (start > 0 && txt[start-1] !== ' ' && txt[start-1] !== '\n') start--
        while (end < txt.length && txt[end] !== ' ' && txt[end] !== '\n') end++
        
        return txt.substring(start, end)
    }
    
    // DIJ DAS PU VATER SEG (DIH BESTIE SEGGS) 💚💚💚
    function replaceCurrentWord(newWord) {
        var pos = textInput.cursorPosition
        var txt = textInput.text
        var start = pos
        
        // YAHOO YAHOO YAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYA 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
        while (start > 0 && txt[start-1] !== ' ' && txt[start-1] !== '\n') start--
        
        // BRUTALLY DIDDLE DOJ ON DE SDADEG X🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢🫢
        var end = pos
        while (end < txt.length && txt[end] !== ' ' && txt[end] !== '\n') end++
        
        textInput.text = txt.substring(0, start) + newWord + txt.substring(end)
        textInput.cursorPosition = start + newWord.length
    }
    
    // BIRTH YEET BABOIL PLATFORM UP/LOCK DIJ 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀 
    function applyCase(text) {
        if (capsLock) return text.toUpperCase()
        if (shiftPressed) return text.toUpperCase()
        return text
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
        
        // 😍😍😍😍
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: "#313244"
            radius: 8
            border.color: "#45475a"
            border.width: 2
            
            TextEdit {
                id: textInput
                anchors.fill: parent
                anchors.margins: 10
                color: "#cdd6f4"
                font.pixelSize: 24
                font.family: "monospace"
                wrapMode: TextEdit.Wrap
                selectByMouse: true
                
                onTextChanged: {
                    var word = getCurrentWord()
                    var suggestions = getSuggestions(word)
                    suggestionRepeater.model = suggestions
                }
            }
        }
        
        // SEGGS BAR 🥵🥵🥵🥵🥵🥵🥵
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "#181825"
            radius: 6
            visible: suggestionRepeater.model.length > 0
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 5
                
                Repeater {
                    id: suggestionRepeater
                    model: []
                    
                    Button {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        background: Rectangle {
                            color: parent.hovered ? "#89b4fa" : "#45475a"
                            radius: 4
                        }
                        
                        contentItem: Text {
                            text: modelData
                            color: "#cdd6f4"
                            font.pixelSize: 18
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            replaceCurrentWord(modelData)
                        }
                    }
                }
            }
        }
        
        // SEG OFFENDER DIJ (ASDJSAJDKLASDKHSKDASKJDKJASDHKJDSAHKJSDAHJKSADHKJHSDJKAHJKSDAHJKASDHKJDSAKJDSAHJKSDAHJKSDAJHKDSAHJKASDHJKASDHJKSDAHJKSADHSDAHKJSDHAJKHSADSA) 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 5
            
            // DIJ 1: GOONERS N GOOBERS (DE SCUTTLEBUG SHI) 💀💀💀😍😍😍🥵🥵🥵😭😭😭💦💦💦
            RowLayout {
                Layout.fillWidth: true
                spacing: 5
                
                Repeater {
                    model: ['`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=']
                    
                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        text: modelData
                        
                        background: Rectangle {
                            color: parent.pressed ? "#89b4fa" : (parent.hovered ? "#585b70" : "#45475a")
                            radius: 6
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "#cdd6f4"
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: textInput.insert(textInput.cursorPosition, modelData)
                    }
                }
                
                // BLJ 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
                Button {
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 50
                    text: "⌫"
                    
                    background: Rectangle {
                        color: parent.pressed ? "#f38ba8" : (parent.hovered ? "#eba0ac" : "#45475a")
                        radius: 6
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "#cdd6f4"
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        if (textInput.cursorPosition > 0) {
                            textInput.remove(textInput.cursorPosition - 1, textInput.cursorPosition)
                        }
                    }
                }
            }
            
            // DIJ 2: BABOIL DIJ 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
            RowLayout {
                Layout.fillWidth: true
                spacing: 5
                
                Item { Layout.preferredWidth: 30 }
                
                Repeater {
                    model: ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\\']
                    
                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        text: applyCase(modelData)
                        
                        background: Rectangle {
                            color: parent.pressed ? "#89b4fa" : (parent.hovered ? "#585b70" : "#45475a")
                            radius: 6
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "#cdd6f4"
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            textInput.insert(textInput.cursorPosition, text)
                            if (shiftPressed && !capsLock) shiftPressed = false
                        }
                    }
                }
            }
            
            // DIJ 3: DKJ S Z. 😑
            RowLayout {
                Layout.fillWidth: true
                spacing: 5
                
                // YEET DE BABY OIL PLATFORM UUP ILE LOCKING DE GOOBERRS IN M1274 SPD 😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶😶
                Button {
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 50
                    text: capsLock ? "⇪" : "⇧"
                    
                    background: Rectangle {
                        color: capsLock ? "#89b4fa" : (parent.pressed ? "#89b4fa" : (parent.hovered ? "#585b70" : "#45475a"))
                        radius: 6
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "#cdd6f4"
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        if (shiftPressed) {
                            capsLock = !capsLock
                            shiftPressed = false
                        } else {
                            shiftPressed = true
                        }
                    }
                }
                
                Repeater {
                    model: ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'']
                    
                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        text: applyCase(modelData)
                        
                        background: Rectangle {
                            color: parent.pressed ? "#89b4fa" : (parent.hovered ? "#585b70" : "#45475a")
                            radius: 6
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "#cdd6f4"
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            textInput.insert(textInput.cursorPosition, text)
                            if (shiftPressed && !capsLock) shiftPressed = false
                        }
                    }
                }
                
                // YEET TO UNSCUTTLEBUG PU 🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩🤩
                Button {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 50
                    text: "↵"
                    
                    background: Rectangle {
                        color: parent.pressed ? "#a6e3a1" : (parent.hovered ? "#94e2d5" : "#45475a")
                        radius: 6
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "#cdd6f4"
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: textInput.insert(textInput.cursorPosition, '\n')
                }
            }
            
            // BRUTALLY DIDDLE THE MAPS ILE DIDDLING DE BABY OIL ILE DRINKING SOME MEDICINE FOR THE DIH TO GOON ITSELF 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍
            RowLayout {
                Layout.fillWidth: true
                spacing: 5
                
                Item { Layout.preferredWidth: 60 }
                
                Repeater {
                    model: ['z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/']
                    
                    Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        text: applyCase(modelData)
                        
                        background: Rectangle {
                            color: parent.pressed ? "#89b4fa" : (parent.hovered ? "#585b70" : "#45475a")
                            radius: 6
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            color: "#cdd6f4"
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            textInput.insert(textInput.cursorPosition, text)
                            if (shiftPressed && !capsLock) shiftPressed = false
                        }
                    }
                }
                
                Item { Layout.preferredWidth: 60 }
            }
            
            // BRUTALLY DIDDLE DE FART DE BLJ A SCUTLEBUG IN A PU 🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
            RowLayout {
                Layout.fillWidth: true
                spacing: 5
                
                Item { Layout.preferredWidth: 100 }
                
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    text: "YOSHI SPACE 🦕💚"
                    
                    background: Rectangle {
                        color: parent.pressed ? "#a6e3a1" : (parent.hovered ? "#94e2d5" : "#45475a")
                        radius: 6
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        color: "#cdd6f4"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: textInput.insert(textInput.cursorPosition, ' ')
                }
                
                Item { Layout.preferredWidth: 100 }
            }
        }
    }
    IpcHandler {
        target: halal

        function diddleDeVanishCapInAYaYaYaYaYaYaYaYaYaYaYaYaVinXPErrorSFX() {
            dihOskRootFrFrNoCapBestie.visible = !dihOskRootFrFrNoCapBestie.visible
        }
    }
}