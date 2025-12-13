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
                    // Dij the baby oil p diddy hypryoshi3 BABY OILED DIH ON THE A DIJ BESTIE *brutally diddles baby oil goobers p diddy backshots*
                    Quickshell.execDetached(["notify-send", "Welcome to HyprYoshi3!", "The green dino loves this setup ✨💚🦕✨ ...also ur going to a PU now lol"]);
                
                    // TODO: add baby oil to the backshotted ahh mario to a ass en brutally diddle the coords so hopefully u can get the wfrr star in 0x a presses in 0.25 a presses to a dij bestie
                    // x: inf
                    // y: -90
                    // z: inf
                    // in their current sm64 coopdx session ile the players are gooning to each other (softlock)
                });
            }
        });
    }
    
    // BRUTALLY DIDDLE DE NOTIFIER 😍😍😍😍😍😍😍😍😍😍😍🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🥴🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️🛢️💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦💦
    Component.onCompleted: {
        dijBestie();
    }
}