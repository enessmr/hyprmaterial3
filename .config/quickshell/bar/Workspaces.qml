pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs
import qs.bar
import "../resources/colors.js" as Pallete

FullwidthMouseArea {
    id: root

    required property var bar;
    required property int wsBaseIndex;
    property int wsCount: 10;
    property bool hideWhenEmpty: false;
    property bool alwaysShowNumbers: false;
    property bool showNumbers: false;
    property bool showAppIcons: false;

    implicitHeight: column.implicitHeight + 10;
    fillWindowWidth: true;
    acceptedButtons: Qt.NoButton;

    property int scrollAccumulator: 0;
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

                Layout.fillWidth: true;
                implicitHeight: 32;

                required property int index;
                property int wsIndex: root.wsBaseIndex + index;
                property HyprlandWorkspace workspace: null;
                property bool exists: workspace !== null;
                property bool active: workspace?.active ?? false;
                property bool hasWindows: (workspace?.windows?.length > 0);

                onActiveChanged: {
                    if (active) root.currentIndex = wsIndex;
                }

                onExistsChanged: {
                    root.existsCount += exists ? 1 : -1;
                }

                Connections {
                    target: root
                    function onWorkspaceAdded(workspace) {
                        if (workspace.id === wsItem.wsIndex) {
                            wsItem.workspace = workspace;
                        }
                    }
                }

                property real animActive: active ? 1 : 0;
                Behavior on animActive {
                    NumberAnimation { duration: 150 }
                }

                property real animExists: exists ? 1 : 0;
                Behavior on animExists {
                    NumberAnimation { duration: 100 }
                }

                Item {
                    id: button
                    anchors.centerIn: parent
                    width: 24
                    height: 24

                    // Background circle
                    Rectangle {
                        id: bg
                        anchors.fill: parent
                        radius: width / 2
                        color: wsItem.active ? Pallete.palette().primary : Pallete.palette().surface
                        opacity: 1
                        antialiasing: true
                    }

                    // Dot for all workspaces - always visible
                    Rectangle {
                        id: wsDot
                        anchors.centerIn: parent
                        width: parent.width * 0.18
                        height: width
                        radius: width / 2

                        // Always visible and fully opaque for every workspace
                        opacity: 1
                        visible: true

                        // Color changes based on active workspace status
                        color: wsItem.active ? Pallete.palette().onPrimary : Pallete.palette().onSecondaryContainer

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 150
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }

                    // Number text hidden (opacity=0)
                    Text {
                        id: numberText
                        anchors.centerIn: parent
                        text: wsIndex
                        color: wsItem.active ? Pallete.palette().onPrimary : Pallete.palette().onSurface
                        opacity: 0
                        font.pixelSize: 12
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    // Hover/press effect
                    Rectangle {
                        anchors.fill: bg
                        radius: bg.radius
                        color: Pallete.palette().onSurface
                        opacity: wsItem.containsPress ? 0.14 : (wsItem.containsMouse ? 0.06 : 0.0)
                        visible: true

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 110
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: Hyprland.workspaces;
        function onObjectInsertedPost(workspace) {
            root.workspaceAdded(workspace);
        }
    }

    Component.onCompleted: {
        Hyprland.workspaces.values.forEach(workspace => {
            root.workspaceAdded(workspace);
        });
    }
}
