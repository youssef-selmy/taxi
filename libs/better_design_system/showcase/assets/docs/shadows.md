# Shadows

BetterUI provides a consistent elevation system using shadows to create visual hierarchy and depth.

---

## Elevation Levels

BetterUI defines multiple elevation levels for different use cases:

| Level | Elevation | Usage |
|-------|-----------|-------|
| `none` | 0dp | Flat surfaces |
| `xs` | 1dp | Subtle lift |
| `sm` | 2dp | Cards, buttons |
| `md` | 4dp | Raised elements |
| `lg` | 8dp | Floating elements |
| `xl` | 16dp | Modals, dialogs |
| `xxl` | 24dp | Navigation drawers |

---

## Using Shadows

### Via BetterShadows

```dart
Container(
  decoration: BoxDecoration(
    color: colors.surface,
    borderRadius: BorderRadius.circular(8),
    boxShadow: BetterShadows.md,
  ),
  child: // ...
)
```

### Common Shadow Presets

```dart
// Small shadow for cards
BetterShadows.sm

// Medium shadow for floating buttons
BetterShadows.md

// Large shadow for dialogs
BetterShadows.lg
```

---

## Shadow Definitions

### Extra Small (xs)
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.05),
  blurRadius: 2,
  offset: Offset(0, 1),
)
```

### Small (sm)
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.08),
  blurRadius: 4,
  offset: Offset(0, 2),
)
```

### Medium (md)
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.10),
  blurRadius: 8,
  offset: Offset(0, 4),
)
```

### Large (lg)
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.12),
  blurRadius: 16,
  offset: Offset(0, 8),
)
```

### Extra Large (xl)
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.15),
  blurRadius: 24,
  offset: Offset(0, 12),
)
```

---

## Component Shadows

Different components use appropriate shadow levels:

| Component | Shadow Level |
|-----------|--------------|
| Cards | `sm` |
| Buttons (raised) | `sm` |
| FAB | `md` |
| Dropdowns | `md` |
| Dialogs | `lg` |
| Bottom sheets | `lg` |
| Navigation drawer | `xl` |
| Modals | `xl` |

---

## Dark Mode Shadows

In dark mode, shadows are adjusted for better visibility:

- **Reduced opacity** - Less visible on dark backgrounds
- **Larger blur** - Softer appearance
- **Surface glow** - Optional light glow effect

```dart
// Dark mode automatically handles shadow adjustments
BetterTheme.fromBetterTheme(BetterThemes.cobalt, isDesktop, true)
```

---

## Custom Shadows

Create custom shadows for specific needs:

```dart
final customShadow = [
  BoxShadow(
    color: colors.primary.withOpacity(0.3),
    blurRadius: 12,
    spreadRadius: 2,
    offset: Offset(0, 4),
  ),
];

Container(
  decoration: BoxDecoration(
    boxShadow: customShadow,
  ),
)
```

---

## Inner Shadows

For inset effects:

```dart
Container(
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: Offset(0, 2),
        inset: true,  // Inner shadow
      ),
    ],
  ),
)
```

---

## Best Practices

1. **Consistency** - Use predefined elevation levels
2. **Hierarchy** - Higher elements get larger shadows
3. **Performance** - Avoid excessive shadow count
4. **Dark mode** - Let the system handle adjustments

---

## Next Steps

- [Colors](colors) - Color system
- [Typography](typography) - Text styles
- [Spacing](spacing) - Layout utilities
