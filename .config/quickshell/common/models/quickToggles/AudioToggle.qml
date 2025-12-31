import QtQuick
import qs.services
import qs.common
import qs.common.functions
import qs.common.widgets

QuickToggleModel {
    name: Translation.tr("Audio output")
    statusText: toggled ? Translation.tr("Unmuted") : Translation.tr("Muted")
    tooltipText: Translation.tr("Audio output | Right-click for volume mixer & device selector")
    toggled: !Audio.sink?.audio?.muted
    icon: Audio.sink?.audio?.muted ? "volume_off" : "volume_up"
    mainAction: () => {
        Audio.toggleMute()
    }
    hasMenu: true
}
