import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.common
import qs.common.widgets
import "../../resources/colors.js" as Palette

TextField {
    id: filterField

    property alias colBackground: background.color

    Layout.fillHeight: true
    implicitWidth: 200
    padding: 10

    placeholderTextColor: AppearanceRippleButton.colors.colSubtext
    color: AppearanceRippleButton.colors.colOnLayer1
    font.pixelSize: AppearanceRippleButton.font.pixelSize.small
    renderType: Text.NativeRendering
    selectedTextColor: AppearanceRippleButton.colors.colOnSecondaryContainer
    selectionColor: AppearanceRippleButton.colors.colSecondaryContainer

    background: Rectangle {
        id: background
        color: Palette.palette().surfaceContainer
        radius: Appearance.rounding.full
    }
}