# Figma to Flutter

The most powerful workflow combines the BetterSuite Figma file with AI-assisted implementation. Design your screens in Figma, then let AI generate production-ready Flutter code.

---

## The Workflow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Design    │ ──▶ │   Share     │ ──▶ │   Flutter   │
│  in Figma   │     │  with AI    │     │    Code     │
└─────────────┘     └─────────────┘     └─────────────┘
```

### 1. Design in Figma

Use the BetterSuite Figma design system file to create your app screens. The Figma file contains all the same components available in the Flutter library:

- Buttons (Filled, Outlined, Text, Soft, Link)
- Input fields and forms
- Cards and containers
- Navigation components
- Feedback elements
- And 200+ more components

### 2. Share Your Design with AI

When your design is ready, share it with your AI assistant:

> "Here's my Figma design for the checkout screen. Implement this using BetterSuite components."

You can share designs by:

| Method | How to Use |
|--------|------------|
| **Figma Link** | Paste the Figma frame URL directly |
| **Screenshot** | Upload a screenshot of your design |
| **Description** | Describe the layout and components used |

### 3. AI Generates Flutter Code

The AI recognizes BetterSuite components from your Figma design and generates accurate Flutter code:

```dart
// AI recognizes your Figma design and generates:
Column(
  children: [
    AppTopBarMobile(title: 'Checkout'),
    AppTextField(
      label: 'Card Number',
      prefixIcon: Icons.credit_card,
    ),
    AppTextField(label: 'Expiry Date'),
    AppFilledButton(
      text: 'Pay Now',
      color: SemanticColor.primary,
      onPressed: () => processPayment(),
    ),
  ],
)
```

---

## Why This Works

### 1:1 Component Mapping

Every component in the Figma file has an exact Flutter counterpart:

| Figma Component | Flutter Widget |
|-----------------|----------------|
| Primary Button | `AppFilledButton` |
| Text Input | `AppTextField` |
| Top Bar (Mobile) | `AppTopBarMobile` |
| Card | `AppCard` |
| Avatar | `AppAvatar` |
| Dropdown | `AppDropdownField` |

### AI Knows the Properties

The MCP Server gives AI deep knowledge of every component:

- Required vs optional properties
- Available variants and states
- Correct enum values
- Proper theming integration

### Consistent Output

Generated code automatically follows:

- Design system conventions
- Correct color tokens
- Proper spacing values
- Typography scales

---

## Example: Login Screen

**Your Figma design includes:**
- App logo at top
- Email input field
- Password input field
- "Login" primary button
- "Forgot password?" text link

**You say:**
> "Implement this login screen from my Figma design"

**AI generates:**

```dart
Scaffold(
  body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Image.asset('assets/logo.png', height: 64),
          const SizedBox(height: 48),

          // Email field
          AppTextField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
          ),
          const SizedBox(height: 16),

          // Password field
          AppTextField(
            label: 'Password',
            obscureText: true,
            prefixIcon: Icons.lock_outlined,
          ),
          const SizedBox(height: 24),

          // Login button
          AppFilledButton(
            text: 'Login',
            isFullWidth: true,
            onPressed: () => handleLogin(),
          ),
          const SizedBox(height: 16),

          // Forgot password link
          AppTextButton(
            text: 'Forgot password?',
            onPressed: () => showForgotPassword(),
          ),
        ],
      ),
    ),
  ),
)
```

---

## Tips for Best Results

### Be Specific About Interactions

> "The login button should show a loading state while authenticating"

```dart
AppFilledButton(
  text: 'Login',
  isLoading: isAuthenticating,
  onPressed: isAuthenticating ? null : () => handleLogin(),
)
```

### Mention Component States

> "The email field should show an error state if invalid"

```dart
AppTextField(
  label: 'Email',
  errorText: emailError,
  prefixIcon: Icons.email_outlined,
)
```

### Reference Specific Figma Frames

> "Use the 'Checkout - Step 2' frame from my Figma file"

This helps AI understand exactly which screen you're implementing.

---

## Next Steps

- [Build UI with AI](build-ui-with-ai) - Create screens without Figma
- [Theme Generation](theme-generation) - Generate custom themes
- [Overview](ai-overview) - Installation and setup
