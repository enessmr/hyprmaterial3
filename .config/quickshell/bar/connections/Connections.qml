import QtQuick
import QtQuick.Layouts
import qs.bar
import "../../resources/colors.js" as Pallete

BarWidgetInner {
	id: root
	required property var bar;
	implicitHeight: column.implicitHeight + 10
	border.width: 0         // no border
	color: Pallete.palette().onSecondary
	radius: 999

	ColumnLayout {
		id: column

		anchors {
			fill: parent
			margins: 5
		}

		Bluetooth {
			Layout.fillWidth: true
			bar: root.bar
		}
	}
}
