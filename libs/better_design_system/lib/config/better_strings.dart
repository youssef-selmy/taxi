/// Default English strings for the BetterUI.
///
/// This class provides all translatable strings used throughout the design system.
/// Apps can extend this class to provide custom translations or override specific strings.
///
/// Example usage:
/// ```dart
/// // Use default English strings
/// MaterialApp(
///   home: BetterStrings(
///     child: MyApp(),
///   ),
/// );
///
/// // Override specific strings
/// class CustomStrings extends BetterStringsData {
///   @override
///   String get profile => 'Mi Perfil';
/// }
///
/// MaterialApp(
///   home: BetterStrings(
///     data: CustomStrings(),
///     child: MyApp(),
///   ),
/// );
/// ```
class BetterStringsData {
  const BetterStringsData();

  // ============================================================================
  // Profile & User
  // ============================================================================

  String get profile => 'Profile';
  String get guest => 'Guest';
  String get firstName => 'First name';
  String get lastName => 'Last name';
  String get email => 'Email';
  String get deleteAccount => 'Delete account';
  String get logout => 'Logout';

  // ============================================================================
  // Payment Methods
  // ============================================================================

  String get paymentMethods => 'Payment methods';
  String get paymentMethod => 'Payment method';
  String get selectPaymentMethod => 'Select payment method';
  String get addPaymentMethod => 'Add payment method';
  String get addNewPaymentMethod => 'Add new payment method';
  String get cardNumber => 'Card number';
  String get expiryDate => 'Expiry date';
  String get cvv => 'CVV';
  String get country => 'Country';
  String get zipCode => 'Zip code';
  String get zipCodeHint => 'Enter zip code';
  String get accountHolderName => 'Account holder name';
  String get savedPaymentMethod => 'Saved payment method';

  // ============================================================================
  // Wallet & Balance
  // ============================================================================

  String get wallet => 'Wallet';
  String get totalBalance => 'Total balance';
  String get addBalance => 'Add balance';
  String get addCredit => 'Add credit';
  String get selectAmount => 'Select amount';
  String get enterAmount => 'Enter amount';
  String get redeemGiftCard => 'Redeem gift card';
  String get redeemGiftCardDescription =>
      'Enter your gift card code to add balance';
  String get enterGiftCardCode => 'Enter gift card code';
  String get redeem => 'Redeem';

  // ============================================================================
  // Actions & Buttons
  // ============================================================================

  String get confirm => 'Confirm';
  String get confirmPay => 'Confirm payment';
  String get cancel => 'Cancel';
  String get submit => 'Submit';
  String get delete => 'Delete';
  String get change => 'Change';
  String get clear => 'Clear';
  String get letsGetStarted => "Let's get started";
  String get skipForNow => 'Skip for now';
  String get success => 'Success';

  // ============================================================================
  // Data Table & Pagination
  // ============================================================================

  String get searchWithDots => 'Search...';
  String get previousPage => 'Previous';
  String get nextPage => 'Next';
  String get noDataAvailable => 'No data available';
  String get search => 'Search';

  // ============================================================================
  // Date & Time
  // ============================================================================

  String get timePastDue => 'Past due';
  String get justNow => 'Just now';
  String get today => 'Today';
  String get yesterday => 'Yesterday';
  String get from => 'From';
  String get to => 'To';

  /// Formats duration in minutes with proper pluralization.
  ///
  /// Examples:
  /// - `durationInMinutes(0)` returns "0 minutes"
  /// - `durationInMinutes(1)` returns "1 minute"
  /// - `durationInMinutes(5)` returns "5 minutes"
  String durationInMinutes(num minutes) {
    if (minutes == 0) return '0 minutes';
    if (minutes == 1) return '1 minute';
    return '${minutes.toInt()} minutes';
  }

  // ============================================================================
  // Distance & Measurements
  // ============================================================================

  /// Formats distance in meters.
  ///
  /// Example: `distanceInMeters(150)` returns "150 m"
  String distanceInMeters(num distance) {
    return '${_formatNumber(distance)} m';
  }

