# Spacing

BetterUI provides a consistent spacing system for margins, padding, and layout gaps.

---

## Spacing Scale

BetterUI uses an 8-point grid system:

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 4px | Tight spacing |
| `sm` | 8px | Compact elements |
| `md` | 16px | Standard spacing |
| `lg` | 24px | Section spacing |
| `xl` | 32px | Large gaps |
| `xxl` | 48px | Page margins |
| `xxxl` | 64px | Major sections |

---

## Using Spacing

### Via BetterSpacing

```dart
// Padding
Padding(
  padding: EdgeInsets.all(BetterSpacing.md),
  child: // ...
)

// Margin with SizedBox
SizedBox(height: BetterSpacing.lg)

// Gap in Row/Column
Column(
  children: [
    Widget1(),
    SizedBox(height: BetterSpacing.sm),
    Widget2(),
  ],
)
```

### Spacing Constants

```dart
class BetterSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}
```

---

## EdgeInsets Helpers

Pre-built EdgeInsets for common patterns:

```dart
// All sides
BetterPadding.all(BetterSpacing.md)  // 16px all

// Symmetric
BetterPadding.symmetric(
  horizontal: BetterSpacing.lg,  // 24px left/right
  vertical: BetterSpacing.md,    // 16px top/bottom
)

// Only specific sides
BetterPadding.only(
  top: BetterSpacing.xl,
  bottom: BetterSpacing.md,
)
```

---

## Component Spacing

Default spacing for common components:

| Component | Internal Padding | External Margin |
|-----------|-----------------|-----------------|
| Button | `sm` (8px) | - |
| Card | `md` (16px) | `sm` (8px) |
| List Item | `md` horizontal, `sm` vertical | - |
| Dialog | `lg` (24px) | - |
| Section | - | `xl` (32px) vertical |
| Page | `md` (16px) | - |

---

## Responsive Spacing

Spacing adapts to screen size:

### Mobile
```dart
// Tighter spacing on mobile
padding: EdgeInsets.all(BetterSpacing.sm)  // 8px
```

### Tablet
```dart
// Standard spacing on tablet
padding: EdgeInsets.all(BetterSpacing.md)  // 16px
```

### Desktop
```dart
// More generous spacing on desktop
padding: EdgeInsets.all(BetterSpacing.lg)  // 24px
```

### Responsive Helper

```dart
double getResponsiveSpacing(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) return BetterSpacing.sm;
  if (width < 1200) return BetterSpacing.md;
  return BetterSpacing.lg;
}
```

---

## Layout Gaps

For Flex layouts (Row, Column, Wrap):

```dart
// Using Gap widget
Column(
  children: [
    Widget1(),
    Gap(BetterSpacing.md),
    Widget2(),
  ],
)

// Using mainAxisGap
Wrap(
  spacing: BetterSpacing.sm,      // Horizontal gap
  runSpacing: BetterSpacing.sm,   // Vertical gap
  children: [...],
)
```

---

## Grid Layouts

Consistent grid spacing:

```dart
GridView.builder(
  padding: EdgeInsets.all(BetterSpacing.md),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: BetterSpacing.sm,
    mainAxisSpacing: BetterSpacing.sm,
  ),
  // ...
)
```

---

## Best Practices

1. **Consistency** - Always use spacing tokens, not magic numbers
2. **8-point grid** - Stick to multiples of 8 for harmony
3. **Hierarchy** - Larger spacing for related groups, smaller within
4. **Responsiveness** - Adjust spacing for different screen sizes
5. **Whitespace** - Don't fear empty space, it improves readability

---

## Common Patterns

### Card with Content

```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(BetterSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title', style: textTheme.titleMedium),
        SizedBox(height: BetterSpacing.sm),
        Text('Description', style: textTheme.bodyMedium),
      ],
    ),
  ),
)
```

### Page Layout

```dart
Scaffold(
  body: SingleChildScrollView(
    padding: EdgeInsets.symmetric(
      horizontal: BetterSpacing.md,
      vertical: BetterSpacing.lg,
    ),
    child: Column(
      children: [
        SectionWidget(),
        SizedBox(height: BetterSpacing.xl),
        AnotherSection(),
      ],
    ),
  ),
)
```

---

## Next Steps

- [Colors](colors) - Color system
- [Typography](typography) - Text styles
- [Shadows](shadows) - Elevation system
