import QtQuick
import Quickshell
import qs
import qs.services
import qs.common
import qs.common.functions
import qs.common.widgets

QuickToggleModel {
    name: Translation.tr("Keep awake")

    toggled: Idle.inhibit
    icon: "coffee"
    mainAction: () => {
        Idle.toggleInhibit()
    }
    tooltipText: Translation.tr("Keep system awake")
}
