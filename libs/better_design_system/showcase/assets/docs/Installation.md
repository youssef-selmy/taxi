# Installation

This guide will help you set up BetterUI in your Flutter project and start using components.

---

## Add Dependency

Add BetterUI to your `pubspec.yaml`:

```yaml
dependencies:
  better_design_system:
    path: ../libs/better_design_system
```

Then run:

```bash
flutter pub get
```

---

## Import

Import the design system in your Dart files:

```dart
import 'package:better_design_system/better_design_system.dart';
```

---

## Apply Theme

In your `main.dart`, apply the BetterUI theme:

```dart
import 'package:flutter/material.dart';
import 'package:better_design_system/better_design_system.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: BetterTheme.fromBetterTheme(
        BetterThemes.cobalt,
        false,  // isDesktop
        false,  // isDark
      ),
      darkTheme: BetterTheme.fromBetterTheme(
        BetterThemes.cobalt,
        false,
        true,
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
```

---

## Using Components

### Atoms

Atoms are the basic building blocks:

```dart
// Button
BetterFilledButton(
  text: 'Click Me',
  onPressed: () => print('Clicked!'),
)

// Avatar
BetterAvatar(
  imageUrl: 'https://example.com/photo.jpg',
  size: AvatarSize.size64px,
)

// Badge
BetterBadge(
  text: 'New',
  color: SemanticColor.success,
)
```

### Molecules

Molecules combine multiple atoms:

```dart
// Date Picker
BetterDatePicker(
  activeDate: DateTime.now(),
  onChanged: (date) => print(date),
)

// Rating Bar
BetterRatingBar(
  rating: 4.5,
  onChanged: (rating) => print(rating),
)
```

### Organisms

Organisms are complex, self-contained sections:

```dart
// Data Table
BetterDataTable<List<User>, String>(
  columns: [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Email')),
  ],
  data: usersResponse,
  getRowCount: (users) => users.length,
  rowBuilder: (users, index) => buildRow(users[index]),
)

// Mobile Top Bar
BetterMobileTopBar(
  title: 'Dashboard',
  onBackPressed: () => Navigator.pop(context),
)
```

### Templates

Templates provide complete page layouts:

```dart
// Login Screen
BetterLoginForm(
  title: 'Welcome Back',
  content: LoginFormFields(),
  primaryButton: BetterFilledButton(
    text: 'Sign In',
    onPressed: () => signIn(),
  ),
)
```

---

## Accessing Colors

Access the color system in your widgets:

```dart
// Get the color system
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

- [Theming](theming) - Customize colors and themes
- [Colors](colors) - Understand the color system
- [Atoms](atoms) - Explore basic components
- [Templates](templates) - Use complete page layouts
