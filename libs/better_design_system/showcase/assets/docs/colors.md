# Colors

BetterUI provides a comprehensive color system with semantic colors, color palettes, and 9 pre-built color schemes.

---

## Color System Architecture

The color system consists of three main components:

| Component | Purpose |
|-----------|---------|
| `ColorSystem` | Core semantic colors that define the theme |
| `ColorPalette` | Extended color variations (shades, tints) |
| `SemanticColor` | Contextual colors for states and feedback |

---

## Color Schemes

BetterUI includes 9 pre-built color schemes, each with light and dark variants:

### Cobalt (Default)
```
Primary: Deep blue (#1565C0)
Secondary: Yellow accent
Best for: Professional apps, business tools
```

### Electric Indigo
```
Primary: Vibrant purple (#5C6BC0)
Secondary: Complementary accents
Best for: Creative apps, modern brands
```

### Coral Red
```
Primary: Energetic red (#E53935)
Secondary: Warm accents
Best for: Delivery, food, action-oriented apps
```

### Earthy Green
```
Primary: Nature green (#43A047)
Secondary: Earth tones
Best for: Eco-focused, wellness, logistics
```

### Noir
```
Primary: Neutral grays
Secondary: Subtle accents
Best for: Dark-first design, minimalist apps
```

### Hyper Pink
```
Primary: Neon pink (#EC407A)
Secondary: Vibrant accents
Best for: Fashion, cosmetics, youth brands
```

### Sunburst Yellow
```
Primary: Optimistic yellow (#FDD835)
Secondary: Warm oranges
Best for: Friendly, upbeat applications
```

### Autumn Orange
```
Primary: Burnt orange (#FF7043)
Secondary: Earth tones
Best for: Utility apps, fall themes
```

### Hera
```
Primary: Classic blue
Secondary: Professional accents
Best for: Enterprise, corporate apps
```

---

## Using Colors

### Accessing the Color System

```dart
// Get the current color system from context
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

### Semantic Color Properties

| Property | Light Mode | Dark Mode | Usage |
|----------|------------|-----------|-------|
| `primary` | Brand color | Brand color | Primary actions, highlights |
| `onPrimary` | White/Dark | White/Light | Text on primary |
| `secondary` | Accent color | Accent color | Secondary actions |
| `onSecondary` | Contrasting | Contrasting | Text on secondary |
| `surface` | White | Dark gray | Card backgrounds |
| `onSurface` | Dark | Light | Text on surfaces |
| `background` | Light gray | Dark | Page backgrounds |
| `onBackground` | Dark | Light | Text on backgrounds |
| `error` | Red | Red | Error states |
| `onError` | White | White | Text on error |

---

## Color Palette

Each color scheme includes an extended palette with shades:

```dart
// Primary shades
colors.primary         // Base color
colors.primaryLight    // Lighter variant
colors.primaryDark     // Darker variant
colors.primaryContainer // Container background

// Surface variants
colors.surface         // Base surface
colors.surfaceVariant  // Alternative surface
colors.inverseSurface  // Inverted surface
```

---

## Semantic Colors

Context-aware colors for different states:

```dart
// Status colors
colors.success      // Green - positive states
colors.warning      // Yellow - caution states
colors.error        // Red - error states
colors.info         // Blue - informational

// Interactive states
colors.disabled     // Grayed out
colors.hover        // On hover
colors.focused      // On focus
colors.pressed      // On press
```

---

## Custom Color Schemes

Create a custom color scheme by extending `ColorSystem`:

```dart
class MyCustomColors extends ColorSystem {
  MyCustomColors({required super.brightness}) : super(
    primary: const Color(0xFF123456),
    onPrimary: Colors.white,
    secondary: const Color(0xFF654321),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black87,
    background: const Color(0xFFF5F5F5),
    onBackground: Colors.black87,
    error: Colors.red,
    onError: Colors.white,
  );
}
```

---

## Dark Mode

All color schemes automatically provide dark mode variants:

```dart
// Light mode
BetterTheme.fromBetterTheme(BetterThemes.cobalt, isDesktop, false)

// Dark mode
BetterTheme.fromBetterTheme(BetterThemes.cobalt, isDesktop, true)
```

Dark mode automatically:
- Inverts surface colors
- Adjusts contrast ratios
- Maintains brand identity
- Preserves accessibility

---

## Accessibility

BetterUI colors are designed with accessibility in mind:

- **WCAG 2.1 AA** contrast ratios for text
- **Distinct** colors for colorblind users
- **Consistent** semantic meaning across themes

---

## Next Steps

- [Theming](theming) - Apply color schemes
- [Typography](typography) - Text styles
- [Shadows](shadows) - Elevation system
