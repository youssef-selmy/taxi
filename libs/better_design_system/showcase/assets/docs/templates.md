# Templates

Templates are page-level layouts that combine organisms, molecules, and atoms into complete screen designs. They provide ready-to-use screen structures for common app patterns like authentication, profiles, and payment flows.

---

## Categories

### Authentication

Pre-built authentication screen templates:

- **LoginForm** - Login screen layout
- **SignupForm** - Registration screen layout
- **OTPVerification** - One-time password screen
- **ForgotPassword** - Password reset flow

```dart
BetterLoginForm(
  title: 'Welcome Back',
  subtitle: 'Sign in to continue',
  logoTypeAssetPathLight: 'assets/logo_light.png',
  logoTypeAssetPathDark: 'assets/logo_dark.png',
  content: Column(
    children: [
      BetterTextField(
        label: 'Email',
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => _email = value,
      ),
      SizedBox(height: 16),
      BetterTextField(
        label: 'Password',
        obscureText: true,
        onChanged: (value) => _password = value,
      ),
    ],
  ),
  primaryButton: BetterFilledButton(
    text: 'Sign In',
    isLoading: isLoading,
    onPressed: () => signIn(_email, _password),
  ),
  secondaryButton: BetterTextButton(
    text: 'Forgot Password?',
    onPressed: () => navigateToForgotPassword(),
  ),
)
```

**LoginForm Features:**
- Logo support (light/dark variants)
- Step indicator for multi-step auth
- Back button for navigation
- Primary and secondary actions
- Responsive layout

---

### Profile

User profile and account screen templates:

- **ProfileScreen** - User profile display
- **EditProfile** - Profile editing layout
- **SettingsScreen** - App settings layout
- **AccountScreen** - Account management

```dart
BetterProfileScreen(
  header: BetterProfileHeader(
    name: 'John Doe',
    email: 'john@example.com',
    avatarUrl: avatarUrl,
  ),
  sections: [
    SettingsSection(
      title: 'Preferences',
      items: [
        SettingsTile(
          title: 'Dark Mode',
          trailing: BetterSwitch(
            isSelected: isDarkMode,
            onChanged: (v) => toggleDarkMode(v),
          ),
        ),
        SettingsTile(
          title: 'Notifications',
          trailing: Icon(Icons.chevron_right),
          onTap: () => openNotificationSettings(),
        ),
      ],
    ),
  ],
)
```

---

### Payment

Payment and checkout flow templates:

- **CheckoutScreen** - Order checkout layout
- **PaymentMethod** - Payment method selection
- **AddCard** - Add payment card form
- **OrderConfirmation** - Order success screen

```dart
BetterCheckoutScreen(
  orderSummary: OrderSummaryCard(
    items: cartItems,
    subtotal: subtotal,
    tax: tax,
    total: total,
  ),
  paymentSection: PaymentMethodSelector(
    methods: paymentMethods,
    selectedMethod: selectedPaymentMethod,
    onChanged: (method) => selectPaymentMethod(method),
  ),
  primaryButton: BetterFilledButton(
    text: 'Place Order',
    isLoading: isProcessing,
    onPressed: () => placeOrder(),
  ),
)
```

---

### Dialogs

Dialog and modal templates:

- **ConfirmationDialog** - Confirmation prompt
- **InfoDialog** - Informational dialog
- **FormDialog** - Dialog with form inputs
- **ImagePickerDialog** - Image selection dialog

```dart
BetterConfirmationDialog(
  title: 'Delete Account',
  message: 'This action cannot be undone. Are you sure?',
  confirmText: 'Delete',
  confirmColor: SemanticColor.error,
  cancelText: 'Cancel',
  onConfirm: () => deleteAccount(),
  onCancel: () => Navigator.pop(context),
)
```

---

### Misc

Additional screen templates:

- **OnboardingScreen** - App onboarding flow
- **EmptyState** - Empty content placeholder
- **ErrorScreen** - Error display layout
- **SplashScreen** - App loading screen

```dart
BetterEmptyState(
  icon: Icons.inbox_outlined,
  title: 'No Messages',
  subtitle: 'Your inbox is empty',
  action: BetterFilledButton(
    text: 'Compose',
    onPressed: () => composeMessage(),
  ),
)
```

---

## Quick Reference

| Category | Key Templates |
|----------|--------------|
| Auth | LoginForm, SignupForm, OTPVerification, ForgotPassword |
| Profile | ProfileScreen, EditProfile, SettingsScreen |
| Payment | CheckoutScreen, PaymentMethod, AddCard, OrderConfirmation |
| Dialogs | ConfirmationDialog, InfoDialog, FormDialog |
| Misc | OnboardingScreen, EmptyState, ErrorScreen, SplashScreen |

---

## Customization

Templates are designed to be customizable while maintaining consistency:

```dart
BetterLoginForm(
  // Override colors
  backgroundColor: colors.surface,

  // Custom content
  content: YourCustomLoginWidget(),

  // Custom actions
  primaryButton: YourCustomButton(),

  // Additional widgets
  footer: TermsAndPrivacyLinks(),
)
```

---

## Responsive Layouts

Templates automatically adapt to different screen sizes:

| Screen Size | Behavior |
|-------------|----------|
| Mobile | Full-screen layouts, bottom sheets |
| Tablet | Centered content, side panels |
| Desktop | Multi-column layouts, dialogs |

---

## Next Steps

- [Organisms](organisms) - Complex UI sections
- [Theming](theming) - Customize appearance
- [AI Assistant](ai-overview) - Build with AI
