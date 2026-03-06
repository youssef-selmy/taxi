# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the BetterUI - a comprehensive Flutter design system organized as a monorepo workspace with multiple packages. It follows atomic design principles (atoms, molecules, organisms, templates) and includes a Widgetbook for component development and a Showcase app for demonstrating complete UI flows.

## Workspace Structure

This is a Flutter workspace project with the following packages:

- **Root** (`better_design_system`): Core design system library
- **widgetbook**: Isolated component development environment using Widgetbook
- **showcase**: Full-featured demo app showcasing complete screens and flows
- **assets**: Design system assets (fonts, images, etc.)
- **better_icons**: Custom icon set

## Common Commands

### Development Setup

```bash
# Install dependencies for all workspace packages
flutter pub get

# Run code generation for widgetbook
cd widgetbook && dart run build_runner build -d --delete-conflicting-outputs

# Run code generation for showcase
cd showcase && dart run build_runner build -d --delete-conflicting-outputs
```

### Running Applications

```bash
# Run Widgetbook for component development
cd widgetbook && flutter run

# Run Showcase app
cd showcase && flutter run
```

### Code Generation

The project uses several code generators:

- `build_runner` for widgetbook annotations and auto_route
- `flutter_gen` for asset generation

When modifying components in widgetbook or routes in showcase, run the appropriate build_runner command.

## Architecture

### Design System Organization (Atomic Design)

The design system follows atomic design methodology in `/lib`:

1. **Atoms** (`lib/atoms/`): Basic building blocks

   - Buttons, badges, avatars, switches, tags
   - Input fields (text, dropdown, date, time)
   - Progress indicators, dividers
   - Each atom has its own style/configuration enums

2. **Molecules** (`lib/molecules/`): Simple component combinations

   - KPI cards, tooltips, rating bars
   - List items, location cards, table cells
   - Date pickers, file upload, charts

3. **Organisms** (`lib/organisms/`): Complex, reusable components

   - Data tables with pagination, search, and sorting
   - Top bars (desktop/mobile), drawers
   - Profile headers, notifications
   - Empty states, step indicators

4. **Templates** (`lib/templates/`): Complete screen layouts

   - Login scaffolds, profile screens
   - Payment method screens, wallet screens
   - Chat screens, appearance settings
   - Map settings, onboarding flows

### Theming System

The theming architecture is centralized in `lib/theme/theme.dart` and `lib/colors/`:

- **ColorSystem** (`lib/colors/color_system.dart`): Extended theme with semantic colors

  - Primary, secondary, tertiary with variants (bold, disabled, variant, variantLow)
  - Surface colors (surface, surfaceVariant, surfaceContainer)
  - Semantic colors: success, warning, error, info, insight
  - Each semantic color has: base, bold, disabled, variant, variantLow, onColor, container

- **Multiple Theme Support**: Pre-built color schemes in `lib/colors/color_schemes/`

  - Cobalt, Coral Red, Earthy Green, Electric Indigo, Hyper Pink
  - Autumn Orange, Hera, Noir, Sunburst Yellow
  - Each has light and dark variants
  - Access via `BetterTheme.{themeName}Light()` or `BetterTheme.{themeName}Dark()`

- **Responsive Theming**: Theme generation accepts `isDesktop` parameter for platform-specific styling

### Typography

Typography is managed in `lib/typography/typography.dart`:

- Uses custom fonts (General Sans for headings, Inter for body)
- Follows Material 3 TextTheme structure
- Fonts are provided via the `better_assets` package

### Extensions and Utilities

`lib/utils/extensions/extensions.dart` provides helpful extensions:

- Responsive helpers (isDesktop, isTablet, isMobile)
- Theme access shortcuts
- Typography extensions
- Date/time formatting
- Layout utilities
- Snackbar/toast helpers

### Showcase App Architecture

The showcase app (`showcase/lib/`) demonstrates the design system in action:

**Structure:**

- `core/`: App infrastructure (routing, DI, settings)

  - Uses `auto_route` for navigation
  - `get_it` + `injectable` for dependency injection
  - `flutter_bloc` + `hydrated_bloc` for state management
  - `SettingsCubit` manages theme selection and app settings

- `features/`: Organized by use case

  - `dashboard`: Main navigation container
  - `ecommerce`: E-commerce UI patterns
  - `fintech`: Financial app screens (home, cards, analytics, transfers, profile)
  - `hr_platform`: HR/people management UIs
  - `sales_and_marketing`: Sales dashboards
  - `templates`: Gallery of reusable screen templates

