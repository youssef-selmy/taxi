# Organisms

Organisms are complex UI sections composed of multiple molecules and atoms. They represent complete functional areas like data tables, navigation bars, forms, and dialogs that form major parts of the user interface.

---

## Categories

### Data

Components for displaying and managing data collections:

- **DataTable** - Full-featured data table with search, sorting, filtering, and pagination
- **ListView** - Scrollable list with various item layouts
- **GridView** - Grid-based data display

```dart
BetterDataTable<List<User>, String>(
  title: 'Users',
  subtitle: 'Manage your team members',
  columns: [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Email')),
    DataColumn(label: Text('Status')),
  ],
  data: _usersResponse,
  getRowCount: (users) => users.length,
  rowBuilder: (users, index) {
    final user = users[index];
    return DataRow(
      cells: [
        DataCell(Text(user.name)),
        DataCell(Text(user.email)),
        DataCell(BetterBadge(text: user.status)),
      ],
    );
  },
  searchBarOptions: TableSearchBarOptions(
    enabled: true,
    hintText: 'Search users...',
    onChanged: (query) => searchUsers(query),
  ),
)
```

**DataTable Features:**
- API response integration
- Built-in search bar
- Column sorting
- Pagination controls
- Row selection
- Action buttons

---

### Navigation

Complex navigation components for app structure:

- **DesktopTopBar** - Desktop page header with title
- **MobileTopBar** - Mobile navigation bar with back button
- **Drawer** - Side navigation panel
- **Sidebar** - Persistent navigation sidebar

```dart
// Desktop
BetterDesktopTopBar(
  title: 'Dashboard',
  subtitle: 'View your performance metrics',
)

// Mobile
BetterMobileTopBar(
  title: 'Order Details',
  onBackPressed: () => Navigator.pop(context),
  suffixActions: [
    BetterIconButton(
      icon: Icons.share,
      onPressed: () => share(),
    ),
  ],
)
```

---

### Forms

Complex form layouts and orchestration:

- **FormSection** - Grouped form fields with header
- **MultiStepForm** - Step-by-step form wizard
- **FormValidation** - Form-level validation handling

```dart
BetterFormSection(
  title: 'Personal Information',
  children: [
    BetterTextField(label: 'First Name'),
    BetterTextField(label: 'Last Name'),
    BetterTextField(label: 'Email'),
  ],
)
```

---

### Feedback

Complex feedback and interaction patterns:

- **Dialog** - Modal dialog with actions
- **BottomSheet** - Slide-up panel
- **AlertDialog** - Confirmation dialogs
- **SnackBar** - Bottom notification bar

```dart
BetterDialog(
  title: 'Confirm Delete',
  content: Text('Are you sure you want to delete this item?'),
  actions: [
    BetterOutlinedButton(
      text: 'Cancel',
      onPressed: () => Navigator.pop(context),
    ),
    BetterFilledButton(
      text: 'Delete',
      color: SemanticColor.error,
      onPressed: () => deleteItem(),
    ),
  ],
)
```

---

### Profile

User profile and account components:

- **ProfileHeader** - User profile display with avatar
- **SettingsSection** - Settings group with toggles
- **AccountCard** - Account information display

```dart
BetterProfileHeader(
  name: 'John Doe',
  email: 'john@example.com',
  avatarUrl: 'https://example.com/avatar.jpg',
  onEditPressed: () => editProfile(),
)
```

---

### Map

Location and map-related components:

- **MapView** - Interactive map display
- **LocationPicker** - Location selection interface
- **AddressCard** - Address display component

---

## Quick Reference

| Category | Key Components |
|----------|---------------|
| Data | DataTable, ListView, GridView |
| Navigation | DesktopTopBar, MobileTopBar, Drawer, Sidebar |
| Forms | FormSection, MultiStepForm, FormValidation |
| Feedback | Dialog, BottomSheet, AlertDialog |
| Profile | ProfileHeader, SettingsSection, AccountCard |
| Map | MapView, LocationPicker, AddressCard |

---

## Responsive Design

Organisms are designed to work across different screen sizes:

```dart
// Desktop layout
if (context.isDesktop) {
  return Row(
    children: [
      Sidebar(...),
      Expanded(child: DataTable(...)),
    ],
  );
}

// Mobile layout
return Column(
  children: [
    MobileTopBar(...),
    Expanded(child: ListView(...)),
  ],
);
```

---

## Next Steps

- [Molecules](molecules) - Composed components
- [Templates](templates) - Page-level layouts
- [Spacing](spacing) - Layout utilities
