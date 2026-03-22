// 💚 ✨ HyprYoshi3 ✨ 🦕

.pragma library
// Centralized color tokens (Material 3 style). Non-QML JS module.
// Import in QML with: import "../colors.js" as Palette

var isDark = true;

var light = {
    primary: "#006972",
    onPrimary: "#ffffff",
    primaryContainer: "#9df0fb",
    onPrimaryContainer: "#001f23",

    secondary: "#4a6366",
    onSecondary: "#ffffff",
    secondaryContainer: "#cde7eb",
    onSecondaryContainer: "#051f22",

    tertiary: "#515e7d",
    onTertiary: "#ffffff",
    tertiaryContainer: "#d9e2ff",
    onTertiaryContainer: "#0d1b36",

    error: "#ba1a1a",
    onError: "#ffffff",
    errorContainer: "#ffdad6",
    onErrorContainer: "#410002",

    surfaceDim: "#d5dbdc",
    surface: "#f5fafb",
    surfaceBright: "#f5fafb",
    surfaceContainerLowest: "#ffffff",
    surfaceContainerLow: "#eff5f5",
    surfaceContainer: "#e9eff0",
    surfaceContainerHigh: "#e3e9ea",
    surfaceContainerHighest: "#dee4e4",

    surfaceVariant: "#dbe4e6",
    surfaceTint: "#006972",
    background: "#f5fafb",
    onBackground: "#171d1e",
    onSurface: "#171d1e",
    onSurfaceVariant: "#3f484a",

    inverseSurface: "#2b3132",
    inverseOnSurface: "#ecf2f3",
    inversePrimary: "#81d3de",

    primaryFixed: "#9df0fb",
    primaryFixedDim: "#81d3de",
    onPrimaryFixed: "#001f23",
    onPrimaryFixedVariant: "#004f56",

    secondaryFixed: "#cde7eb",
    secondaryFixedDim: "#b1cbcf",
    onSecondaryFixed: "#051f22",
    onSecondaryFixedVariant: "#324b4e",

    tertiaryFixed: "#d9e2ff",
    tertiaryFixedDim: "#b9c6ea",
    onTertiaryFixed: "#0d1b36",
    onTertiaryFixedVariant: "#394664",

    outline: "#6f797a",
    outlineVariant: "#bec8ca",

    scrim: "#000000",
    shadow: "#000000",

    sourceColor: "#60a3ac"
};

var dark = {
    primary: "#81d3de",
    onPrimary: "#00363c",
    primaryContainer: "#004f56",
    onPrimaryContainer: "#9df0fb",

    secondary: "#b1cbcf",
    onSecondary: "#1c3437",
    secondaryContainer: "#324b4e",
    onSecondaryContainer: "#cde7eb",

    tertiary: "#b9c6ea",
    onTertiary: "#23304d",
    tertiaryContainer: "#394664",
    onTertiaryContainer: "#d9e2ff",

    error: "#ffb4ab",
    onError: "#690005",
    errorContainer: "#93000a",
    onErrorContainer: "#ffdad6",

    surfaceDim: "#0e1415",
    surface: "#0e1415",
    surfaceBright: "#343a3b",
    surfaceContainerLowest: "#090f10",
    surfaceContainerLow: "#171d1e",
    surfaceContainer: "#1b2122",
    surfaceContainerHigh: "#252b2c",
    surfaceContainerHighest: "#303637",

    surfaceVariant: "#3f484a",
    surfaceTint: "#81d3de",
    background: "#0e1415",
    onBackground: "#dee4e4",
    onSurface: "#dee4e4",
    onSurfaceVariant: "#bec8ca",

    inverseSurface: "#dee4e4",
    inverseOnSurface: "#2b3132",
    inversePrimary: "#006972",

    primaryFixed: "#9df0fb",
    primaryFixedDim: "#81d3de",
    onPrimaryFixed: "#001f23",
    onPrimaryFixedVariant: "#004f56",

    secondaryFixed: "#cde7eb",
    secondaryFixedDim: "#b1cbcf",
    onSecondaryFixed: "#051f22",
    onSecondaryFixedVariant: "#324b4e",

    tertiaryFixed: "#d9e2ff",
    tertiaryFixedDim: "#b9c6ea",
    onTertiaryFixed: "#0d1b36",
    onTertiaryFixedVariant: "#394664",

    outline: "#899294",
    outlineVariant: "#3f484a",

    scrim: "#000000",
    shadow: "#000000",

    sourceColor: "#60a3ac"
};

function setDarkMode(darkMode) { isDark = !!darkMode; }
function toggleMode() { isDark = !isDark; }
function palette() { return isDark ? dark : light; }
function isDarkMode() { return isDark; }

// Optional direct tokens (static snapshot at load)
var primary = palette().primary;
var onPrimary = palette().onPrimary;