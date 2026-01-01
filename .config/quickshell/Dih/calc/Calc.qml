// 💚 ✨ HyprYoshi3 ✨ 🦕

//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
//@ pragma Env QT_SCALE_FACTOR=1

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell
import Quickshell.Io
import qs.common
import qs.common.widgets

ApplicationWindow {
    id: calcRoot
    width: 350
    height: 500
    minimumWidth: 300
    minimumHeight: 450
    visible: false
    title: "HyprYoshi3 Gooner Uncalculator 💚🦕😍💦🥵"
    flags: Qt.Window | Qt.WindowStaysOnTopHint
    
    // KEEP DAT 12 INCH DINGALING!!! 🫙🫙🫙
    property var windowGeometry: ({
        x: 100,
        y: 100,
        width: 350,
        height: 500
    })
    
    onClosing: {
        windowGeometry = {
            x: x,
            y: y,
            width: width,
            height: height
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
    
    // DIJ AREA3D DIH 💀💀💀💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦😭😭😭😭😭😭😭😭😭😭😭😭🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
    property string displayText: "0"
    property string currentOperation: ""
    property real firstNumber: 0
    property real secondNumber: 0
    property bool waitingForSecondNumber: false
    property bool justCalculated: false
    
    function appendDigit(digit) {
        if (justCalculated) {
            displayText = digit
            justCalculated = false
            return
        }
        
        if (displayText === "0" || waitingForSecondNumber) {
            displayText = digit
            waitingForSecondNumber = false
        } else {
            displayText += digit
        }
    }
    
    function appendDecimal() {
        if (justCalculated) {
            displayText = "0."
            justCalculated = false
            return
        }
        
        if (waitingForSecondNumber) {
            displayText = "0."
            waitingForSecondNumber = false
            return
        }
        
        if (displayText.indexOf(".") === -1) {
            displayText += "."
        }
    }
    
    function setOperation(op) {
        if (!waitingForSecondNumber && currentOperation !== "") {
            calculate()
        }
        
        firstNumber = parseFloat(displayText)
        currentOperation = op
        waitingForSecondNumber = true
        justCalculated = false
    }
    
    function calculate() {
        secondNumber = parseFloat(displayText)
        var result = 0
        
        switch(currentOperation) {
            case "+":
                result = firstNumber + secondNumber
                break
            case "-":
                result = firstNumber - secondNumber
                break
            case "×":
                result = firstNumber * secondNumber
                break
            case "÷":
                if (secondNumber === 0) {
                    displayText = "undefined"
                    clear()
                    return
                }
                result = firstNumber / secondNumber
                break
        }
        
        displayText = result.toString()
        currentOperation = ""
        waitingForSecondNumber = true
        justCalculated = true
    }
    
    function clear() {
        displayText = "0"
        currentOperation = ""
        firstNumber = 0
        secondNumber = 0
        waitingForSecondNumber = false
        justCalculated = false
    }
    
    function backspace() {
        if (displayText.length > 1) {
            displayText = displayText.slice(0, -1)
        } else {
            displayText = "0"
        }
    }
    
    Rectangle {
        anchors.fill: parent
        color: Appearance?.m3colors?.m3background || "#1e1e2e"
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12
            
            // FRICKING DIH OIL 💯💯💯💀💀💀💀💀💀💀💀💀💀💀💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: Appearance?.m3colors?.m3surfaceContainerHigh || "#313244"
                radius: 16
                border.color: Appearance?.m3colors?.m3outlineVariant || "#45475a"
                border.width: 2
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 8
                    
                    // CURRENT OPERATION INDICATOR 🔥
                    StyledText {
                        Layout.fillWidth: true
                        text: currentOperation !== "" ? 
                              firstNumber + " " + currentOperation : ""
                        color: Appearance?.m3colors?.m3onSurfaceVariant || "#a6adc8"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignRight
                        opacity: 0.7
                    }
                    
                    // MAIN DISPLAY 🥵🥵🥵
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        
                        StyledText {
                            id: display
                            text: calcRoot.displayText
                            color: Appearance?.m3colors?.m3onSurface || "#cdd6f4"
                            font.pixelSize: 48
                            font.bold: true
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            width: parent.width
                            wrapMode: Text.NoWrap
                            elide: Text.ElideLeft
                        }
                    }
                }
            }
            
            // DIJ OIL VERIFICATION 💀💀💀💀💀💀💀
            GridLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 4
                rowSpacing: 8
                columnSpacing: 8
                
                // DIJ 1: C, ←, %, ÷
                CalcButton {
                    text: "C"
                    isSpecial: true
                    onClicked: calcRoot.clear()
                }
                CalcButton {
                    text: "←"
                    isSpecial: true
                    onClicked: calcRoot.backspace()
                }
                CalcButton {
                    text: "%"
                    isOperator: true
                    onClicked: {
                        calcRoot.displayText = (parseFloat(calcRoot.displayText) / 100).toString()
                    }
                }
                CalcButton {
                    text: "÷"
                    isOperator: true
                    onClicked: calcRoot.setOperation("÷")
                }
                
                // DIJ 2: 7, 8, 9, ×
                CalcButton {
                    text: "7"
                    onClicked: calcRoot.appendDigit("7")
                }
                CalcButton {
                    text: "8"
                    onClicked: calcRoot.appendDigit("8")
                }
                CalcButton {
                    text: "9"
                    onClicked: calcRoot.appendDigit("9")
                }
                CalcButton {
                    text: "×"
                    isOperator: true
                    onClicked: calcRoot.setOperation("×")
                }
                
                // DIJ 3: 4, 5, 6, -
                CalcButton {
                    text: "4"
                    onClicked: calcRoot.appendDigit("4")
                }
                CalcButton {
                    text: "5"
                    onClicked: calcRoot.appendDigit("5")
                }
                CalcButton {
                    text: "6"
                    onClicked: calcRoot.appendDigit("6")
                }
                CalcButton {
                    text: "-"
                    isOperator: true
                    onClicked: calcRoot.setOperation("-")
                }
                
                // DIJ 4: 1, 2, 3, +
                CalcButton {
                    text: "1"
                    onClicked: calcRoot.appendDigit("1")
                }
                CalcButton {
                    text: "2"
                    onClicked: calcRoot.appendDigit("2")
                }
                CalcButton {
                    text: "3"
                    onClicked: calcRoot.appendDigit("3")
                }
                CalcButton {
                    text: "+"
                    isOperator: true
                    onClicked: calcRoot.setOperation("+")
                }
                
                // DIJ 5: 0 (diddles 2), ., =
                CalcButton {
                    text: "0"
                    Layout.columnSpan: 2
                    onClicked: calcRoot.appendDigit("0")
                }
                CalcButton {
                    text: "."
                    onClicked: calcRoot.appendDecimal()
                }
                CalcButton {
                    text: "="
                    isEquals: true
                    onClicked: {
                        if (calcRoot.currentOperation !== "") {
                            calcRoot.calculate()
                        }
                    }
                }
            }
        }
    }
    
    // BRUTALLY BACKSHOT DE BUTTON ILE GOONING 2 DE BABY OIL ILE 6 7 ING TO DE DIJ 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵🥵
    component CalcButton: Button {
        property bool isOperator: false
        property bool isEquals: false
        property bool isSpecial: false
        
        Layout.fillWidth: true
        Layout.fillHeight: true
        
        contentItem: StyledText {
            text: parent.text
            color: parent.isEquals ? "#1e1e2e" : (Appearance?.m3colors?.m3onSurface || "#cdd6f4")
            font.pixelSize: 24
            font.bold: parent.isOperator || parent.isEquals
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        background: Rectangle {
            color: {
                if (parent.pressed) {
                    return parent.isEquals ? Appearance.m3colors.m3Primary : 
                           parent.isOperator ? Appearance.m3colors.m3surfaceContainerHigh :
                           parent.isSpecial ? Appearance.m3colors.m3surfaceContainerHighest :
                           Appearance.m3colors.m3surface
                }
                if (parent.hovered) {
                    return parent.isEquals ? Appearance.m3colors.m3Primary:
                           parent.isOperator ? Appearance.m3colors.m3surfaceContainerHigh :
                           parent.isSpecial ? Appearance.m3colors.m3surfaceContainerHighest :
                           Appearance.m3colors.m3surface
                }
                return parent.isEquals ? Appearance.m3colors.m3Primary : 
                           parent.isOperator ? Appearance.m3colors.m3surfaceContainerHigh :
                           parent.isSpecial ? Appearance.m3colors.m3surfaceContainerHighest :
                           Appearance.m3colors.m3surface
            }
            radius: 12
            border.color: Appearance?.m3colors?.m3outlineVariant || "#45475a"
            border.width: 1
        }
    }
    
    // BRUTALLY DIDDLE DE AUTOOPENS 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️
    IpcHandler {
        target: "calculator"
        function toggle(): void {
            calcRoot.visible = !calcRoot.visible
            console.log("BRUTALLY DIDDLED DE VANISH CAP 😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀")
        }
    }
}