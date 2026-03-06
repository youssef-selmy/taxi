# Atoms

Atoms are the basic building blocks of BetterUI - the smallest, indivisible components that form the foundation of the design system. They include buttons, inputs, badges, avatars, and other fundamental UI elements.

---

## Categories

### Buttons

Interactive elements for user actions. BetterUI provides multiple button types for different contexts:

- **FilledButton** - Primary call-to-action with solid background
- **SoftButton** - Softer styled with container background
- **OutlinedButton** - Border with transparent background
- **TextButton** - Minimal text-only button
- **LinkButton** - Text button with underline on hover
- **IconButton** - Icon-only button with optional badge
- **FloatingActionButton** - Floating action button (FAB)

```dart
BetterFilledButton(
  text: 'Submit',
  onPressed: () => handleSubmit(),
)

BetterIconButton(
  icon: Icons.notifications,
  badgeCount: 5,
  onPressed: () => openNotifications(),
)
```

All buttons support:
- **Sizes**: `small`, `medium`, `large`, `extraLarge`
- **Colors**: All `SemanticColor` values
- **States**: Loading, disabled, selected
- **Icons**: Prefix and suffix icons

---

### Display

Visual indicators and status elements for displaying information:

- **Badge** - Status labels, counters, and indicators
- **Avatar** - User profile images with status badges
- **Tag** - Labels for categorization and filtering

```dart
BetterBadge(
  text: 'New',
  color: SemanticColor.success,
  style: BadgeStyle.soft,
)

BetterAvatar(
  imageUrl: 'https://example.com/avatar.jpg',
  size: AvatarSize.size64px,
  statusBadgeType: StatusBadgeType.online,
)

BetterTag(
  text: 'Flutter',
  prefixIcon: Icons.code,
  onRemovedPressed: () => removeTag(),
)
```

---

### Inputs

Form elements for collecting user data:

- **TextField** - Text input with validation support
- **Checkbox** - Boolean toggle control
- **Radio** - Single selection from options
- **Switch** - On/off toggle
- **DropdownField** - Single and multi-select dropdowns

```dart
BetterTextField(
  label: 'Email',
  hint: 'Enter your email',
  prefixIcon: Icon(Icons.email),
  errorText: emailError,
  onChanged: (value) => validateEmail(value),
)

BetterSwitch(
  isSelected: isDarkMode,
  onChanged: (value) => toggleDarkMode(value),
)
```

---

### Feedback

Loading and progress indicators for user feedback:

- **Toast** - Temporary notification messages
- **Banner** - Persistent informational messages
- **CircularProgressBar** - Circular loading/progress indicator
- **LinearProgressBar** - Linear progress with labels

```dart
BetterToast(
  title: 'Item saved successfully',
  color: SemanticColor.success,
  actions: [
    ToastAction(title: 'Undo', onPressed: () => undo()),
  ],
)

BetterCircularProgressBar(
  progress: 0.75,
  status: CircularProgressBarStatus.uploading,
  showProgressNumber: true,
)
```

---

### Navigation

Navigation and wayfinding elements:

- **Tabs** - Tab navigation
- **Breadcrumbs** - Page hierarchy navigation
- **Pagination** - Page navigation controls

---

### Layout

Structural and spacing components:

- **Divider** - Content separators
- **Card** - Content containers
- **Container** - Layout wrappers

---

## Quick Reference

| Category | Key Components |
|----------|---------------|
| Buttons | FilledButton, SoftButton, OutlinedButton, IconButton, FAB |
| Display | Badge, Avatar, Tag |
| Inputs | TextField, Checkbox, Radio, Switch, Dropdown |
| Feedback | Toast, Banner, CircularProgress, LinearProgress |
| Navigation | Tabs, Breadcrumbs, Pagination |
| Layout | Divider, Card, Container |

---

## Semantic Colors

All atom components support `SemanticColor` for consistent theming:

| Color | Usage |
|-------|-------|
| `primary` | Primary brand actions |
| `secondary` | Secondary actions |
| `tertiary` | Tertiary emphasis |
| `neutral` | Neutral/default state |
| `success` | Positive/success states |
| `warning` | Caution/warning states |
| `error` | Error/destructive states |
| `info` | Informational states |

---

## Next Steps

- [Molecules](molecules) - Composed components built from atoms
- [Colors](colors) - Color system reference
- [Typography](typography) - Text styles
