import qs.services
import qs.common
import qs.common.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.synchronizer
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Item {
    id: root
    property real spacing: 20
    property real titleSpacing: 7
    property real padding: 4
    implicitWidth: row.implicitWidth + padding * 2
    implicitHeight: row.implicitHeight + padding * 2
    
    StyledText {
        anchors.centerIn: parent
        font.pixelSize: 72
        text: "Dij bestie in develop dijj dijj 🏗️🏗️🏗️"
    }

}
