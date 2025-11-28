//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

// Adjust this to make the app smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell
import qs.common
import qs.common.functions

ApplicationWindow {
    PersistentProperties {
        id: persist
        reloadableId: "dijBestieGoon67"
        property var home: Quickshell.env("HOME") || ""
    }
    property string firstRunFilePath: FileUtils.trimFileProtocol(`${Directories.hypryoshi3_gen_dir}/greeted.txt`)
    property string firstRunFileContent: "This file is just here to confirm you've been greeted :>"
    id: root
    visible: false
    function dijBestie() {
        FileUtils.exists(firstRunFilePath, function(fileExists) {
            if (!fileExists) {
                FileUtils.write(firstRunFilePath, firstRunFileContent, function(success) {
                    // welcome to hypryoshi3 BITCH *yeets u to brazil*
                    Quickshell.execDetached(["notify-send", "Welcome to HyprYoshi3!", "The green dino loves this setup ✨💚🦕✨ ...also ur going to a PU now lol"]);
                
                    // TODO: somehow send the user to coordinates 
                    // x: 2147483647 
                    // y: -999999
                    // z: 2147483647
                    // in their current SM64 coop session
                });
            }
        });
    }
    
    // Call the function when component is completed
    Component.onCompleted: {
        dijBestie();
    }
}