**Key Patterns:**

- Each feature has `presentation/screens/` for screen widgets

- Router is generated via `@AutoRouterConfig` in `core/router/app_router.dart`
- After modifying routes, run: `cd showcase && dart run build_runner build -d --delete-conflicting-outputs`

### Widgetbook Setup

The widgetbook (`widgetbook/lib/`) provides isolated component development:

- Uses `@widgetbook.App()` annotation for configuration
- Components organized by atomic level (atoms, molecules, organisms, templates)
- Supports all theme variants with live theme switching
- After adding new widgetbook stories with `@UseCase` annotations, run: `cd widgetbook && dart run build_runner build -d --delete-conflicting-outputs`

## Dependencies

### Core Design System

- `better_assets`: Asset management (workspace package) - includes fonts, images, and country flags
- `better_icons`: Custom icon set (workspace package)
- `pinput`: PIN input widgets
- `cached_network_image`: Image caching
- `flutter_staggered_grid_view`, `flutter_layout_grid`: Advanced layouts
- `fl_chart`: Chart components
- `data_table_2`: Enhanced data tables
- `generic_map`: Map integration
- `skeletonizer`: Loading skeletons
- `flutter_animate`: Animations

### Showcase-Specific

- `auto_route`: Declarative routing
- `flutter_bloc` + `hydrated_bloc`: State management with persistence
- `get_it` + `injectable`: Dependency injection
- `hive`: Local storage
- `flutter_map_tile_caching`: Map tile caching for offline support

## Important Notes

### Code Generation

This project heavily relies on code generation. When you see import errors for `.g.dart` or `.gr.dart` files, run the appropriate build_runner command.

### Strings and Localization

The design system provides a built-in string management system via `BetterStrings`:

- **BetterStringsData** (`lib/config/better_strings.dart`): Contains all translatable strings with English defaults
- **BetterStrings** (`lib/config/better_strings_widget.dart`): InheritedWidget for providing strings to the widget tree
- **Context extension** (`context.strings`): Easy access to strings throughout the app

**Usage:**

```dart
// Accessing strings
Text(context.strings.profile)
Text(context.strings.durationInMinutes(5))

// Wrapping your app (optional - falls back to English if not wrapped)
MaterialApp(
  home: BetterStrings(
    child: MyApp(),
  ),
);

// Custom strings (override specific translations)
class CustomStrings extends BetterStringsData {
  @override
  String get profile => 'Mi Perfil';
}

MaterialApp(
  home: BetterStrings(
    data: CustomStrings(),
    child: MyApp(),
  ),
);
```

### Country and Language Data

The design system provides built-in country and language data for phone number fields and language selection:

**CountryInfo** (`lib/config/country_data.dart`):
- ISO2-based country identification (e.g., "US", "GB")
- ~100 countries with dial codes and names
- Flag assets automatically resolved from `better_assets` package
- Helper functions: `getAllCountries()`, `searchCountries(query)`

**Usage:**
```dart
// Phone number field uses ISO2 codes in tuples
AppPhoneNumberField(
  initialValue: ("US", null),  // (ISO2 code, phone number)
  onChanged: ((String, String?) value) {
    print('Country: ${value.$1}, Phone: ${value.$2}');
  },
)

// Access country information
final us = countryData['US'];
print(us!.dialCode);  // "1"
print(us.name);       // "United States"
print(us.flagPath);   // "assets/countries/us.svg.png"

// Search countries
final results = searchCountries('united');  // Returns US, GB, AE
```

**LanguageInfo** (`lib/config/language_data.dart`):
- 29 supported languages with locale codes
- Reuses country flags for language representation
- Built-in search functionality
- Extension methods for easy lookup

**Usage:**
```dart
// Language selection
AppSelectLanguageDialogTemplate(
  selectedLocale: 'en',
  onLanguageSelected: (code) => print('Selected: $code'),
)

// Access language information
final english = supportedLanguages.byCode('en');
print(english!.name);  // "English"
print(english.flagIso2);  // "us"

// Search languages
final results = supportedLanguages.search('spa');  // Returns Spanish
```

**Extending the Lists:**

