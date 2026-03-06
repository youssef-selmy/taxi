# Theming

BetterUI provides a powerful theming system that allows you to customize the look and feel of your application while maintaining design consistency.

---

## Pre-built Themes

BetterUI includes **9 pre-built color schemes**, each with full light and dark mode support. Themes are selected using the `BetterThemes` enum:

```dart
theme: BetterTheme.fromBetterTheme(BetterThemes.cobalt, context.isDesktop, false),
darkTheme: BetterTheme.fromBetterTheme(BetterThemes.cobalt, context.isDesktop, true),
```

### Available Themes

| Theme | Description | Best For |
|-------|-------------|----------|
| `electricIndigo` | Bold purple accent, vibrant feel | Modern brands, creative apps |
| `cobalt` | Sleek deep blue with yellow highlights | Professional apps (default) |
| `coralRed` | High-contrast red tone, energetic | Delivery, food apps |
| `earthyGreen` | Organic, nature-oriented green | Eco-focused, logistics |
| `noir` | Dark mode, minimalist UI | Dark-first apps |
| `hyperPink` | Neon-style vibrant pink | Fashion, cosmetics |
| `sunburstYellow` | Bright, optimistic yellow-orange | Friendly, upbeat apps |
| `autumnOrange` | Earthy, burnt-orange look | Utility, logistics |
| `hera` | Classic, professional tones | Enterprise apps |

---

## Applying Themes

### Basic Theme Application

In your `MaterialApp`, apply a theme using `BetterTheme.fromBetterTheme`:

```dart
import 'package:better_design_system/better_design_system.dart';

MaterialApp(
  theme: BetterTheme.fromBetterTheme(
    BetterThemes.cobalt,    // Theme enum
    context.isDesktop,       // Desktop vs mobile
    false,                   // Dark mode: false = light
  ),
  darkTheme: BetterTheme.fromBetterTheme(
    BetterThemes.cobalt,
    context.isDesktop,
    true,                    // Dark mode: true = dark
  ),
  themeMode: ThemeMode.system,  // Follow system preference
  // ...
)
```

### Dynamic Theme Switching

You can switch themes at runtime by updating the theme enum:

```dart
// In a StatefulWidget or using state management
BetterThemes currentTheme = BetterThemes.cobalt;

// Switch theme
setState(() {
  currentTheme = BetterThemes.electricIndigo;
});
```

---

## Custom Themes

You can create custom themes by extending the `ColorSystem` class:

```dart
final myCustomTheme = ColorSystem(
  primary: Color(0xFF123456),
  secondary: Color(0xFF654321),
  surface: Color(0xFFFFFFFF),
  background: Color(0xFFF5F5F5),
  error: Color(0xFFB00020),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  onBackground: Color(0xFF000000),
  onError: Color(0xFFFFFFFF),
  // ... additional color properties
);
```

### Color System Properties

| Property | Description |
|----------|-------------|
| `primary` | Primary brand color |
| `secondary` | Secondary accent color |
| `surface` | Surface/card backgrounds |
| `background` | Page backgrounds |
| `error` | Error states |
| `onPrimary` | Text on primary color |
| `onSecondary` | Text on secondary color |
| `onSurface` | Text on surfaces |
| `onBackground` | Text on backgrounds |
| `onError` | Text on error color |

---

## Responsive Theming

BetterUI themes automatically adapt between desktop and mobile layouts:

```dart
// The isDesktop parameter adjusts:
// - Font sizes
// - Spacing
// - Component sizes
// - Touch target sizes

BetterTheme.fromBetterTheme(
  BetterThemes.cobalt,
  true,   // Desktop layout
  false,
)

BetterTheme.fromBetterTheme(
  BetterThemes.cobalt,
  false,  // Mobile layout
  false,
)
```

---

## Accessing Theme Colors

Within your widgets, access the current theme colors via the `ColorSystem`:

```dart
// Get current color system
final colors = Theme.of(context).extension<ColorSystem>()!;

// Use semantic colors
Container(
  color: colors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: colors.onPrimary),
  ),
)
```

---

## Next Steps

- [Colors](colors) - Deep dive into the color system
- [Typography](typography) - Text styles and font scales
- [Shadows](shadows) - Elevation and shadow system
