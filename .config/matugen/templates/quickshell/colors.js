.pragma library
// Centralized color tokens (Material 3 style). Non-QML JS module.
// Import in QML with: import "../colors.js" as Palette

var isDark = {{ is_dark_mode }};

var light = {
    primary: "{{ colors.primary.light.hex }}",
    onPrimary: "{{ colors.on_primary.light.hex }}",
    primaryContainer: "{{ colors.primary_container.light.hex }}",
    onPrimaryContainer: "{{ colors.on_primary_container.light.hex }}",

    secondary: "{{ colors.secondary.light.hex }}",
    onSecondary: "{{ colors.on_secondary.light.hex }}",
    secondaryContainer: "{{ colors.secondary_container.light.hex }}",
    onSecondaryContainer: "{{ colors.on_secondary_container.light.hex }}",

    tertiary: "{{ colors.tertiary.light.hex }}",
    onTertiary: "{{ colors.on_tertiary.light.hex }}",
    tertiaryContainer: "{{ colors.tertiary_container.light.hex }}",
    onTertiaryContainer: "{{ colors.on_tertiary_container.light.hex }}",

    error: "{{ colors.error.light.hex }}",
    onError: "{{ colors.on_error.light.hex }}",
    errorContainer: "{{ colors.error_container.light.hex }}",
    onErrorContainer: "{{ colors.on_error_container.light.hex }}",

    surfaceDim: "{{ colors.surface_dim.light.hex }}",
    surface: "{{ colors.surface.light.hex }}",
    surfaceBright: "{{ colors.surface_bright.light.hex }}",
    surfaceContainerLowest: "{{ colors.surface_container_lowest.light.hex }}",
    surfaceContainerLow: "{{ colors.surface_container_low.light.hex }}",
    surfaceContainer: "{{ colors.surface_container.light.hex }}",
    surfaceContainerHigh: "{{ colors.surface_container_high.light.hex }}",
    surfaceContainerHighest: "{{ colors.surface_container_highest.light.hex }}",

    surfaceVariant: "{{ colors.surface_variant.light.hex }}",
    surfaceTint: "{{ colors.surface_tint.light.hex }}",
    background: "{{ colors.background.light.hex }}",
    onBackground: "{{ colors.on_background.light.hex }}",
    onSurface: "{{ colors.on_surface.light.hex }}",
    onSurfaceVariant: "{{ colors.on_surface_variant.light.hex }}",

    inverseSurface: "{{ colors.inverse_surface.light.hex }}",
    inverseOnSurface: "{{ colors.inverse_on_surface.light.hex }}",
    inversePrimary: "{{ colors.inverse_primary.light.hex }}",

    primaryFixed: "{{ colors.primary_fixed.light.hex }}",
    primaryFixedDim: "{{ colors.primary_fixed_dim.light.hex }}",
    onPrimaryFixed: "{{ colors.on_primary_fixed.light.hex }}",
    onPrimaryFixedVariant: "{{ colors.on_primary_fixed_variant.light.hex }}",

    secondaryFixed: "{{ colors.secondary_fixed.light.hex }}",
    secondaryFixedDim: "{{ colors.secondary_fixed_dim.light.hex }}",
    onSecondaryFixed: "{{ colors.on_secondary_fixed.light.hex }}",
    onSecondaryFixedVariant: "{{ colors.on_secondary_fixed_variant.light.hex }}",

    tertiaryFixed: "{{ colors.tertiary_fixed.light.hex }}",
    tertiaryDfixedDim: "{{ colors.tertiary_fixed_dim.light.hex }}",
    onTertiaryFixed: "{{ colors.on_tertiary_fixed.light.hex }}",
    onTertiaryFixedVariant: "{{ colors.on_tertiary_fixed_variant.light.hex }}",

    outline: "{{ colors.outline.light.hex }}",
    outlineVariant: "{{ colors.outline_variant.light.hex }}",

    scrim: "{{ colors.scrim.light.hex }}",
    shadow: "{{ colors.shadow.light.hex }}",

    sourceColor: "{{ colors.source_color.light.hex }}"
};