If you need additional countries or languages:
```dart
// Custom countries (in your app)
final customCountries = [
  ...getAllCountries(),
  const CountryInfo(iso2Code: 'XX', dialCode: '999', name: 'Custom Country'),
];

// Custom languages (in your app)
const customLanguages = [
  ...supportedLanguages,
  LanguageInfo(code: 'custom', name: 'Custom Language', flagIso2: 'us'),
];
```

### Environment Files

The project uses environment-specific configuration via flutter_dotenv:

- `.env.dev` for development
- `.env.prod` for production

These are loaded conditionally based on build mode in the showcase app.

### Responsive Design

The design system is built with responsive design in mind:

- Use `context.isDesktop`, `context.isTablet`, `context.isMobile` extensions
- Themes accept `isDesktop` parameter for platform-specific styling
- Templates often have responsive variants (e.g., `responsive_tabbed_screen_template`)

### ColorSystem Access

Access the extended color system via:

```dart
final colorSystem = Theme.of(context).extension<ColorSystem>()!;
// Then use: colorSystem.primary, colorSystem.success, etc.
```

### Testing

Run tests from the root directory:

```bash
flutter test
```

## Code Review Standards

This section defines the strict coding standards enforced during code reviews. All pull requests must adhere to these patterns.

### Critical Violations (Must Fix Before Merge)

These violations will block PR approval:

#### 1. Color System Usage

**ALWAYS use ColorSystem extension, NEVER use Theme.colorScheme directly:**

```dart
// ✅ CORRECT
final bgColor = context.colors.primary;
final textColor = context.colors.onSurface;
final containerColor = context.colors.successContainer;

// ❌ WRONG - Will be REJECTED
final bgColor = Theme.of(context).colorScheme.primary;
final textColor = Theme.of(context).colorScheme.onSurface;
```

**Use SemanticColor enum for component parameters:**

```dart
// ✅ CORRECT
class AppButton extends StatelessWidget {
  final SemanticColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.main(context),
      child: Text(
        'Button',
        style: TextStyle(color: color.onColor(context)),
      ),
    );
  }
}

// ❌ WRONG - Hardcoded colors
class AppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,  // NEVER use direct colors
      child: Text('Button'),
    );
  }
}
```

**Access semantic color variants properly:**

```dart
// Available variants for each semantic color:
color.main(context)              // Base color
color.bold(context)              // Bold variant
color.disabled(context)          // Disabled state
color.variant(context)           // Variant color
color.variantLow(context)        // Low opacity variant
color.onColor(context)           // Text/icon color on this color
color.containerColor(context)    // Container background
```

#### 2. Responsive Design Patterns

**ALWAYS use responsive extensions, NEVER hardcode breakpoints:**

```dart
// ✅ CORRECT
if (context.isDesktop) {
  return DesktopLayout();
} else if (context.isTablet) {
  return TabletLayout();
} else {
  return MobileLayout();
}

// ✅ CORRECT - Adaptive values
final padding = context.responsive(
  16.0,
  lg: 24.0,
  xl: 32.0,
);

// ❌ WRONG - Hardcoded breakpoints
if (MediaQuery.of(context).size.width > 1024) {
  return DesktopLayout();
}

// ❌ WRONG - Manual size checks
final screenWidth = MediaQuery.of(context).size.width;
if (screenWidth >= 768 && screenWidth < 1024) {
  return TabletLayout();
}
```

**ALWAYS pass isDesktop when generating themes:**

```dart
// ✅ CORRECT
MaterialApp(
  theme: BetterTheme.cobaltLight(context.isDesktop),
  darkTheme: BetterTheme.cobaltDark(context.isDesktop),
);

// ❌ WRONG - Missing isDesktop parameter
MaterialApp(
  theme: BetterTheme.cobaltLight(true),  // Hardcoded
);
```

#### 3. Dart 3.10+ Modern Patterns

**ALWAYS use switch expressions for enum logic, NEVER use if/else chains:**

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

// ❌ WRONG - If/else chain
Color _backgroundColor(BuildContext context) {
  if (style == TagStyle.fill) {
    return color.main(context);
  } else if (style == TagStyle.outline) {
    return context.colors.surface;
  } else {
    return color.containerColor(context);
  }
}
```

**Use pattern matching in switch expressions:**

```dart
// ✅ CORRECT - Pattern matching with records
child: switch (data) {
  ApiResponseInitial() => const SizedBox(),
  ApiResponseLoading() => const CircularProgressIndicator(),
  ApiResponseError(:final message) => Text('Error: $message'),
  ApiResponseLoaded(:final data) => ContentWidget(data: data),
};

