# Build UI with AI

Create Flutter screens using natural language. Describe what you want, and the AI generates production-ready code using BetterSuite components.

---

## How It Works

With the MCP Server installed, your AI assistant has deep knowledge of all 200+ BetterSuite components. Simply describe the UI you need:

> "Create a login screen with email and password fields, a primary login button, and a 'forgot password' link"

The AI selects the right components (`AppTextField`, `AppFilledButton`, `AppTextButton`) with proper properties and theming.

---

## Example Prompts

### Authentication Screens

> "Create a registration form with name, email, password, and confirm password fields. Add a terms checkbox and a sign up button."

```dart
Column(
  children: [
    AppTextField(
      label: 'Full Name',
      prefixIcon: Icons.person_outlined,
    ),
    const SizedBox(height: 16),
    AppTextField(
      label: 'Email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email_outlined,
    ),
    const SizedBox(height: 16),
    AppTextField(
      label: 'Password',
      obscureText: true,
      prefixIcon: Icons.lock_outlined,
    ),
    const SizedBox(height: 16),
    AppTextField(
      label: 'Confirm Password',
      obscureText: true,
      prefixIcon: Icons.lock_outlined,
    ),
    const SizedBox(height: 16),
    AppCheckboxTile(
      value: acceptedTerms,
      title: 'I accept the Terms of Service',
      onChanged: (value) => setState(() => acceptedTerms = value!),
    ),
    const SizedBox(height: 24),
    AppFilledButton(
      text: 'Sign Up',
      isFullWidth: true,
      onPressed: acceptedTerms ? handleSignUp : null,
    ),
  ],
)
```

### Data Display

> "Show me how to use AppDataTable with sorting and pagination"

```dart
AppDataTable<User>(
  columns: [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Email')),
    DataColumn(label: Text('Role')),
  ],
  rows: users.map((user) => DataRow(
    cells: [
      DataCell(Text(user.name)),
      DataCell(Text(user.email)),
      DataCell(AppBadge(text: user.role)),
    ],
  )).toList(),
  sortColumnIndex: sortColumn,
  sortAscending: sortAscending,
  onSort: (columnIndex, ascending) {
    setState(() {
      sortColumn = columnIndex;
      sortAscending = ascending;
    });
  },
)
```

### Navigation

> "Create a bottom navigation with home, search, orders, and profile tabs"

```dart
AppBottomNavigationBar(
  currentIndex: selectedIndex,
  onTap: (index) => setState(() => selectedIndex = index),
  items: [
    AppBottomNavigationBarItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    AppBottomNavigationBarItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: 'Search',
    ),
    AppBottomNavigationBarItem(
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long,
      label: 'Orders',
    ),
    AppBottomNavigationBarItem(
      icon: Icons.person_outlined,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ],
)
```

### Cards and Lists

> "Create a product card with image, title, price, and add to cart button"

```dart
AppCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.imageUrl,
          height: 160,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            AppFilledButton(
              text: 'Add to Cart',
              isFullWidth: true,
              size: ButtonSize.small,
              prefixIcon: Icons.add_shopping_cart,
              onPressed: () => addToCart(product),
            ),
          ],
        ),
      ),
    ],
  ),
)
```

---

## Getting Correct Code

The AI assistant knows all component properties and generates code with:

### Correct Property Names

> "Make the button show a loading spinner"

```dart
AppFilledButton(
  text: 'Submit',
  isLoading: true,  // Correct property name
)
```

### Correct Enum Values

> "Create an outlined button with warning color"

```dart
AppOutlinedButton(
  text: 'Delete',
  color: SemanticColor.warning,  // Correct enum
)
```

### Correct Types

> "Add a date picker field"

```dart
AppDatePickerField(
  label: 'Birth Date',
  value: selectedDate,
  onChanged: (DateTime? date) {  // Correct type
    setState(() => selectedDate = date);
  },
)
```

---

## Best Practices

### Be Descriptive

Instead of:
> "Create a form"

Say:
> "Create a checkout form with billing address (street, city, state, zip), payment method selector, and a place order button"

### Specify States

> "The submit button should be disabled until all fields are valid, and show loading state while submitting"

### Mention Interactions

> "When the user taps a list item, show a bottom sheet with item details"

### Ask for Complete Examples

> "Show me a complete payment screen with card input, saved cards list, and add new card flow"

---

## Component Discovery

Ask AI about available components:

> "What button variants are available in BetterSuite?"

> "Show me all the input components"

> "What components can I use for displaying user profiles?"

The AI will list relevant components with their properties and usage examples.

---

## Next Steps

- [Figma to Flutter](figma-to-flutter) - Convert designs to code
- [Theme Generation](theme-generation) - Generate custom themes
- [Overview](ai-overview) - Installation and setup
