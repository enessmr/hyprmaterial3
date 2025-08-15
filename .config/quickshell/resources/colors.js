.pragma library
// Centralized color tokens (Material 3 style). Non-QML JS module.
// Import in QML with: import "../colors.js" as Palette

var isDark = true; // dark to dark mode

var light = {
    primary: "#006876",
    onPrimary: "#ffffff",
    primaryContainer: "#a1efff",
    onPrimaryContainer: "#001f25",

    secondary: "#4a6268",
    onSecondary: "#ffffff",
    secondaryContainer: "#cde7ed",
    onSecondaryContainer: "#051f23",

    tertiary: "#545d7e",
    onTertiary: "#ffffff",
    tertiaryContainer: "#dbe1ff",
    onTertiaryContainer: "#101a37",

    error: "#ba1a1a",
    onError: "#ffffff",
    errorContainer: "#ffdad6",
    onErrorContainer: "#410002",

    surfaceDim: "#d5dbdc",
    surface: "#f5fafc",
    surfaceBright: "#f5fafc",
    surfaceContainerLowest: "#ffffff",
    surfaceContainerLow: "#eff5f6",
    surfaceContainer: "#e9eff0",
    surfaceContainerHigh: "#e3e9eb",
    surfaceContainerHighest: "#dee3e5",

    surfaceVariant: "#dbe4e6",
    surfaceTint: "#006876",
    background: "#f5fafc",
    onBackground: "#171d1e",
    onSurface: "#171d1e",
    onSurfaceVariant: "#3f484a",

    inverseSurface: "#2b3133",
    inverseOnSurface: "#ecf2f3",
    inversePrimary: "#83d3e3",

    primaryFixed: "#a1efff",
    primaryFixedDim: "#83d3e3",
    onPrimaryFixed: "#001f25",
    onPrimaryFixedVariant: "#004e59",

    secondaryFixed: "#cde7ed",
    secondaryFixedDim: "#b1cbd1",
    onSecondaryFixed: "#051f23",
    onSecondaryFixedVariant: "#334a50",

    tertiaryFixed: "#dbe1ff",
    tertiaryDfixedDim: "#bcc5eb",
    onTertiaryFixed: "#101a37",
    onTertiaryFixedVariant: "#3c4665",

    outline: "#6f797b",
    outlineVariant: "#bfc8ca",

    scrim: "#000000",
    shadow: "#000000",

    sourceColor: "#6fa8b4"
};

var dark = {
    primary: "#83d3e3",
    onPrimary: "#00363e",
    primaryContainer: "#004e59",
    onPrimaryContainer: "#a1efff",

    secondary: "#b1cbd1",
    onSecondary: "#1c3439",
    secondaryContainer: "#334a50",
    onSecondaryContainer: "#cde7ed",

    tertiary: "#bcc5eb",
    onTertiary: "#262f4d",
    tertiaryContainer: "#3c4665",
    onTertiaryContainer: "#dbe1ff",

    error: "#ffb4ab",
    onError: "#690005",
    errorContainer: "#93000a",
    onErrorContainer: "#ffdad6",

    surfaceDim: "#0e1416",
    surface: "#0e1416",
    surfaceBright: "#343a3c",
    surfaceContainerLowest: "#090f10",
    surfaceContainerLow: "#171d1e",
    surfaceContainer: "#1b2122",
    surfaceContainerHigh: "#252b2c",
    surfaceContainerHighest: "#303637",

    surfaceVariant: "#3f484a",
    surfaceTint: "#83d3e3",
    background: "#0e1416",
    onBackground: "#dee3e5",
    onSurface: "#dee3e5",
    onSurfaceVariant: "#bfc8ca",

    inverseSurface: "#dee3e5",
    inverseOnSurface: "#2b3133",
    inversePrimary: "#006876",

    primaryFixed: "#a1efff",
    primaryFixedDim: "#83d3e3",
    onPrimaryFixed: "#001f25",
    onPrimaryFixedVariant: "#004e59",

    secondaryFixed: "#cde7ed",
    secondaryFixedDim: "#b1cbd1",
    onSecondaryFixed: "#051f23",
    onSecondaryFixedVariant: "#334a50",

    tertiaryFixed: "#dbe1ff",
    tertiaryDfixedDim: "#bcc5eb",
    onTertiaryFixed: "#101a37",
    onTertiaryFixedVariant: "#3c4665",

    outline: "#899295",
    outlineVariant: "#3f484a",

    scrim: "#000000",
    shadow: "#000000",

    sourceColor: "#6fa8b4"
};

function setDarkMode(darkMode) { isDark = !!darkMode; }
function toggleMode() { isDark = !isDark; }
function palette() { return isDark ? dark : light; }
function isDarkMode() { return isDark; }

// Optional direct tokens (static snapshot at load)
var primary = palette().primary;
var onPrimary = palette().onPrimary;
var error = palette().error;
var onError = palette().onError;