// ✅ CORRECT - Destructuring in patterns
final point = (x: 10, y: 20);
final description = switch (point) {
  (x: 0, y: 0) => 'Origin',
  (x: var x, y: 0) => 'On X-axis at $x',
  (x: 0, y: var y) => 'On Y-axis at $y',
  (x: var x, y: var y) => 'Point at ($x, $y)',
};
```

**ALWAYS use const constructors where possible:**

```dart
// ✅ CORRECT
const AppTag({
  super.key,
  required this.text,
  this.color = SemanticColor.primary,
  this.size = TagSize.medium,
});

// Usage
const AppTag(text: 'Label')

// ❌ WRONG - Missing const
AppTag({
  super.key,
  required this.text,
  this.color = SemanticColor.primary,
});
```

#### 4. Code Duplication & Readability

**Extract repeated code into helper methods:**

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

// ❌ WRONG - Repeated decoration logic
class AppCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: context.colors.outline.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text('Card 1'),
    );
  }
}

class AppCard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(  // DUPLICATED!
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: context.colors.outline.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text('Card 2'),
    );
  }
}
```

**Keep methods focused (under 50 lines):**

```dart
// ✅ CORRECT - Focused method
Widget _buildUserSection(BuildContext context) {
  return Column(
    children: [
      _buildAvatar(),
      const SizedBox(height: 8),
      _buildUserInfo(),
    ],
  );
}

Widget _buildAvatar() => CircleAvatar(
  radius: 40,
  backgroundImage: NetworkImage(userImageUrl),
);

Widget _buildUserInfo() => Column(
  children: [
    Text(userName),
    Text(userEmail),
  ],
);

// ❌ WRONG - Too long, should be split
Widget _buildUserSection(BuildContext context) {
  return Column(
    children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(userImageUrl),
      ),
      const SizedBox(height: 8),
      Text(userName, style: context.textTheme.titleLarge),
      Text(userEmail, style: context.textTheme.bodyMedium),
      const SizedBox(height: 16),
      // ... 40+ more lines of complex logic
    ],
  );
}
```

**Use descriptive names:**

```dart
// ✅ CORRECT
final isUserAuthenticated = user != null;
final maximumAllowedRetries = 3;
Color _calculateBackgroundColorBasedOnState(BuildContext context) => ...;

// ❌ WRONG - Unclear names
final flag = user != null;
final max = 3;
Color _getBg(BuildContext context) => ...;
```

### Secondary Quality Checks

#### Atomic Design Structure

Components must be placed in the correct category:

- **Atoms** (`lib/atoms/`): Single-purpose, indivisible components
  - Examples: Buttons, badges, switches, inputs, avatars

- **Molecules** (`lib/molecules/`): Simple combinations of atoms
  - Examples: List items, cards, tooltips, rating bars

- **Organisms** (`lib/organisms/`): Complex, feature-rich components
  - Examples: Data tables, navigation bars, profile headers

- **Templates** (`lib/templates/`): Complete screen layouts
  - Examples: Login scaffolds, profile screens, dashboard layouts

#### Component Naming Conventions

```dart
// ✅ CORRECT
class AppSoftButton extends StatelessWidget { }
class AppTag extends StatelessWidget { }
class AppStatusBadge extends StatelessWidget { }

// File: soft_button.dart
// File: tag.dart
// File: status_badge.dart

// ❌ WRONG
class SoftButton extends StatelessWidget { }  // Missing "App" prefix
class app_tag extends StatelessWidget { }      // Wrong case
// File: SoftButton.dart                        // Should be snake_case
```

#### Documentation Requirements

All public components must have dartdoc comments:

```dart
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
```

#### Resource Management

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

#### Null Safety Patterns

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

#### Code Cleanliness

Run `dart fix --apply` to remove:

- Unused imports
- Unnecessary casts
- Deprecated API usage

```bash
# Before committing
dart fix --apply
```

### Review Process Summary

When reviewing PRs, check in this order:

1. **Critical violations** (color system, responsive patterns, Dart 3.10+ usage, duplication)
2. **Atomic design structure** (correct category placement)
3. **Naming conventions** (App prefix, snake_case files)
4. **Documentation** (dartdoc comments present)
5. **Resource management** (proper disposal)
6. **Code cleanliness** (no unused imports)

Any critical violation should block the PR. Secondary issues should be highlighted as improvement suggestions with specific code examples.
