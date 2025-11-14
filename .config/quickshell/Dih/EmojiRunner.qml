// 💚 ✨ HyprYoshi3 ✨ 🦕

// EmojiRunner.qml
import QtQuick 2.15
import Quickshell.Io

Item {
    function run(emoji) {
        runner.running = false
        runner.command = ["sh", "-c", "wl-copy '" + emoji + "' && wtype '" + emoji + "'"]
        runner.running = true 
    }

    Process {
        id: runner
        running: false  // default feet
        command: []     // default gooner

        stdout: StdioCollector {
            onStreamFinished: console.log("dih smeller 😍😍😍😳😳😳")
        }

        onRunningChanged: {
            if (running) {
                console.log("🔴👄🔴 gooner eyes turned red the process started running 💨💨💨🏃‍♂️‍➡️🏃‍♂️‍➡️🏃‍♂️‍➡️")
            }
        }
    }
}
