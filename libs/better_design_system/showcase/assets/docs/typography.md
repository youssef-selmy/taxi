# Typography

BetterUI provides a comprehensive typography system with predefined text styles, font scales, and responsive sizing.

---

## Text Styles

BetterUI defines a complete set of text styles following Material Design guidelines:

### Display Styles

Large, prominent text for hero sections and headlines:

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `displayLarge` | 57sp | Regular | Hero headlines |
| `displayMedium` | 45sp | Regular | Large titles |
| `displaySmall` | 36sp | Regular | Section headers |

### Headline Styles

Section and page headers:

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `headlineLarge` | 32sp | Regular | Page titles |
| `headlineMedium` | 28sp | Regular | Section titles |
| `headlineSmall` | 24sp | Regular | Card headers |

### Title Styles

Component and list headers:

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `titleLarge` | 22sp | Medium | Dialog titles |
| `titleMedium` | 16sp | Medium | List headers |
| `titleSmall` | 14sp | Medium | Subtitles |

### Body Styles

Main content text:

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `bodyLarge` | 16sp | Regular | Primary content |
| `bodyMedium` | 14sp | Regular | Secondary content |
| `bodySmall` | 12sp | Regular | Captions |

### Label Styles

UI labels and buttons:

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `labelLarge` | 14sp | Medium | Buttons |
| `labelMedium` | 12sp | Medium | Input labels |
| `labelSmall` | 11sp | Medium | Chips, tags |

---

## Using Typography

### Via Theme TextTheme

Access text styles through the theme:

```dart
Text(
  'Hello World',
  style: Theme.of(context).textTheme.headlineMedium,
)
```

### Direct Typography Class

Use the `BetterTypography` class directly:

```dart
Text(
  'Hello World',
  style: BetterTypography.headlineMedium,
)
```

### With Color Override

Combine text styles with custom colors:

```dart
Text(
  'Hello World',
  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
    color: colors.primary,
  ),
)
```

---

## Font Weights

BetterUI uses standard font weights:

| Weight | Value | Usage |
|--------|-------|-------|
| Thin | 100 | Decorative |
| Light | 300 | Light emphasis |
| Regular | 400 | Body text |
| Medium | 500 | Emphasis |
| SemiBold | 600 | Strong emphasis |
| Bold | 700 | Headlines |
| Black | 900 | Maximum emphasis |

---

## Responsive Typography

Text sizes automatically adjust based on platform:

```dart
// Desktop - larger sizes
BetterTheme.fromBetterTheme(BetterThemes.cobalt, true, false)

// Mobile - optimized sizes
BetterTheme.fromBetterTheme(BetterThemes.cobalt, false, false)
```

### Size Adjustments

| Style | Mobile | Desktop |
|-------|--------|---------|
| `displayLarge` | 57sp | 64sp |
| `headlineLarge` | 32sp | 36sp |
| `bodyLarge` | 16sp | 18sp |
| `labelMedium` | 12sp | 14sp |

---

## Line Heights

Optimal line heights for readability:

| Style Type | Line Height |
|------------|-------------|
| Display | 1.1 - 1.2 |
| Headline | 1.2 - 1.3 |
| Title | 1.3 - 1.4 |
| Body | 1.4 - 1.6 |
| Label | 1.2 - 1.3 |

---

## Letter Spacing

Letter spacing adjustments:

| Style Type | Letter Spacing |
|------------|----------------|
| Display | -0.25sp |
| Headline | 0sp |
| Title | 0.15sp |
| Body | 0.5sp |
| Label | 0.1sp |

---

## Custom Fonts

To use custom fonts with BetterUI:

1. Add fonts to your `pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: MyCustomFont
      fonts:
        - asset: fonts/MyCustomFont-Regular.ttf
        - asset: fonts/MyCustomFont-Bold.ttf
          weight: 700
```

2. Override the font family in your theme:

```dart
final theme = BetterTheme.fromBetterTheme(
  BetterThemes.cobalt,
  isDesktop,
  isDark,
).copyWith(
  textTheme: GoogleFonts.poppinsTextTheme(),
);
```

---

## Best Practices

1. **Hierarchy** - Use display/headline for emphasis, body for content
2. **Consistency** - Stick to predefined styles
3. **Readability** - Ensure sufficient contrast
4. **Responsiveness** - Let the system handle size adjustments

---

## Next Steps

- [Colors](colors) - Color system
- [Shadows](shadows) - Elevation system
- [Spacing](spacing) - Layout utilities
