import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs

BarWidgetInner {
	id: root
	required property var bar;
    // height: 57
    color: "transparent"   // removes background
    border.width: 0        // removes border

	implicitHeight: 57
	//              ⬆⬆ KINDA PERFECTLY MAKE IT GRETLY POSED AWAHAHAHA

	SystemClock {
		id: clock
		precision: tooltip.visible ? SystemClock.Seconds : SystemClock.Minutes;
	}

	/* BarButton {
		id: button
		anchors.fill: parent
		fillWindowWidth: true
		acceptedButtons: Qt.NoButton */

   	ColumnLayout {
   		// id: layout
   		spacing: 0
		Layout.bottomMargin: 10

   		anchors {
   			right: parent.right
   			left: parent.left
   		}

   		Text {
   			Layout.alignment: Qt.AlignHCenter
   			text: Qt.formatDateTime(clock.date, "hh\nmm")
   			font.pointSize: 17
			font.family: "Roboto"       // font family
   			color: "white"
   		}
   	}
	// }

	/* property TooltipItem tooltip: TooltipItem {
		id: tooltip
		tooltip: bar.tooltip
		owner: root
		show: root.containsMouse === true

		Loader {
			active: tooltip.visible
			sourceComponent: Label {
				text: Qt.formatDateTime(clock.date, "hh:mm:ss\ndddd, MMMM d, yyyy");
			}
		}
	} */ // useless (rn)
}
