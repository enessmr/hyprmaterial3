// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import qs.verticalDijBestie
import qs.common

BarWidgetInner {
	id: root
	required property var bar;
	implicitHeight: column.implicitHeight + 10;

    border.width: 0         // no border

	radius: 9999

	color: Appearance?.m3colors.m3onSecondary

	ColumnLayout {
		anchors {
			fill: parent;
			margins: 5;
		}

		id: column;
		spacing: 5;

		Loader {
			Layout.fillWidth: true;
			active: Pipewire.defaultAudioSink != null;

			sourceComponent: AudioControl {
				bar: root.bar;
				node: Pipewire.defaultAudioSink;
				icon: `${node.audio.muted ? "volume_mute" : "volume_up"}`
			}
		}

		Loader {
			Layout.fillWidth: true;
			active: Pipewire.defaultAudioSource != null;

			sourceComponent: AudioControl {
				bar: root.bar;
				node: Pipewire.defaultAudioSource;
				icon: `${node.audio.muted ? "mic_off" : "mic"}`
			}
		}
	}
}
