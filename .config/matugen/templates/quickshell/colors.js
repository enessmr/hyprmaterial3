.pragma library
// Centralized color tokens (Material 3 style). Non-QML JS module.
// Import in QML with: import "../colors.js" as Palette

var isDark = true; // default to dark mode

var light = {
  primary: "{{ colors.primary.light.hex }}",
  onPrimary: "{{ colors.onPrimary.light.hex }}",
  primaryContainer: "{{ colors.primaryContainer.light.hex }}",
  onPrimaryContainer: "{{ colors.onPrimaryContainer.light.hex }}",

  secondary: "{{ colors.secondary.light.hex }}",
  onSecondary: "{{ colors.onSecondary.light.hex }}",
  secondaryContainer: "{{ colors.secondaryContainer.light.hex }}",
  onSecondaryContainer: "{{ colors.onSecondaryContainer.light.hex }}",

  tertiary: "{{ colors.tertiary.light.hex }}",
  onTertiary: "{{ colors.onTertiary.light.hex }}",
  tertiaryContainer: "{{ colors.tertiaryContainer.light.hex }}",
  onTertiaryContainer: "{{ colors.onTertiaryContainer.light.hex }}",

  error: "{{ colors.error.light.hex }}",
  onError: "{{ colors.onError.light.hex }}",
  errorContainer: "{{ colors.errorContainer.light.hex }}",
  onErrorContainer: "{{ colors.onErrorContainer.light.hex }}",

  background: "{{ colors.background.light.hex }}",
  onBackground: "{{ colors.onBackground.light.hex }}",
  surface: "{{ colors.surface.light.hex }}",
  onSurface: "{{ colors.onSurface.light.hex }}",
  surfaceVariant: "{{ colors.surfaceVariant.light.hex }}",
  onSurfaceVariant: "{{ colors.onSurfaceVariant.light.hex }}",
  outline: "{{ colors.outline.light.hex }}",
  shadow: "{{ colors.shadow.light.hex }}",

  inverseSurface: "{{ colors.inverseSurface.light.hex }}",
  inverseOnSurface: "{{ colors.inverseOnSurface.light.hex }}",
  inversePrimary: "{{ colors.inversePrimary.light.hex }}"
};

var dark = {
  primary: "{{ colors.primary.dark.hex }}",
  onPrimary: "{{ colors.onPrimary.dark.hex }}",
  primaryContainer: "{{ colors.primaryContainer.dark.hex }}",
  onPrimaryContainer: "{{ colors.onPrimaryContainer.dark.hex }}",

  secondary: "{{ colors.secondary.dark.hex }}",
  onSecondary: "{{ colors.onSecondary.dark.hex }}",
  secondaryContainer: "{{ colors.secondaryContainer.dark.hex }}",
  onSecondaryContainer: "{{ colors.onSecondaryContainer.dark.hex }}",

  tertiary: "{{ colors.tertiary.dark.hex }}",
  onTertiary: "{{ colors.onTertiary.dark.hex }}",
  tertiaryContainer: "{{ colors.tertiaryContainer.dark.hex }}",
  onTertiaryContainer: "{{ colors.onTertiaryContainer.dark.hex }}",

  error: "{{ colors.error.dark.hex }}",
  onError: "{{ colors.onError.dark.hex }}",
  errorContainer: "{{ colors.errorContainer.dark.hex }}",
  onErrorContainer: "{{ colors.onErrorContainer.dark.hex }}",

  background: "{{ colors.background.dark.hex }}",
  onBackground: "{{ colors.onBackground.dark.hex }}",
  surface: "{{ colors.surface.dark.hex }}",
  onSurface: "{{ colors.onSurface.dark.hex }}",
  surfaceVariant: "{{ colors.surfaceVariant.dark.hex }}",
  onSurfaceVariant: "{{ colors.onSurfaceVariant.dark.hex }}",
  outline: "{{ colors.outline.dark.hex }}",
  shadow: "{{ colors.shadow.dark.hex }}",

  inverseSurface: "{{ colors.inverseSurface.dark.hex }}",
  inverseOnSurface: "{{ colors.inverseOnSurface.dark.hex }}",
  inversePrimary: "{{ colors.inversePrimary.dark.hex }}"
};

function setDarkMode(darkMode) { isDark = !!darkMode; }
function toggleMode() { isDark = !isDark; }
function palette() { return isDark ? dark : light; }
function isDarkMode() { return isDark; }

// Optional direct tokens (static snapshot at load)
var primary = palette().primary;
var onPrimary = palette().onPrimary;
