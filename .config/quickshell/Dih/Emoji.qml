import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 320
    height: 220
    title: "Emoji Picker Copy & Type"

    property string selectedEmoji: "😄"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        ComboBox {
            id: emojiCombo
            Layout.fillWidth: true
            model: ["😄", "🥺", "🔥", "💀", "🎉", "❤️", "👋", "🍕"]
            currentIndex: 0
            onCurrentIndexChanged: {
                selectedEmoji = emojiCombo.currentText
            }
        }

        Button {
            text: "Copy + Type Emoji"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                // Copy emoji to clipboard using wl-copy
                var copyProc = Qt.createQmlObject('import QtQml 2.0; QtObject {}', emojiCombo);
                copyProc.process = Qt.createQmlObject('import QtQml 2.0; QtObject {}', emojiCombo);
                copyProc.process = Qt.createQmlObject("import QtQml 2.0; QtObject { }", emojiCombo);  // dummy for QProcess style
                var proc = Qt.createQmlObject('import QtQml 2.0; QtObject { property var process; }', emojiCombo);

                var process = Qt.createQmlObject('import QtQuick 2.0; QtProcess {}', emojiCombo);
                process = new QProcess();
                process.start("wl-copy", [selectedEmoji]);

                // Since QProcess not officially available in plain QML quickly, fallback to JS trick below:

                var wlcopy = "echo '" + selectedEmoji + "' | wl-copy";
                var wtypecmd = "wtype '" + selectedEmoji + "'";

                // Run wl-copy
                var copy = Qt.createQmlObject('import QtQml 2.0; QtObject {}', emojiCombo);
                copy.exec = function(command) {
                    var proc = new QProcess();
                    proc.start(command, []);
                }

                // But w/o native qprocess, best to use Qt.system() or Qt.platform.os hooks or run external helper

                // Here's the real workable way:
                var res1 = Qt.callLater(function() {
                    Qt.openUrlExternally("sh -c \"" + wlcopy + "\"");
                });
                var res2 = Qt.callLater(function() {
                    Qt.openUrlExternally("sh -c \"" + wtypecmd + "\"");
                });
            }
        }

        Text {
            text: selectedEmoji
            font.pixelSize: 72
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignHCenter
            width: parent.width
        }
    }
}
