/// Country information for phone number fields and country selection.
///
/// This provides a self-contained country database without external dependencies.
/// Countries are identified by their ISO 3166-1 alpha-2 codes (e.g., "US", "GB").
library;

/// Information about a country including dial code, name, and flag asset path.
class CountryInfo {
  /// ISO 3166-1 alpha-2 country code (e.g., "US", "GB")
  final String iso2Code;

  /// E.164 country calling code without the + (e.g., "1", "44")
  final String dialCode;

  /// Full country name (e.g., "United States", "United Kingdom")
  final String name;

  const CountryInfo({
    required this.iso2Code,
    required this.dialCode,
    required this.name,
  });

  /// Path to the country flag image in the better_assets package.
  ///
  /// Usage:
  /// ```dart
  /// Image.asset(
  ///   countryInfo.flagPath,
  ///   package: 'better_assets',
  /// )
  /// ```
  String get flagPath => 'images/countries/${iso2Code.toLowerCase()}.svg.png';

  /// Display name with dial code (e.g., "United States (+1)")
  String get displayName => '$name (+$dialCode)';

  /// Display name without dial code
  String get displayNameNoCode => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryInfo &&
          runtimeType == other.runtimeType &&
          iso2Code == other.iso2Code;

  @override
  int get hashCode => iso2Code.hashCode;

  @override
  String toString() => 'CountryInfo($iso2Code, +$dialCode, $name)';
}

