import QtQuick
import Quickshell
import qs.common
import qs.common.functions
import qs.common.widgets

StyledText {
    text: "Dialog Title"
    color: Appearance.colors.colOnSurface
    wrapMode: Text.Wrap
    font {
        family: Appearance.font.family.title
        pixelSize: Appearance.font.pixelSize.title
        variableAxes: Appearance.font.variableAxes.title
    }
}
