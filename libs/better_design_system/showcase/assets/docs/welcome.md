# Welcome to BetterUI

**BetterUI** is a comprehensive Flutter design system built on **atomic design principles**. It provides a complete set of UI components, theming capabilities, and layout utilities to help you build beautiful, consistent Flutter applications.

---

## Core Principles

BetterUI follows the atomic design methodology, organizing components into four hierarchical levels:

| Level | Description | Examples |
|-------|-------------|----------|
| **Atoms** | Basic building blocks | Buttons, inputs, badges, avatars |
| **Molecules** | Groups of atoms working together | Date pickers, file uploads, tooltips |
| **Organisms** | Complex UI sections | Data tables, navigation bars, dialogs |
| **Templates** | Page-level layouts | Login screens, profile pages, wallets |

---

## Key Features

### Theming System

BetterUI includes **9 pre-built color schemes**, each with full light and dark mode support:

- **Cobalt** - Deep blue with yellow highlights (default)
- **Electric Indigo** - Bold purple, vibrant feel
- **Coral Red** - High-contrast red, energetic
- **Earthy Green** - Organic, nature-oriented
- **Noir** - Dark mode minimalist
- **Hyper Pink** - Neon-style vibrant pink
- **Sunburst Yellow** - Bright, optimistic
- **Autumn Orange** - Earthy, burnt-orange
- **Hera** - Classic, professional

### Component Library

With **200+ components** across all atomic levels, BetterUI provides:

- **40 Atoms** - Buttons, inputs, badges, navigation, feedback indicators
- **31 Molecules** - Date pickers, charts, file uploads, kanban boards
- **16 Organisms** - Data tables, top bars, drawers, dialogs
- **18 Templates** - Login flows, profile screens, payment workflows

### Design Tokens

Consistent design language through:

- **ColorSystem** - Semantic colors that adapt to themes
- **Typography** - Text styles and font scales
- **Shadows** - Elevation system
- **Spacing** - Layout utilities and responsive helpers

---

## Quick Start

```dart
import 'package:better_design_system/better_design_system.dart';

// Apply a theme in your app
MaterialApp(
  theme: BetterTheme.fromBetterTheme(
    BetterThemes.cobalt,
    context.isDesktop,
    false,
  ),
  darkTheme: BetterTheme.fromBetterTheme(
    BetterThemes.cobalt,
    context.isDesktop,
    true,
  ),
  themeMode: ThemeMode.system,
)
```

---

## Next Steps

- [Installation](installation) - Setup and basic usage
- [Theming](theming) - Customize colors and themes
- [Atoms](atoms) - Explore basic components
- [AI Assistant](ai-overview) - Build with AI assistance
