# Molecules

Molecules are composed components built by combining multiple atoms. They represent more complex UI patterns like date pickers, navigation bars, and form groups that work together as a unit.

---

## Categories

### Date & Time

Calendar and time selection components with multiple selection modes:

- **DatePicker** - Calendar-based date selection
- **TimePicker** - Time selection component
- **DateTimeField** - Combined date/time input field

```dart
BetterDatePicker(
  activeDate: selectedDate,
  selectionMode: DatePickerSelectionMode.day,
  onChanged: (date) => setState(() => selectedDate = date),
)

// Range selection
BetterDatePicker.range(
  rangeDate: (startDate, endDate),
  onChanged: (start, end) => setDateRange(start, end),
)
```

**Selection Modes:**
- `day` - Single day selection
- `week` - Select entire week
- `month` - Select entire month
- `year` - Select entire year
- `range` - Custom date range

---

### Navigation

Complex navigation components for app structure:

- **BottomNavigation** - Mobile bottom navigation bar
- **Stepper** - Multi-step process indicator
- **Breadcrumbs** - Hierarchical navigation
- **TabBar** - Tab-based navigation

```dart
BetterBottomNavigation<String>(
  selectedValue: selectedTab,
  onTap: (value) => setState(() => selectedTab = value),
  primaryActionPosition: PrimaryActionPosition.floating,
  primaryAction: BottomNavFab(
    icon: Icon(Icons.add),
    onPressed: () => createNew(),
  ),
  items: [
    NavigationItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
      value: 'home',
    ),
    // ... more items
  ],
)
```

**Bottom Navigation Types:**
- `normal` - Solid background
- `blur` - Blurred background effect

---

### Inputs

Composite input components:

- **SearchField** - Search input with suggestions
- **FileUpload** - File selection and upload
- **PhoneInput** - Phone number with country code
- **OTPInput** - One-time password entry

```dart
BetterSearchField(
  hint: 'Search products...',
  onChanged: (query) => search(query),
  onSubmitted: (query) => submitSearch(query),
)

BetterPhoneInput(
  initialCountryCode: 'US',
  onChanged: (phone) => setPhone(phone),
)
```

---

### Data Display

Components for visualizing data:

- **KPICard** - Key performance indicator display
- **StatCard** - Statistical data display
- **ChartCard** - Chart with container
- **ListTile** - List item with actions

```dart
BetterKPICard(
  title: 'Total Revenue',
  value: '\$24,500',
  trend: TrendDirection.up,
  trendValue: '+12%',
)
```

---

### Feedback

Interactive feedback components:

- **Tooltip** - Contextual hints on hover
- **RatingBar** - Star/emoji rating input
- **Skeleton** - Loading placeholder

```dart
BetterRatingBar(
  rating: 4.5,
  maxRating: 5,
  onChanged: (value) => setRating(value),
)

BetterSkeleton(
  height: 200,
  borderRadius: BorderRadius.circular(8),
)
```

---

### Misc

Utility molecules for various use cases:

- **Accordion** - Expandable content sections
- **Kanban** - Kanban board layout
- **ActivityLog** - Timeline of events
- **DragDrop** - Drag and drop interface

```dart
BetterAccordion(
  title: 'FAQ Section',
  children: [
    AccordionItem(
      title: 'How do I get started?',
      content: Text('Follow our getting started guide...'),
    ),
  ],
)
```

---

## Quick Reference

| Category | Key Components |
|----------|---------------|
| Date & Time | DatePicker, TimePicker, DateTimeField |
| Navigation | BottomNavigation, Stepper, TabBar |
| Inputs | SearchField, FileUpload, PhoneInput, OTPInput |
| Data Display | KPICard, StatCard, ListTile |
| Feedback | Tooltip, RatingBar, Skeleton |
| Misc | Accordion, Kanban, ActivityLog |

---

## Next Steps

- [Atoms](atoms) - Basic building blocks
- [Organisms](organisms) - Complex UI sections
- [Theming](theming) - Customize appearance
