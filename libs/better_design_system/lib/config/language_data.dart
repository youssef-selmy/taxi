/// Language information for language selection dialogs.
///
/// This provides a self-contained language database without external dependencies.
/// Languages are identified by their locale codes (e.g., "en", "en_GB", "es").
library;

/// Information about a language including code, name, and flag representation.
class LanguageInfo {
  /// Locale code (e.g., "en", "en_GB", "es", "fr")
  final String code;

  /// Display name of the language (e.g., "English", "Spanish")
  final String name;

  /// ISO2 country code for the flag (e.g., "us", "gb", "es")
  ///
  /// This reuses the country flags from better_assets package.
  final String flagIso2;

  const LanguageInfo({
    required this.code,
    required this.name,
    required this.flagIso2,
  });

  /// Path to the language flag image in the better_assets package.
  ///
  /// Usage:
  /// ```dart
  /// Image.asset(
  ///   languageInfo.flagPath,
  ///   package: 'better_assets',
  /// )
  /// ```
  String get flagPath => 'images/countries/${flagIso2.toLowerCase()}.svg.png';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageInfo &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => 'LanguageInfo($code, $name, $flagIso2)';
}

/// List of supported languages in the design system.
///
/// This list can be used as-is or extended by applications.
/// Languages are ordered alphabetically by name for consistent display.
///
/// Usage:
/// ```dart
/// // Use the built-in list
/// final languages = supportedLanguages;
///
/// // Find a language by code
/// final english = supportedLanguages.byCode('en');
///
/// // Filter languages
/// final filtered = supportedLanguages
///   .where((lang) => lang.name.contains('English'))
///   .toList();
/// ```
const List<LanguageInfo> supportedLanguages = [
  LanguageInfo(code: 'ar', name: 'Arabic', flagIso2: 'sa'),
  LanguageInfo(code: 'bn', name: 'Bengali', flagIso2: 'bd'),
  LanguageInfo(code: 'zh', name: 'Chinese', flagIso2: 'cn'),
  LanguageInfo(code: 'nl', name: 'Dutch', flagIso2: 'nl'),
  LanguageInfo(code: 'en', name: 'English', flagIso2: 'us'),
  LanguageInfo(code: 'en_GB', name: 'English (UK)', flagIso2: 'gb'),
  LanguageInfo(code: 'et', name: 'Estonian', flagIso2: 'ee'),
  LanguageInfo(code: 'fi', name: 'Finnish', flagIso2: 'fi'),
  LanguageInfo(code: 'fr', name: 'French', flagIso2: 'fr'),
  LanguageInfo(code: 'de', name: 'German', flagIso2: 'de'),
  LanguageInfo(code: 'hi', name: 'Hindi', flagIso2: 'in'),
  LanguageInfo(code: 'id', name: 'Indonesian', flagIso2: 'id'),
  LanguageInfo(code: 'it', name: 'Italian', flagIso2: 'it'),
  LanguageInfo(code: 'ja', name: 'Japanese', flagIso2: 'jp'),
  LanguageInfo(code: 'ko', name: 'Korean', flagIso2: 'kr'),
  LanguageInfo(code: 'ms', name: 'Malay', flagIso2: 'my'),
  LanguageInfo(code: 'no', name: 'Norwegian', flagIso2: 'no'),
  LanguageInfo(code: 'fa', name: 'Persian', flagIso2: 'ir'),
  LanguageInfo(code: 'pl', name: 'Polish', flagIso2: 'pl'),
  LanguageInfo(code: 'pt', name: 'Portuguese', flagIso2: 'pt'),
  LanguageInfo(code: 'ro', name: 'Romanian', flagIso2: 'ro'),
  LanguageInfo(code: 'ru', name: 'Russian', flagIso2: 'ru'),
  LanguageInfo(code: 'es', name: 'Spanish', flagIso2: 'es'),
  LanguageInfo(code: 'sv', name: 'Swedish', flagIso2: 'se'),
  LanguageInfo(code: 'th', name: 'Thai', flagIso2: 'th'),
  LanguageInfo(code: 'tr', name: 'Turkish', flagIso2: 'tr'),
  LanguageInfo(code: 'uk', name: 'Ukrainian', flagIso2: 'ua'),
  LanguageInfo(code: 'ur', name: 'Urdu', flagIso2: 'pk'),
  LanguageInfo(code: 'vi', name: 'Vietnamese', flagIso2: 'vn'),
  LanguageInfo(code: 'hy', name: 'Armenian', flagIso2: 'am'),
];

/// Extension methods for working with lists of [LanguageInfo].
extension LanguageListX on List<LanguageInfo> {
  /// Finds a language by its code.
  ///
  /// Returns null if no language with the given code is found.
  ///
  /// Example:
  /// ```dart
  /// final english = supportedLanguages.byCode('en');
  /// final spanish = supportedLanguages.byCode('es');
  /// ```
  LanguageInfo? byCode(String code) {
    try {
      return firstWhere((element) => element.code == code);
    } catch (e) {
      return null;
    }
  }

  /// Searches languages by name or code (case-insensitive).
  ///
  /// Example:
  /// ```dart
  /// final results = supportedLanguages.search('eng'); // Returns English variants
  /// final results2 = supportedLanguages.search('fr'); // Returns French
  /// ```
  List<LanguageInfo> search(String query) {
    if (query.isEmpty) return this;

    final lowerQuery = query.toLowerCase();
    return where((lang) {
      return lang.name.toLowerCase().contains(lowerQuery) ||
          lang.code.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
