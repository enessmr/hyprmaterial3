// 💚 ✨ HyprYoshi3 ✨ 🦕

.pragma library
// Centralized color tokens (Material 3 style). Non-QML JS module.
// Import in QML with: import "../colors.js" as Palette

var isDark = true;

var light = {
    primary: "#006878",
    onPrimary: "#ffffff",
    primaryContainer: "#a7eeff",
    onPrimaryContainer: "#001f25",

    secondary: "#4b6268",
    onSecondary: "#ffffff",
    secondaryContainer: "#cde7ee",
    onSecondaryContainer: "#051f24",

    tertiary: "#555d7e",
    onTertiary: "#ffffff",
    tertiaryContainer: "#dce1ff",
    onTertiaryContainer: "#121a37",

    error: "#ba1a1a",
    onError: "#ffffff",
    errorContainer: "#ffdad6",
    onErrorContainer: "#410002",

    surfaceDim: "#d5dbdd",
    surface: "#f5fafc",
    surfaceBright: "#f5fafc",
    surfaceContainerLowest: "#ffffff",
    surfaceContainerLow: "#eff4f6",
    surfaceContainer: "#e9eff1",
    surfaceContainerHigh: "#e4e9eb",
    surfaceContainerHighest: "#dee3e5",

    surfaceVariant: "#dbe4e7",
    surfaceTint: "#006878",
    background: "#f5fafc",
    onBackground: "#171d1e",
    onSurface: "#171d1e",
    onSurfaceVariant: "#3f484b",

    inverseSurface: "#2b3133",
    inverseOnSurface: "#ecf2f3",
    inversePrimary: "#83d2e5",

    primaryFixed: "#a7eeff",
    primaryFixedDim: "#83d2e5",
    onPrimaryFixed: "#001f25",
    onPrimaryFixedVariant: "#004e5b",

    secondaryFixed: "#cde7ee",
    secondaryFixedDim: "#b2cbd2",
    onSecondaryFixed: "#051f24",
    onSecondaryFixedVariant: "#334a50",

    tertiaryFixed: "#dce1ff",
    tertiaryFixedDim: "#bdc5eb",
    onTertiaryFixed: "#121a37",
    onTertiaryFixedVariant: "#3e4565",

    outline: "#6f797b",
    outlineVariant: "#bfc8cb",

    scrim: "#000000",
    shadow: "#000000",

    sourceColor: "#77acb9"
};

var dark = {
    primary: "#83d2e5",
    onPrimary: "#00363f",
    primaryContainer: "#004e5b",
    onPrimaryContainer: "#a7eeff",

    secondary: "#b2cbd2",
    onSecondary: "#1c3439",
    secondaryContainer: "#334a50",
    onSecondaryContainer: "#cde7ee",

    tertiary: "#bdc5eb",
    onTertiary: "#272f4d",
    tertiaryContainer: "#3e4565",
    onTertiaryContainer: "#dce1ff",

    error: "#ffb4ab",
    onError: "#690005",
    errorContainer: "#93000a",
    onErrorContainer: "#ffdad6",

    surfaceDim: "#0f1416",
    surface: "#0f1416",
    surfaceBright: "#343a3c",
    surfaceContainerLowest: "#090f11",
    surfaceContainerLow: "#171d1e",
    surfaceContainer: "#1b2122",
    surfaceContainerHigh: "#252b2d",
    surfaceContainerHighest: "#303637",

    surfaceVariant: "#3f484b",
    surfaceTint: "#83d2e5",
    background: "#0f1416",
    onBackground: "#dee3e5",
    onSurface: "#dee3e5",
    onSurfaceVariant: "#bfc8cb",

    inverseSurface: "#dee3e5",
    inverseOnSurface: "#2b3133",
    inversePrimary: "#006878",

    primaryFixed: "#a7eeff",
    primaryFixedDim: "#83d2e5",
    onPrimaryFixed: "#001f25",
    onPrimaryFixedVariant: "#004e5b",

    secondaryFixed: "#cde7ee",
    secondaryFixedDim: "#b2cbd2",
    onSecondaryFixed: "#051f24",
    onSecondaryFixedVariant: "#334a50",

    tertiaryFixed: "#dce1ff",
    tertiaryFixedDim: "#bdc5eb",
    onTertiaryFixed: "#121a37",
    onTertiaryFixedVariant: "#3e4565",

    outline: "#899295",
    outlineVariant: "#3f484b",

    scrim: "#000000",
    shadow: "#000000",

    sourceColor: "#77acb9"
};

function setDarkMode(darkMode) { isDark = !!darkMode; }
function toggleMode() { isDark = !isDark; }
function palette() { return isDark ? dark : light; }
function isDarkMode() { return isDark; }

// Optional direct tokens (static snapshot at load)
var primary = palette().primary;
var onPrimary = palette().onPrimary;
