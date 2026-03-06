# GitHub Copilot Instructions for BetterUI

You are assisting with the BetterUI, a Flutter design system using Dart 3.10+.

**IMPORTANT: Read CLAUDE.md for complete coding standards and architecture details.**

This is a **STRICT** development environment. All code must adhere to the patterns below.

---

## PRIMARY FOCUS AREAS (CRITICAL ENFORCEMENT)

### 1. Color System Usage (CRITICAL)

❌ **REJECT** if code uses `Theme.of(context).colorScheme.X`

✅ **REQUIRE** `context.colors.X` (ColorSystem extension)

✅ **REQUIRE** `SemanticColor` enum for color parameters

**Examples:**

```dart
// ✅ CORRECT
final bgColor = context.colors.primary;
final textColor = context.colors.onSurface;
final containerColor = context.colors.successContainer;

class AppButton extends StatelessWidget {
  final SemanticColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.main(context),
      child: Text('Button', style: TextStyle(color: color.onColor(context))),
    );
  }
}

// ❌ WRONG - Will be REJECTED
final bgColor = Theme.of(context).colorScheme.primary;
Container(color: Colors.blue, child: Text('Button'));
```

**Check ALL color access patterns**

Verify proper semantic color variants:

- `color.main(context)` - Base color
- `color.bold(context)` - Bold variant
- `color.disabled(context)` - Disabled state
- `color.variant(context)` - Variant color
- `color.variantLow(context)` - Low opacity variant
- `color.onColor(context)` - Text/icon color on this color
- `color.containerColor(context)` - Container background

---

### 2. Responsive Design Patterns (CRITICAL)

✅ **REQUIRE** use of `context.isDesktop`, `context.isMobile`, `context.isTablet`

✅ **REQUIRE** use of `context.responsive()` for adaptive values

✅ **REQUIRE** `isDesktop` parameter when generating themes

❌ **REJECT** hardcoded breakpoint checks like `MediaQuery.of(context).size.width > 1024`

**Examples:**

```dart
// ✅ CORRECT
if (context.isDesktop) {
  return DesktopLayout();
} else if (context.isTablet) {
  return TabletLayout();
} else {
  return MobileLayout();
}

final padding = context.responsive(
  16.0,
  lg: 24.0,
  xl: 32.0,
);

MaterialApp(
  theme: BetterTheme.cobaltLight(context.isDesktop),
  darkTheme: BetterTheme.cobaltDark(context.isDesktop),
);

// ❌ WRONG - Hardcoded breakpoints
if (MediaQuery.of(context).size.width > 1024) {
  return DesktopLayout();
}

final screenWidth = MediaQuery.of(context).size.width;
if (screenWidth >= 768 && screenWidth < 1024) {
  return TabletLayout();
}
```

---

### 3. Dart 3.10+ Modern Patterns (ENFORCE)

✅ **REQUIRE** switch expressions for enum-based logic (not if/else chains)

✅ **ENCOURAGE** pattern matching in switch expressions

✅ **REQUIRE** const constructors where possible

✅ **USE** `Row(spacing: X)` and `Column(spacing: X)` for spacing

❌ **REJECT** outdated patterns when modern alternatives exist

❌ **AVOID** Manual padding, SizedBox, or Wrap gymnastics between children

**Examples:**

