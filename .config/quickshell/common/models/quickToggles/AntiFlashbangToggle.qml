import QtQuick
import qs.services
import qs.common
import qs.common.functions
import qs.common.widgets

QuickToggleModel {
    name: Translation.tr("Anti-flashbang")
    tooltipText: Translation.tr("Anti-flashbang")
    icon: "flash_off"
    toggled: Config.options.light.antiFlashbang.enable

    mainAction: () => {
        Config.options.light.antiFlashbang.enable = !Config.options.light.antiFlashbang.enable;
    }
    hasMenu: true
}
