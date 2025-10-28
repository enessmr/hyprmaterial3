import QtQuick
import Quickshell
import Quickshell.Io
import qs.common.functions
import "../resources/colors.js" as Palette
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
	id: root
	property QtObject animation
	property QtObject animationCurves
	property QtObject colors
	property QtObject m3colors
	property QtObject rounding
	property QtObject font
	property QtObject sizes
	property string syntaxHighlightingTheme: Palette.isDarkMode() ? "Monokai" : "ayu Light"

	// Transparency. The quadratic functions were derived from analysis of hand-picked transparency values.
	ColorQuantizer {
		id: wallColorQuant
		source: Qt.resolvedUrl(Config.options.background.wallpaperPath)
		depth: 0 // 2^0 = 1 color
		rescaleSize: 10
	}
	property real wallpaperVibrancy: (wallColorQuant.colors[0]?.hslSaturation + wallColorQuant.colors[0]?.hslLightness) / 2
	property real autoBackgroundTransparency: { // y = 0.5768x^2 - 0.759x + 0.2896
		let x = wallpaperVibrancy
		let y = 0.5768 * (x * x) - 0.759 * (x) + 0.2896
		return Math.max(0, Math.min(0.22, y))
	}
	property real autoContentTransparency: { // y = -10.1734x^2 + 3.4457x + 0.1872
		let x = autoBackgroundTransparency
		let y = -10.1734 * (x * x) + 3.4457 * (x) + 0.1872
		return Math.max(0, Math.min(0.6, y))
	}
	property real backgroundTransparency: Config?.options.appearance.transparency.enable ? Config?.options.appearance.transparency.automatic ? autoBackgroundTransparency : Config?.options.appearance.transparency.backgroundTransparency : 0
	property real contentTransparency: Config?.options.appearance.transparency.enable ? Config?.options.appearance.transparency.automatic ? autoContentTransparency : Config?.options.appearance.transparency.contentTransparency : 0

	m3colors: QtObject {
		property color primary: Palette.palette().primary
		property color onPrimary: Palette.palette().onPrimary
		property color primaryContainer: Palette.palette().primaryContainer
		property color onPrimaryContainer: Palette.palette().onPrimaryContainer

		property color secondary: Palette.palette().secondary
		property color onSecondary: Palette.palette().onSecondary
		property color secondaryContainer: Palette.palette().secondaryContainer
		property color onSecondaryContainer: Palette.palette().onSecondaryContainer

		property color tertiary: Palette.palette().tertiary
		property color onTertiary: Palette.palette().onTertiary
		property color tertiaryContainer: Palette.palette().tertiaryContainer
		property color onTertiaryContainer: Palette.palette().onTertiaryContainer

		property color error: Palette.palette().error
		property color onError: Palette.palette().onError
		property color errorContainer: Palette.palette().errorContainer
		property color onErrorContainer: Palette.palette().onErrorContainer

		property color surfaceDim: Palette.palette().surfaceDim
		property color surface: Palette.palette().surface
		property color surfaceBright: Palette.palette().surfaceBright
		property color surfaceContainerLowest: Palette.palette().surfaceContainerLowest
		property color surfaceContainerLow: Palette.palette().surfaceContainerLow
		property color surfaceContainer: Palette.palette().surfaceContainer
		property color surfaceContainerHigh: Palette.palette().surfaceContainerHigh
		property color surfaceContainerHighest: Palette.palette().surfaceContainerHighest

		property color surfaceVariant: Palette.palette().surfaceVariant
		property color surfaceTint: Palette.palette().surfaceTint
		property color background: Palette.palette().background
		property color onBackground: Palette.palette().onBackground
		property color onSurface: Palette.palette().onSurface
		property color onSurfaceVariant: Palette.palette().onSurfaceVariant

		property color inverseSurface: Palette.palette().inverseSurface
		property color inverseOnSurface: Palette.palette().inverseOnSurface
		property color inversePrimary: Palette.palette().inversePrimary

		property color primaryFixed: Palette.palette().primaryFixed
		property color primaryFixedDim: Palette.palette().primaryFixedDim
		property color onPrimaryFixed: Palette.palette().onPrimaryFixed
		property color onPrimaryFixedVariant: Palette.palette().onPrimaryFixedVariant

		property color secondaryFixed: Palette.palette().secondaryFixed
		property color secondaryFixedDim: Palette.palette().secondaryFixedDim
		property color onSecondaryFixed: Palette.palette().onSecondaryFixed
		property color onSecondaryFixedVariant: Palette.palette().onSecondaryFixedVariant

		property color tertiaryFixed: Palette.palette().tertiaryFixed
		property color tertiaryFixedDim: Palette.palette().tertiaryFixedDim
		property color onTertiaryFixed: Palette.palette().onTertiaryFixed
		property color onTertiaryFixedVariant: Palette.palette().onTertiaryFixedVariant

		property color outline: Palette.palette().outline
		property color outlineVariant: Palette.palette().outlineVariant

		property color scrim: Palette.palette().scrim
		property color shadow: Palette.palette().shadow

		property color sourceColor: Palette.palette().sourceColor
	}

	colors: QtObject {
		property color colLayer2NoAlpha: Palette.palette().surface
		property color colSubtext: Palette.palette().outline
		property color colLayer0: ColorUtils.mix(ColorUtils.transparentize(Palette.palette().background, root.backgroundTransparency), Palette.palette().primary, Config.options.appearance.extraBackgroundTint ? 0.99 : 1)
		property color colOnLayer0: Palette.palette().onBackground
		property color colLayer0Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer0, colOnLayer0, 0.9), root.contentTransparency)
		property color colLayer0Active: ColorUtils.transparentize(ColorUtils.mix(colLayer0, colOnLayer0, 0.8), root.contentTransparency)
		property color colLayer0Border: ColorUtils.mix(Palette.palette().outlineVariant, colLayer0, 0.4)
		property color colLayer1: ColorUtils.transparentize(Palette.palette().surfaceContainerLow, root.contentTransparency)
		property color colOnLayer1: Palette.palette().onSurfaceVariant
		property color colOnLayer1Inactive: ColorUtils.mix(colOnLayer1, colLayer1, 0.45);
		property color colLayer2: ColorUtils.transparentize(Palette.palette().surfaceContainer, root.contentTransparency)
		property color colOnLayer2: Palette.palette().onSurface;
		property color colOnLayer2Disabled: ColorUtils.mix(colOnLayer2, Palette.palette().background, 0.4);
		property color colLayer1Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.92), root.contentTransparency)
		property color colLayer1Active: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.85), root.contentTransparency);
		property color colLayer2Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.90), root.contentTransparency)
		property color colLayer2Active: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.80), root.contentTransparency);
		property color colLayer2Disabled: ColorUtils.transparentize(ColorUtils.mix(colLayer2, Palette.palette().background, 0.8), root.contentTransparency);
		property color colLayer3: ColorUtils.transparentize(Palette.palette().surfaceContainerHigh, root.contentTransparency)
		property color colOnLayer3: Palette.palette().onSurface;
		property color colLayer3Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer3, colOnLayer3, 0.90), root.contentTransparency)
		property color colLayer3Active: ColorUtils.transparentize(ColorUtils.mix(colLayer3, colOnLayer3, 0.80), root.contentTransparency);
		property color colLayer4: ColorUtils.transparentize(Palette.palette().surfaceContainerHighest, root.contentTransparency)
		property color colOnLayer4: Palette.palette().onSurface;
		property color colLayer4Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer4, colOnLayer4, 0.90), root.contentTransparency)
		property color colLayer4Active: ColorUtils.transparentize(ColorUtils.mix(colLayer4, colOnLayer4, 0.80), root.contentTransparency);
		property color colPrimary: Palette.palette().primary
		property color colOnPrimary: Palette.palette().onPrimary
		property color colPrimaryHover: ColorUtils.mix(colPrimary, colLayer1Hover, 0.87)
		property color colPrimaryActive: ColorUtils.mix(colPrimary, colLayer1Active, 0.7)
		property color colPrimaryContainer: Palette.palette().primaryContainer
		property color colPrimaryContainerHover: ColorUtils.mix(colPrimaryContainer, colLayer1Hover, 0.7)
		property color colPrimaryContainerActive: ColorUtils.mix(colPrimaryContainer, colLayer1Active, 0.6)
		property color colOnPrimaryContainer: Palette.palette().onPrimaryContainer
		property color colSecondary: Palette.palette().secondary
		property color colSecondaryHover: ColorUtils.mix(colSecondary, colLayer1Hover, 0.85)
		property color colSecondaryActive: ColorUtils.mix(colSecondary, colLayer1Active, 0.4)
		property color colSecondaryContainer: Palette.palette().secondaryContainer
		property color colSecondaryContainerHover: ColorUtils.mix(colSecondaryContainer, Palette.palette().onSecondaryContainer, 0.90)
		property color colSecondaryContainerActive: ColorUtils.mix(colSecondaryContainer, colLayer1Active, 0.54)
		property color colOnSecondaryContainer: Palette.palette().onSecondaryContainer
		property color colSurfaceContainerLow: ColorUtils.transparentize(Palette.palette().surfaceContainerLow, root.contentTransparency)
		property color colSurfaceContainer: ColorUtils.transparentize(Palette.palette().surfaceContainer, root.contentTransparency)
		property color colSurfaceContainerHigh: ColorUtils.transparentize(Palette.palette().surfaceContainerHigh, root.contentTransparency)
		property color colSurfaceContainerHighest: ColorUtils.transparentize(Palette.palette().surfaceContainerHighest, root.contentTransparency)
		property color colSurfaceContainerHighestHover: ColorUtils.mix(Palette.palette().surfaceContainerHighest, Palette.palette().onSurface, 0.95)
		property color colSurfaceContainerHighestActive: ColorUtils.mix(Palette.palette().surfaceContainerHighest, Palette.palette().onSurface, 0.85)
		property color colOnSurface: Palette.palette().onSurface
		property color colOnSurfaceVariant: Palette.palette().onSurfaceVariant
		property color colTooltip: Palette.palette().inverseSurface
		property color colOnTooltip: Palette.palette().inverseOnSurface
		property color colScrim: ColorUtils.transparentize(Palette.palette().scrim, 0.5)
		property color colShadow: ColorUtils.transparentize(Palette.palette().shadow, 0.7)
		property color colOutlineVariant: Palette.palette().outlineVariant
		property color colError: Palette.palette().error
		property color colErrorHover: ColorUtils.mix(colError, colLayer1Hover, 0.85)
		property color colErrorActive: ColorUtils.mix(colError, colLayer1Active, 0.7)
		property color colOnError: Palette.palette().onError
		property color colErrorContainer: Palette.palette().errorContainer
		property color colErrorContainerHover: ColorUtils.mix(colErrorContainer, Palette.palette().onErrorContainer, 0.90)
		property color colErrorContainerActive: ColorUtils.mix(colErrorContainer, Palette.palette().onErrorContainer, 0.70)
		property color colOnErrorContainer: Palette.palette().onErrorContainer
	}

	rounding: QtObject {
		property int unsharpen: 2
		property int unsharpenmore: 6
		property int verysmall: 8
		property int small: 12
		property int normal: 17
		property int large: 23
		property int verylarge: 30
		property int full: 9999
		property int screenRounding: large
		property int windowRounding: 18
	}

	font: QtObject {
		property QtObject family: QtObject {
			property string main: "Rubik"
			property string title: "Gabarito"
			property string iconMaterial: "Material Symbols Outlined"
			property string iconNerd: "SpaceMono NF"
			property string monospace: "JetBrains Mono NF"
			property string reading: "Readex Pro"
			property string expressive: "Space Grotesk"
		}
		property QtObject pixelSize: QtObject {
			property int smallest: 10
			property int smaller: 12
			property int small: 15
			property int normal: 16
			property int large: 17
			property int larger: 19
			property int huge: 22
			property int hugeass: 23
			property int title: huge
		}
	}

	animationCurves: QtObject {
		readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.90, 1, 1] // Default, 350ms
		readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1.00, 1, 1] // Default, 500ms
		readonly property list<real> expressiveSlowSpatial: [0.39, 1.29, 0.35, 0.98, 1, 1] // Default, 650ms
		readonly property list<real> expressiveEffects: [0.34, 0.80, 0.34, 1.00, 1, 1] // Default, 200ms
		readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
		readonly property list<real> emphasizedFirstHalf: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82]
		readonly property list<real> emphasizedLastHalf: [5 / 24, 0.82, 0.25, 1, 1, 1]
		readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
		readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
		readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
		readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
		readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
		readonly property real expressiveFastSpatialDuration: 350
		readonly property real expressiveDefaultSpatialDuration: 500
		readonly property real expressiveSlowSpatialDuration: 650
		readonly property real expressiveEffectsDuration: 200
	}

	animation: QtObject {
		property QtObject elementMove: QtObject {
			property int duration: animationCurves.expressiveDefaultSpatialDuration
			property int type: Easing.BezierSpline
			property list<real> bezierCurve: animationCurves.expressiveDefaultSpatial
			property int velocity: 650
			property Component numberAnimation: Component {
				NumberAnimation {
					duration: root.animation.elementMove.duration
					easing.type: root.animation.elementMove.type
					easing.bezierCurve: root.animation.elementMove.bezierCurve
				}
			}
			property Component colorAnimation: Component {
				ColorAnimation {
					duration: root.animation.elementMove.duration
					easing.type: root.animation.elementMove.type
					easing.bezierCurve: root.animation.elementMove.bezierCurve
				}
			}
		}
		property QtObject elementMoveEnter: QtObject {
			property int duration: 400
			property int type: Easing.BezierSpline
			property list<real> bezierCurve: animationCurves.emphasizedDecel
			property int velocity: 650
			property Component numberAnimation: Component {
				NumberAnimation {
					duration: root.animation.elementMoveEnter.duration
					easing.type: root.animation.elementMoveEnter.type
					easing.bezierCurve: root.animation.elementMoveEnter.bezierCurve
				}
			}
		}
		property QtObject elementMoveExit: QtObject {
			property int duration: 200
			property int type: Easing.BezierSpline
			property list<real> bezierCurve: animationCurves.emphasizedAccel
			property int velocity: 650
			property Component numberAnimation: Component {
				NumberAnimation {
					duration: root.animation.elementMoveExit.duration
					easing.type: root.animation.elementMoveExit.type
					easing.bezierCurve: root.animation.elementMoveExit.bezierCurve
				}
			}
		}
		property QtObject elementMoveFast: QtObject {
			property int duration: animationCurves.expressiveEffectsDuration
			property int type: Easing.BezierSpline
			property list<real> bezierCurve: animationCurves.expressiveEffects
			property int velocity: 850
			property Component colorAnimation: Component {
				ColorAnimation {
					duration: root.animation.elementMoveFast.duration
					easing.type: root.animation.elementMoveFast.type
					easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
				}
			}
			property Component numberAnimation: Component {
				NumberAnimation {
					duration: root.animation.elementMoveFast.duration
					easing.type: root.animation.elementMoveFast.type
					easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
				}
			}
		}
		property QtObject clickBounce: QtObject {
			property int duration: 200
			property int type: Easing.BezierSpline
			property list<real> bezierCurve: animationCurves.expressiveFastSpatial
			property int velocity: 850
			property Component numberAnimation: Component {
				NumberAnimation {
					duration: root.animation.clickBounce.duration
					easing.type: root.animation.clickBounce.type
					easing.bezierCurve: root.animation.clickBounce.bezierCurve
				}
			}
		}
		property QtObject scroll: QtObject {
			property int duration: 200
			property int type: Easing.BezierSpline
			property list<real> bezierCurve: animationCurves.standardDecel
		}
		property QtObject menuDecel: QtObject {
			property int duration: 350
			property int type: Easing.OutExpo
		}
	}

	sizes: QtObject {
		property real baseBarHeight: 40
		property real barHeight: Config.options.bar.cornerStyle === 1 ?
			(baseBarHeight + root.sizes.hyprlandGapsOut * 2) : baseBarHeight
		property real barCenterSideModuleWidth: Config.options?.bar.verbose ? 360 : 140
		property real barCenterSideModuleWidthShortened: 280
		property real barCenterSideModuleWidthHellaShortened: 190
		property real barShortenScreenWidthThreshold: 1200 // Shorten if screen width is at most this value
		property real barHellaShortenScreenWidthThreshold: 1000 // Shorten even more...
		property real elevationMargin: 10
		property real fabShadowRadius: 5
		property real fabHoveredShadowRadius: 7
		property real hyprlandGapsOut: 5
		property real mediaControlsWidth: 440
		property real mediaControlsHeight: 160
		property real notificationPopupWidth: 410
		property real osdWidth: 200
		property real searchWidthCollapsed: 260
		property real searchWidth: 450
		property real sidebarWidth: 460
		property real sidebarWidthExtended: 750
		property real baseVerticalBarWidth: 46
		property real verticalBarWidth: Config.options.bar.cornerStyle === 1 ?
			(baseVerticalBarWidth + root.sizes.hyprlandGapsOut * 2) : baseVerticalBarWidth
	}
}