```dart
// ✅ CORRECT - Switch expression
Color _backgroundColor(BuildContext context) => switch (style) {
  TagStyle.fill => color.main(context),
  TagStyle.outline => context.colors.surface,
  TagStyle.soft => color.containerColor(context),
};

// ✅ CORRECT - Nested switch expressions
Color _textColor(BuildContext context) => switch (style) {
  TagStyle.fill => color.onColor(context),
  TagStyle.outline => switch (color) {
    SemanticColor.neutral => context.colors.onSurfaceVariant,
    _ => color.main(context),
  },
  TagStyle.soft => color.main(context),
};

// ✅ CORRECT - Pattern matching with records
child: switch (data) {
  ApiResponseInitial() => const SizedBox(),
  ApiResponseLoading() => const CircularProgressIndicator(),
  ApiResponseError(:final message) => Text('Error: $message'),
  ApiResponseLoaded(:final data) => ContentWidget(data: data),
};

// ✅ CORRECT - Const constructors
const AppTag({
  super.key,
  required this.text,
  this.color = SemanticColor.primary,
  this.size = TagSize.medium,
});

// ✅ CORRECT - Row/Column spacing
Row(
  spacing: 8,
  children: [
    Icon(Icons.star),
    Text('Rating'),
    Text('4.5'),
  ],
)

// ❌ WRONG - If/else chain for enums
Color _backgroundColor(BuildContext context) {
  if (style == TagStyle.fill) {
    return color.main(context);
  } else if (style == TagStyle.outline) {
    return context.colors.surface;
  } else {
    return color.containerColor(context);
  }
}

// ❌ WRONG - Manual spacing between children
Row(
  children: [
    Icon(Icons.star),
    const SizedBox(width: 8),
    Text('Rating'),
    const SizedBox(width: 8),
    Text('4.5'),
  ],
)
```

---

### 4. Code Duplication & Readability (CRITICAL)

**Identify repeated code blocks that should be extracted into:**

- Private helper methods (for single-file duplication)
- Shared utilities (for cross-file duplication)
- Reusable components (for widget duplication)

**Flag complex nested logic that should be simplified**

**Suggest descriptive variable/method names for unclear code**

**Recommend splitting large methods (>50 lines) into smaller units**

**Examples:**

```dart
// ✅ CORRECT - Extracted helper
class AppCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(context),
      child: Column(
        children: [
          _buildHeader(context),
          _buildContent(context),
          _buildFooter(context),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) => BoxDecoration(
    color: context.colors.surface,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: context.colors.outline.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  Widget _buildHeader(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Text('Header'),
  );
}

// ✅ CORRECT - Descriptive names
final isUserAuthenticated = user != null;
final maximumAllowedRetries = 3;
Color _calculateBackgroundColorBasedOnState(BuildContext context) => ...;

// ❌ WRONG - Repeated decoration logic in multiple classes
class AppCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(  // DUPLICATED across multiple classes
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [...],
      ),
      child: Text('Card 1'),
    );
  }
}

// ❌ WRONG - Unclear names
final flag = user != null;
final max = 3;
Color _getBg(BuildContext context) => ...;
```

---

## SECONDARY CHECKS

### Atomic Design Structure

Components must be placed in the correct category:

- **Atoms** (`lib/atoms/`): Single-purpose, indivisible components
  - Examples: Buttons, badges, switches, inputs, avatars

- **Molecules** (`lib/molecules/`): Simple combinations of atoms
  - Examples: List items, cards, tooltips, rating bars

- **Organisms** (`lib/organisms/`): Complex, feature-rich components
  - Examples: Data tables, navigation bars, profile headers

- **Templates** (`lib/templates/`): Complete screen layouts
  - Examples: Login scaffolds, profile screens, dashboard layouts

### Component Naming (REQUIRED)

✅ **CORRECT:**

```dart
class AppSoftButton extends StatelessWidget { }
class AppTag extends StatelessWidget { }
class AppStatusBadge extends StatelessWidget { }

// Files:
// soft_button.dart
// tag.dart
// status_badge.dart
```

❌ **WRONG:**

```dart
class SoftButton extends StatelessWidget { }  // Missing "App" prefix
class app_tag extends StatelessWidget { }      // Wrong case
// File: SoftButton.dart                        // Should be snake_case
```

### Documentation (REQUIRED for public APIs)

All public components must have dartdoc comments:

````dart
/// A customizable soft button with rounded corners and subtle styling.
///
/// The [AppSoftButton] provides a softer visual alternative to the standard
/// button with a filled background and no border. It supports loading states,
/// disabled states, and prefix/suffix icons.
///
/// Example:
/// ```dart
/// AppSoftButton(
///   text: 'Continue',
///   color: SemanticColor.primary,
///   onPressed: () => print('Pressed'),
/// )
/// ```
class AppSoftButton extends StatelessWidget {
  /// The text label displayed on the button.
  final String? text;