/// Database of countries with their ISO2 codes, dial codes, and names.
///
/// Access via:
/// - `countryData['US']` - Get specific country
/// - `getAllCountries()` - Get all countries as list
/// - `searchCountries(query)` - Search by name or code
const Map<String, CountryInfo> countryData = {
  'US': CountryInfo(iso2Code: 'US', dialCode: '1', name: 'United States'),
  'GB': CountryInfo(iso2Code: 'GB', dialCode: '44', name: 'United Kingdom'),
  'CA': CountryInfo(iso2Code: 'CA', dialCode: '1', name: 'Canada'),
  'AU': CountryInfo(iso2Code: 'AU', dialCode: '61', name: 'Australia'),
  'DE': CountryInfo(iso2Code: 'DE', dialCode: '49', name: 'Germany'),
  'FR': CountryInfo(iso2Code: 'FR', dialCode: '33', name: 'France'),
  'IT': CountryInfo(iso2Code: 'IT', dialCode: '39', name: 'Italy'),
  'ES': CountryInfo(iso2Code: 'ES', dialCode: '34', name: 'Spain'),
  'NL': CountryInfo(iso2Code: 'NL', dialCode: '31', name: 'Netherlands'),
  'SE': CountryInfo(iso2Code: 'SE', dialCode: '46', name: 'Sweden'),
  'NO': CountryInfo(iso2Code: 'NO', dialCode: '47', name: 'Norway'),
  'DK': CountryInfo(iso2Code: 'DK', dialCode: '45', name: 'Denmark'),
  'FI': CountryInfo(iso2Code: 'FI', dialCode: '358', name: 'Finland'),
  'PL': CountryInfo(iso2Code: 'PL', dialCode: '48', name: 'Poland'),
  'RU': CountryInfo(iso2Code: 'RU', dialCode: '7', name: 'Russia'),
  'UA': CountryInfo(iso2Code: 'UA', dialCode: '380', name: 'Ukraine'),
  'TR': CountryInfo(iso2Code: 'TR', dialCode: '90', name: 'Turkey'),
  'SA': CountryInfo(iso2Code: 'SA', dialCode: '966', name: 'Saudi Arabia'),
  'AE': CountryInfo(
    iso2Code: 'AE',
    dialCode: '971',
    name: 'United Arab Emirates',
  ),
  'EG': CountryInfo(iso2Code: 'EG', dialCode: '20', name: 'Egypt'),
  'ZA': CountryInfo(iso2Code: 'ZA', dialCode: '27', name: 'South Africa'),
  'NG': CountryInfo(iso2Code: 'NG', dialCode: '234', name: 'Nigeria'),
  'KE': CountryInfo(iso2Code: 'KE', dialCode: '254', name: 'Kenya'),
  'GH': CountryInfo(iso2Code: 'GH', dialCode: '233', name: 'Ghana'),
  'ET': CountryInfo(iso2Code: 'ET', dialCode: '251', name: 'Ethiopia'),
  'IN': CountryInfo(iso2Code: 'IN', dialCode: '91', name: 'India'),
  'PK': CountryInfo(iso2Code: 'PK', dialCode: '92', name: 'Pakistan'),
  'BD': CountryInfo(iso2Code: 'BD', dialCode: '880', name: 'Bangladesh'),
  'CN': CountryInfo(iso2Code: 'CN', dialCode: '86', name: 'China'),
  'JP': CountryInfo(iso2Code: 'JP', dialCode: '81', name: 'Japan'),
  'KR': CountryInfo(iso2Code: 'KR', dialCode: '82', name: 'South Korea'),
  'TH': CountryInfo(iso2Code: 'TH', dialCode: '66', name: 'Thailand'),
  'VN': CountryInfo(iso2Code: 'VN', dialCode: '84', name: 'Vietnam'),
  'PH': CountryInfo(iso2Code: 'PH', dialCode: '63', name: 'Philippines'),
  'ID': CountryInfo(iso2Code: 'ID', dialCode: '62', name: 'Indonesia'),
  'MY': CountryInfo(iso2Code: 'MY', dialCode: '60', name: 'Malaysia'),
  'SG': CountryInfo(iso2Code: 'SG', dialCode: '65', name: 'Singapore'),
  'NZ': CountryInfo(iso2Code: 'NZ', dialCode: '64', name: 'New Zealand'),
  'MX': CountryInfo(iso2Code: 'MX', dialCode: '52', name: 'Mexico'),
  'BR': CountryInfo(iso2Code: 'BR', dialCode: '55', name: 'Brazil'),
  'AR': CountryInfo(iso2Code: 'AR', dialCode: '54', name: 'Argentina'),
  'CL': CountryInfo(iso2Code: 'CL', dialCode: '56', name: 'Chile'),
  'CO': CountryInfo(iso2Code: 'CO', dialCode: '57', name: 'Colombia'),
  'PE': CountryInfo(iso2Code: 'PE', dialCode: '51', name: 'Peru'),
  'VE': CountryInfo(iso2Code: 'VE', dialCode: '58', name: 'Venezuela'),
  'IL': CountryInfo(iso2Code: 'IL', dialCode: '972', name: 'Israel'),
  'IQ': CountryInfo(iso2Code: 'IQ', dialCode: '964', name: 'Iraq'),
  'IR': CountryInfo(iso2Code: 'IR', dialCode: '98', name: 'Iran'),
  'JO': CountryInfo(iso2Code: 'JO', dialCode: '962', name: 'Jordan'),
  'KW': CountryInfo(iso2Code: 'KW', dialCode: '965', name: 'Kuwait'),
  'LB': CountryInfo(iso2Code: 'LB', dialCode: '961', name: 'Lebanon'),
  'OM': CountryInfo(iso2Code: 'OM', dialCode: '968', name: 'Oman'),
  'QA': CountryInfo(iso2Code: 'QA', dialCode: '974', name: 'Qatar'),
  'BH': CountryInfo(iso2Code: 'BH', dialCode: '973', name: 'Bahrain'),
  'AT': CountryInfo(iso2Code: 'AT', dialCode: '43', name: 'Austria'),
  'BE': CountryInfo(iso2Code: 'BE', dialCode: '32', name: 'Belgium'),
  'BG': CountryInfo(iso2Code: 'BG', dialCode: '359', name: 'Bulgaria'),
  'HR': CountryInfo(iso2Code: 'HR', dialCode: '385', name: 'Croatia'),
  'CY': CountryInfo(iso2Code: 'CY', dialCode: '357', name: 'Cyprus'),
  'CZ': CountryInfo(iso2Code: 'CZ', dialCode: '420', name: 'Czech Republic'),
  'EE': CountryInfo(iso2Code: 'EE', dialCode: '372', name: 'Estonia'),
  'GR': CountryInfo(iso2Code: 'GR', dialCode: '30', name: 'Greece'),
  'HU': CountryInfo(iso2Code: 'HU', dialCode: '36', name: 'Hungary'),
  'IE': CountryInfo(iso2Code: 'IE', dialCode: '353', name: 'Ireland'),
  'LV': CountryInfo(iso2Code: 'LV', dialCode: '371', name: 'Latvia'),
  'LT': CountryInfo(iso2Code: 'LT', dialCode: '370', name: 'Lithuania'),
  'LU': CountryInfo(iso2Code: 'LU', dialCode: '352', name: 'Luxembourg'),
  'MT': CountryInfo(iso2Code: 'MT', dialCode: '356', name: 'Malta'),
  'PT': CountryInfo(iso2Code: 'PT', dialCode: '351', name: 'Portugal'),
  'RO': CountryInfo(iso2Code: 'RO', dialCode: '40', name: 'Romania'),
  'SK': CountryInfo(iso2Code: 'SK', dialCode: '421', name: 'Slovakia'),
  'SI': CountryInfo(iso2Code: 'SI', dialCode: '386', name: 'Slovenia'),
  'CH': CountryInfo(iso2Code: 'CH', dialCode: '41', name: 'Switzerland'),
  'IS': CountryInfo(iso2Code: 'IS', dialCode: '354', name: 'Iceland'),
  'LI': CountryInfo(iso2Code: 'LI', dialCode: '423', name: 'Liechtenstein'),
  'MC': CountryInfo(iso2Code: 'MC', dialCode: '377', name: 'Monaco'),
  'SM': CountryInfo(iso2Code: 'SM', dialCode: '378', name: 'San Marino'),
  'VA': CountryInfo(iso2Code: 'VA', dialCode: '379', name: 'Vatican City'),
  'AD': CountryInfo(iso2Code: 'AD', dialCode: '376', name: 'Andorra'),
  'AL': CountryInfo(iso2Code: 'AL', dialCode: '355', name: 'Albania'),
  'BA': CountryInfo(
    iso2Code: 'BA',
    dialCode: '387',
    name: 'Bosnia and Herzegovina',
  ),
  'MK': CountryInfo(iso2Code: 'MK', dialCode: '389', name: 'North Macedonia'),
  'ME': CountryInfo(iso2Code: 'ME', dialCode: '382', name: 'Montenegro'),
  'RS': CountryInfo(iso2Code: 'RS', dialCode: '381', name: 'Serbia'),
  'BY': CountryInfo(iso2Code: 'BY', dialCode: '375', name: 'Belarus'),
  'MD': CountryInfo(iso2Code: 'MD', dialCode: '373', name: 'Moldova'),
  'AM': CountryInfo(iso2Code: 'AM', dialCode: '374', name: 'Armenia'),
  'AZ': CountryInfo(iso2Code: 'AZ', dialCode: '994', name: 'Azerbaijan'),
  'GE': CountryInfo(iso2Code: 'GE', dialCode: '995', name: 'Georgia'),
  'KZ': CountryInfo(iso2Code: 'KZ', dialCode: '7', name: 'Kazakhstan'),
  'UZ': CountryInfo(iso2Code: 'UZ', dialCode: '998', name: 'Uzbekistan'),
  'TM': CountryInfo(iso2Code: 'TM', dialCode: '993', name: 'Turkmenistan'),
  'TJ': CountryInfo(iso2Code: 'TJ', dialCode: '992', name: 'Tajikistan'),
  'KG': CountryInfo(iso2Code: 'KG', dialCode: '996', name: 'Kyrgyzstan'),
  'AF': CountryInfo(iso2Code: 'AF', dialCode: '93', name: 'Afghanistan'),
  'NP': CountryInfo(iso2Code: 'NP', dialCode: '977', name: 'Nepal'),
  'LK': CountryInfo(iso2Code: 'LK', dialCode: '94', name: 'Sri Lanka'),
  'MM': CountryInfo(iso2Code: 'MM', dialCode: '95', name: 'Myanmar'),
  'KH': CountryInfo(iso2Code: 'KH', dialCode: '855', name: 'Cambodia'),
  'LA': CountryInfo(iso2Code: 'LA', dialCode: '856', name: 'Laos'),
  'MN': CountryInfo(iso2Code: 'MN', dialCode: '976', name: 'Mongolia'),
  'HK': CountryInfo(iso2Code: 'HK', dialCode: '852', name: 'Hong Kong'),
  'MO': CountryInfo(iso2Code: 'MO', dialCode: '853', name: 'Macau'),
  'TW': CountryInfo(iso2Code: 'TW', dialCode: '886', name: 'Taiwan'),
  'BN': CountryInfo(iso2Code: 'BN', dialCode: '673', name: 'Brunei'),
  'TL': CountryInfo(iso2Code: 'TL', dialCode: '670', name: 'Timor-Leste'),
  'FJ': CountryInfo(iso2Code: 'FJ', dialCode: '679', name: 'Fiji'),
  'PG': CountryInfo(iso2Code: 'PG', dialCode: '675', name: 'Papua New Guinea'),
};

