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
        running: false  // default
        command: []     // default empty

        stdout: StdioCollector {
            onStreamFinished: console.log("done!")
        }

        onRunningChanged: {
            if (running) {
                console.log("process started")
            }
        }
    }
}
