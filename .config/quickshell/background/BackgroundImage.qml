import QtQuick
import Quickshell
import qs.lock as Lock

Item {
	id: root

	required property ShellScreen screen;
	property real slideAmount: 1.0 - Lock.Controller.bkgSlide
	property alias asynchronous: image.asynchronous;

	readonly property real remainingSize: image.sourceSize.height - root.height

	Image {
    	id: image
    	source: Qt.resolvedUrl("pics-default-mod/wallpaper.jpg")
    	fillMode: Image.PreserveAspectCrop
    	anchors.fill: parent
    	asynchronous: true
	}
}