  /// The semantic color scheme for the button.
  /// Defaults to [SemanticColor.primary].
  final SemanticColor color;

  /// Called when the button is tapped.
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// Creates an [AppSoftButton].
  ///
  /// The [onPressed] callback is required. The [color] defaults to primary
  /// and [size] defaults to large.
  const AppSoftButton({
    super.key,
    this.text,
    this.color = SemanticColor.primary,
    required this.onPressed,
  });
}
````

### Resource Management

Always dispose of controllers and focus nodes:

```dart
// ✅ CORRECT
class _TextFieldState extends State<AppTextField> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

// ❌ WRONG - Missing disposal
class _TextFieldState extends State<AppTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }
  // Missing dispose()!
}
```

### Null Safety Patterns

```dart
// ✅ CORRECT - Null-aware with fallback
final controller = widget.controller ?? TextEditingController();

// ✅ CORRECT - Bang when guaranteed non-null
final colorSystem = Theme.of(context).extension<ColorSystem>()!;

// ✅ CORRECT - Conditional spread
children: [
  Text('Title'),
  if (subtitle != null) ...[
    const SizedBox(height: 4),
    Text(subtitle!),
  ],
]

// ❌ WRONG - Force unwrapping without guarantee
final value = nullableValue!;  // Dangerous if can be null
```

### Code Cleanliness

Run `dart fix --apply` to remove:

- Unused imports
- Unnecessary casts
- Deprecated API usage

---

## WHEN SUGGESTING CODE

1. **Always follow these patterns** - Don't suggest code that violates these standards
2. **Use `context.colors`** - Never suggest `Theme.of(context).colorScheme`
3. **Use switch expressions** - Don't suggest if/else chains for enums
4. **Use `Row(spacing:)` / `Column(spacing:)`** - Don't add manual SizedBox between children
5. **Add const** - Suggest const constructors and const instances
6. **Extract duplication** - If you see repeated code, suggest extracting it
7. **Add documentation** - Include dartdoc comments in your suggestions
8. **Follow atomic design** - Suggest correct placement in atoms/molecules/organisms/templates

---

## REVIEW CHECKLIST

When reviewing or suggesting code, check in this order:

1. ✅ **Color system** - Using `context.colors` not `Theme.colorScheme`?
2. ✅ **Responsive patterns** - Using `context.isDesktop/isMobile/isTablet`?
3. ✅ **Switch expressions** - Using switch not if/else for enums?
4. ✅ **Row/Column spacing** - Using `spacing` parameter not manual SizedBox?
5. ✅ **Code duplication** - Any repeated code to extract?
6. ✅ **Atomic design** - Correct category (atoms/molecules/organisms/templates)?
7. ✅ **Naming** - App prefix? snake_case files?
8. ✅ **Documentation** - Dartdoc comments for public APIs?
9. ✅ **Resource management** - Disposing controllers/focus nodes?
10. ✅ **Const** - Using const where possible?

---

## QUICK REFERENCE

**Import Extensions:**

```dart
import 'package:better_design_system/utils/extensions/extensions.dart';
```

**Access Colors:**

```dart
context.colors.primary
context.colors.onSurface
context.colors.successContainer
```

**Semantic Colors:**

```dart
final SemanticColor color;
color.main(context)
color.onColor(context)
color.containerColor(context)
```

**Responsive:**

```dart
context.isDesktop
context.isMobile
context.responsive(16.0, lg: 24.0)
```

**Switch Expressions:**

```dart
final result = switch (value) {
  Type1() => result1,
  Type2(:final field) => result2,
  _ => defaultResult,
};
```

**Spacing:**

```dart
Row(spacing: 8, children: [...])
Column(spacing: 16, children: [...])
```

---

Read CLAUDE.md for complete architectural details, theming system, and showcase app patterns.
