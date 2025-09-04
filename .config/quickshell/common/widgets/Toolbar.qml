import QtQuick
import QtQuick.Layouts
import qs.common
import qs.common.widgets
import "../../resources/colors.js" as Palette

/**
 * Material 3 expressive style toolbar.
 * https://m3.material.io/components/toolbars
 */
Item {
    id: root

    property real padding: 8
    property alias colBackground: background.color
    default property alias data: toolbarLayout.data
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    StyledRectangularShadow {
        target: background
    }

    Rectangle {
        id: background
        anchors.centerIn: parent
        color: Palette.palette().surfaceContainer // Needs to be opaque
        implicitHeight: toolbarLayout.implicitHeight + root.padding * 2
        implicitWidth: toolbarLayout.implicitWidth + root.padding * 2
        radius: Appearance.rounding.full

        RowLayout {
            id: toolbarLayout
            spacing: 4
            anchors {
                fill: parent
                margins: root.padding
            }
        }
    }
}