/// Returns all countries as a sorted list (alphabetically by name).
List<CountryInfo> getAllCountries() {
  final countries = countryData.values.toList();
  countries.sort((a, b) => a.name.compareTo(b.name));
  return countries;
}

/// Searches for countries by name or ISO2 code.
///
/// The search is case-insensitive and matches partial strings.
///
/// Example:
/// ```dart
/// searchCountries('united') // Returns US, GB, AE
/// searchCountries('de')      // Returns DE (Germany)
/// ```
List<CountryInfo> searchCountries(String query) {
  if (query.isEmpty) return getAllCountries();

  final lowerQuery = query.toLowerCase();
  return countryData.values.where((country) {
    return country.name.toLowerCase().contains(lowerQuery) ||
        country.iso2Code.toLowerCase().contains(lowerQuery) ||
        country.displayName.toLowerCase().contains(lowerQuery);
  }).toList()..sort((a, b) => a.name.compareTo(b.name));
}

/// Extension to convert old tuple format to new format.
///
/// This helps with migration from the old CountryCode type.
extension CountryCodeTuple on (String, String?) {
  /// Returns the ISO2 country code from the tuple.
  String get iso2 => $1;

  /// Returns the phone number from the tuple.
  String? get phoneNumber => $2;

  /// Gets the CountryInfo for this tuple's country code.
  CountryInfo? get countryInfo => countryData[$1];
}
