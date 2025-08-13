pragma ComponentBehavior: Bound;

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs
import qs.bar
import "../resources/components/actions"

FullwidthMouseArea {
    id: root
    required property var bar;
    required property int wsBaseIndex;
    property int wsCount: 10;
    property bool hideWhenEmpty: false;

    implicitHeight: column.implicitHeight + 10;

    fillWindowWidth: true
    acceptedButtons: Qt.NoButton

    property int scrollAccumulator: 0

    onWheel: event => {
        event.accepted = true;
        let acc = scrollAccumulator - event.angleDelta.y;
        const sign = Math.sign(acc);
        acc = Math.abs(acc);

        const offset = sign * Math.floor(acc / 120);
        scrollAccumulator = sign * (acc % 120);

        if (offset != 0) {
            const targetWorkspace = currentIndex + offset;
            const id = Math.max(wsBaseIndex, Math.min(wsBaseIndex + wsCount - 1, targetWorkspace));
            if (id != currentIndex) Hyprland.dispatch(`workspace ${id}`);
        }
    }

    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen);
    property int currentIndex: 0;
    property int existsCount: 0;
    /* visible: !hideWhenEmpty || existsCount > 0; */

    signal workspaceAdded(workspace: HyprlandWorkspace);

    ColumnLayout {
        id: column
        spacing: 0
        anchors {
            fill: parent;
            topMargin: 0;
            margins: 5;
        }

        Repeater {
            model: root.wsCount

            FullwidthMouseArea {
                id: wsItem
                onPressed: Hyprland.dispatch(`workspace ${wsIndex}`);

                Layout.fillWidth: true
                implicitHeight: 32 // IconButton-friendly height

                required property int index;
                property int wsIndex: root.wsBaseIndex + index;
                property HyprlandWorkspace workspace: null;
                property bool exists: workspace != null;
                property bool active: workspace?.active ?? false

                onActiveChanged: {
                    if (active) root.currentIndex = wsIndex;
                }

                onExistsChanged: {
                    root.existsCount += exists ? 1 : -1;
                }

                Connections {
                    target: root

                    function onWorkspaceAdded(workspace: HyprlandWorkspace) {
                        if (workspace.id == wsItem.wsIndex) {
                            wsItem.workspace = workspace;
                        }
                    }
                }

                property real animActive: active ? 1 : 0
                Behavior on animActive { NumberAnimation { duration: 150 } }

                property real animExists: exists ? 1 : 0
                Behavior on animExists { NumberAnimation { duration: 100 } }

                // <<< IconButton replacing the rectangle >>>
                IconButton {
                    anchors.centerIn: parent
                    width: 24
                    height: 24
                    iconSource: active ? "qrc:/icons/ws-active.png" : "qrc:/icons/ws-inactive.png"
                    scale: 1 + wsItem.animActive * 0.3
                    property bool hoverEnabled: mouseArea.hoverEnabled
                    onClicked: Hyprland.dispatch(`workspace ${wsIndex}`)
                }
            }
        }
    }

    Connections {
        target: Hyprland.workspaces

        function onObjectInsertedPost(workspace) {
            root.workspaceAdded(workspace);
        }
    }

    Component.onCompleted: {
        Hyprland.workspaces.values.forEach(workspace => {
            root.workspaceAdded(workspace)
        });
    }
}
