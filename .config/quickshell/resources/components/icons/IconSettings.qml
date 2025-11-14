// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import qs.common
import qs.common.widgets

Item {
    id: root
    property string name: ""
    property color color: Appearance?.m3colors?.m3onSurface
    property bool active: false
    property int size: 24
    implicitWidth: size
    implicitHeight: size

    // Primary: Text with Material Symbols
    StyledText {
    id: iconText
    property real iconSize: Appearance?.font.pixelSize.small ?? 16
    property real fill: 0
    property real truncatedFill: fill.toFixed(1) // Reduce memory consumption spikes from constant font remapping
    renderType: fill !== 0 ? Text.CurveRendering : Text.NativeRendering
    font {
        hintingPreference: Font.PreferFullHinting
        family: Appearance?.font.family.iconMaterial ?? "Material Symbols Rounded"
        pixelSize: iconSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * truncatedFill
        variableAxes: { 
            "FILL": truncatedFill,
            // "wght": font.weight,
            // "GRAD": 0,
            "opsz": iconSize,
        }
    }

    Behavior on fill { // Leaky leaky, no good
        NumberAnimation {
            duration: Appearance?.animation.elementMoveFast.duration ?? 200
            easing.type: Appearance?.animation.elementMoveFast.type ?? Easing.BezierSpline
            easing.bezierCurve: Appearance?.animation.elementMoveFast.bezierCurve ?? [0.34, 0.80, 0.34, 1.00, 1, 1]
        }
    }
}

    // Fallback: Canvas (hidden unless text fails)
    Canvas {
        id: c
        anchors.fill: parent
        visible: !iconText.visible
        onPaint: {
            var ctx = getContext('2d');
            ctx.reset();
            var w = width, h = height;
            ctx.strokeStyle = root.color;
            ctx.fillStyle = root.color;
            ctx.lineWidth = Math.max(1.5, Math.min(w,h) * 0.1);

            function circle(x,y,r) { ctx.beginPath(); ctx.arc(x,y,r,0,Math.PI*2); ctx.stroke(); }
            function fillCircle(x,y,r) { ctx.beginPath(); ctx.arc(x,y,r,0,Math.PI*2); ctx.fill(); }

            switch (root.name) {
                case 'home':
                    ctx.beginPath();
                    ctx.moveTo(w*0.18, h*0.55); ctx.lineTo(w*0.50, h*0.20); ctx.lineTo(w*0.82, h*0.55);
                    ctx.moveTo(w*0.26, h*0.55); ctx.lineTo(w*0.26, h*0.80); ctx.lineTo(w*0.74, h*0.80); ctx.lineTo(w*0.74, h*0.55);
                    ctx.stroke();
                    break;
                case 'search':
                    circle(w*0.45, h*0.45, Math.min(w,h)*0.22);
                    ctx.beginPath(); ctx.moveTo(w*0.62, h*0.62); ctx.lineTo(w*0.82, h*0.82); ctx.stroke();
                    break;
                case 'person':
                    circle(w*0.5, h*0.36, Math.min(w,h)*0.18);
                    ctx.beginPath(); ctx.moveTo(w*0.20, h*0.84); ctx.quadraticCurveTo(w*0.50, h*0.60, w*0.80, h*0.84); ctx.stroke();
                    break;
                case 'flashlight':
                    ctx.beginPath();
                    ctx.moveTo(w*0.40, h*0.18); ctx.lineTo(w*0.60, h*0.18); ctx.lineTo(w*0.55, h*0.40); ctx.lineTo(w*0.45, h*0.40); ctx.closePath(); ctx.stroke();
                    ctx.beginPath(); ctx.moveTo(w*0.45, h*0.40); ctx.lineTo(w*0.55, h*0.82); ctx.stroke();
                    break;
                case 'wifi':
                    ctx.beginPath(); ctx.arc(w*0.5, h*0.70, w*0.18, Math.PI, 0); ctx.stroke();
                    ctx.beginPath(); ctx.arc(w*0.5, h*0.58, w*0.30, Math.PI, 0); ctx.stroke();
                    ctx.beginPath(); ctx.arc(w*0.5, h*0.46, w*0.42, Math.PI, 0); ctx.stroke();
                    fillCircle(w*0.5, h*0.78, w*0.04);
                    break;
                case 'bluetooth':
                    ctx.beginPath();
                    ctx.moveTo(w*0.40, h*0.20); ctx.lineTo(w*0.40, h*0.82);
                    ctx.moveTo(w*0.40, h*0.50); ctx.lineTo(w*0.65, h*0.30);
                    ctx.moveTo(w*0.40, h*0.50); ctx.lineTo(w*0.65, h*0.70);
                    ctx.stroke();
                    break;
                case 'palette':
                    var centerX = w * 0.5;
                    var centerY = h * 0.5;
                    var mainRadius = Math.min(w, h) * 0.35;
                    ctx.beginPath();
                    ctx.arc(centerX, centerY, mainRadius, 0, Math.PI * 2);
                    ctx.stroke();

                    var thumbHoleX = centerX + mainRadius * Math.cos(Math.PI / 4);
                    var thumbHoleY = centerY + mainRadius * Math.sin(Math.PI / 4);
                    var thumbRadius = Math.min(w, h) * 0.1;
                    ctx.beginPath();
                    ctx.arc(thumbHoleX, thumbHoleY, thumbRadius, 0, Math.PI * 2);
                    ctx.stroke();

                    var dotRadius = Math.min(w, h) * 0.05;
                    var dotPositions = [
                        {x: w * 0.35, y: h * 0.25},
                        {x: w * 0.65, y: h * 0.25},
                        {x: w * 0.25, y: h * 0.55},
                        {x: w * 0.75, y: h * 0.55}
                    ];
                    for (var i = 0; i < dotPositions.length; i++) {
                        fillCircle(dotPositions[i].x, dotPositions[i].y, dotRadius);
                    }
                    break;

                default:
                    var r = Math.min(w,h)*0.10;
                    fillCircle(w*0.30, h*0.5, r);
                    fillCircle(w*0.50, h*0.5, r);
                    fillCircle(w*0.70, h*0.5, r);
            }
        }
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        onVisibleChanged: requestPaint()
    }

    onNameChanged: {
        iconText.visible = true; // Try text first
        c.requestPaint(); // Update Canvas if needed
    }
    onColorChanged: {
        iconText.color = root.color;
        c.requestPaint();
    }
}