var dark = {
    primary: "{{ colors.primary.dark.hex }}",
    onPrimary: "{{ colors.on_primary.dark.hex }}",
    primaryContainer: "{{ colors.primary_container.dark.hex }}",
    onPrimaryContainer: "{{ colors.on_primary_container.dark.hex }}",

    secondary: "{{ colors.secondary.dark.hex }}",
    onSecondary: "{{ colors.on_secondary.dark.hex }}",
    secondaryContainer: "{{ colors.secondary_container.dark.hex }}",
    onSecondaryContainer: "{{ colors.on_secondary_container.dark.hex }}",

    tertiary: "{{ colors.tertiary.dark.hex }}",
    onTertiary: "{{ colors.on_tertiary.dark.hex }}",
    tertiaryContainer: "{{ colors.tertiary_container.dark.hex }}",
    onTertiaryContainer: "{{ colors.on_tertiary_container.dark.hex }}",

    error: "{{ colors.error.dark.hex }}",
    onError: "{{ colors.on_error.dark.hex }}",
    errorContainer: "{{ colors.error_container.dark.hex }}",
    onErrorContainer: "{{ colors.on_error_container.dark.hex }}",

    surfaceDim: "{{ colors.surface_dim.dark.hex }}",
    surface: "{{ colors.surface.dark.hex }}",
    surfaceBright: "{{ colors.surface_bright.dark.hex }}",
    surfaceContainerLowest: "{{ colors.surface_container_lowest.dark.hex }}",
    surfaceContainerLow: "{{ colors.surface_container_low.dark.hex }}",
    surfaceContainer: "{{ colors.surface_container.dark.hex }}",
    surfaceContainerHigh: "{{ colors.surface_container_high.dark.hex }}",
    surfaceContainerHighest: "{{ colors.surface_container_highest.dark.hex }}",

    surfaceVariant: "{{ colors.surface_variant.dark.hex }}",
    surfaceTint: "{{ colors.surface_tint.dark.hex }}",
    background: "{{ colors.background.dark.hex }}",
    onBackground: "{{ colors.on_background.dark.hex }}",
    onSurface: "{{ colors.on_surface.dark.hex }}",
    onSurfaceVariant: "{{ colors.on_surface_variant.dark.hex }}",

    inverseSurface: "{{ colors.inverse_surface.dark.hex }}",
    inverseOnSurface: "{{ colors.inverse_on_surface.dark.hex }}",
    inversePrimary: "{{ colors.inverse_primary.dark.hex }}",

    primaryFixed: "{{ colors.primary_fixed.dark.hex }}",
    primaryFixedDim: "{{ colors.primary_fixed_dim.dark.hex }}",
    onPrimaryFixed: "{{ colors.on_primary_fixed.dark.hex }}",
    onPrimaryFixedVariant: "{{ colors.on_primary_fixed_variant.dark.hex }}",

    secondaryFixed: "{{ colors.secondary_fixed.dark.hex }}",
    secondaryFixedDim: "{{ colors.secondary_fixed_dim.dark.hex }}",
    onSecondaryFixed: "{{ colors.on_secondary_fixed.dark.hex }}",
    onSecondaryFixedVariant: "{{ colors.on_secondary_fixed_variant.dark.hex }}",

    tertiaryFixed: "{{ colors.tertiary_fixed.dark.hex }}",
    tertiaryDfixedDim: "{{ colors.tertiary_fixed_dim.dark.hex }}",
    onTertiaryFixed: "{{ colors.on_tertiary_fixed.dark.hex }}",
    onTertiaryFixedVariant: "{{ colors.on_tertiary_fixed_variant.dark.hex }}",

    outline: "{{ colors.outline.dark.hex }}",
    outlineVariant: "{{ colors.outline_variant.dark.hex }}",

    scrim: "{{ colors.scrim.dark.hex }}",
    shadow: "{{ colors.shadow.dark.hex }}",

    sourceColor: "{{ colors.source_color.dark.hex }}"
};

function setDarkMode(darkMode) { isDark = !!darkMode; }
function toggleMode() { isDark = !isDark; }
function palette() { return isDark ? dark : light; }
function isDarkMode() { return isDark; }

// Optional direct tokens (static snapshot at load)
var primary = palette().primary;
var onPrimary = palette().onPrimary;