  /// Formats distance in kilometers.
  ///
  /// Example: `distanceInKilometers(2.5)` returns "2.5 km"
  String distanceInKilometers(num distance) {
    return '${_formatNumber(distance)} km';
  }

  // Helper for number formatting
  String _formatNumber(num value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }

  // ============================================================================
  // Weekdays
  // ============================================================================

  String get monday => 'Monday';
  String get tuesday => 'Tuesday';
  String get wednesday => 'Wednesday';
  String get thursday => 'Thursday';
  String get friday => 'Friday';
  String get saturday => 'Saturday';
  String get sunday => 'Sunday';
  String get unavailable => 'Unavailable';

  // ============================================================================
  // Sorting & Filtering
  // ============================================================================

  String get oldToNew => 'Old to new';
  String get newToOld => 'New to old';
  String get aToZ => 'A to Z';
  String get zToA => 'Z to A';
  String get lowToHigh => 'Low to high';
  String get highToLow => 'High to low';
  String get ascending => 'Ascending';
  String get descending => 'Descending';
  String get unselectAll => 'Unselect all';

  // ============================================================================
  // Location & Navigation
  // ============================================================================

  String get pickupPoint => 'Pickup point';
  String get dropoffPoint => 'Drop-off point';
  String get selectCountryCode => 'Select country code';
  String get searchCountryName => 'Search country name';

  // ============================================================================
  // Shopping & Cart
  // ============================================================================

  String get addToCart => 'Add to cart';
  String get goToCart => 'Go to cart';
  String get closed => 'Closed';

  // ============================================================================
  // Activities & Transactions
  // ============================================================================

  String get activities => 'Activities';
  String get noActivitiesYet => 'No activities yet';
  String get total => 'Total';

  // ============================================================================
  // Appearance & Settings
  // ============================================================================

  String get appearance => 'Appearance';
  String get darkLightSystemDefault => 'Dark / Light / System default';
  String get darkLightSystemDefaultDescription =>
      'Select your preferred theme mode';
  String get lightMode => 'Light mode';
  String get darkMode => 'Dark mode';

  // ============================================================================
  // Language
  // ============================================================================

  String get selectLanguage => 'Select language';

  // ============================================================================
  // Messaging
  // ============================================================================

  String get typeAMessage => 'Type a message';

  // ============================================================================
  // Schedule & Time
  // ============================================================================

  String get addNewSchedule => 'Add new schedule';

  // ============================================================================
  // File Upload
  // ============================================================================

  String get uploadImage => 'Upload image';

  // ============================================================================
  // Geofence
  // ============================================================================

  String get tips => 'Tips';
  String get geofenceTips =>
      'Draw a geofence by tapping on the map to add points. You need at least 3 points to create a valid geofence.';

  // ============================================================================
  // Dropdown & Selection
  // ============================================================================

  String get select => 'Select';
  String get selectedItems => 'Selected items';
  String get typeToSearch => 'Type to search...';
  String get recentItems => 'Recent';
  String get popularItems => 'Popular';

  // ============================================================================
  // Password Validation
  // ============================================================================

  String get passwordsMatch => 'Passwords match';
  String get passwordsDoNotMatch => 'Passwords do not match';
  String get passwordLengthIsValid => 'Password length is valid';
  String get passwordRuleLength => 'At least 8 characters';
  String get passwordIsSecure => 'Password is secure';
  String get passwordRuleDescription =>
      'Password must contain at least two of the following:';
  String get passwordRuleUpperCase => 'One uppercase letter';
  String get passwordRuleLowerCase => 'One lowercase letter';
  String get passwordRuleNumber => 'One number';
  String get passwordRuleSpecialCharacter => 'One special character';
  String get passwordStrengthNone => 'None';
  String get passwordStrengthWeak => 'Weak';
  String get passwordStrengthMedium => 'Medium';
  String get passwordStrengthStrong => 'Strong';
  String get passwordStrengthVeryStrong => 'Very strong';

  // ============================================================================
  // Error Messages
  // ============================================================================

  String get somethingWentWrong => 'Something went wrong';
}
