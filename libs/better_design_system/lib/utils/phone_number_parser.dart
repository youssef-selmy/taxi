import 'package:dlibphonenumber/dlibphonenumber.dart';

/// Result of parsing an autofilled phone number
class ParsedPhoneNumber {
  final String iso2Code;
  final String nationalNumber;

  const ParsedPhoneNumber({
    required this.iso2Code,
    required this.nationalNumber,
  });
}

/// Attempts to parse an autofilled phone number that may contain a country code.
/// Returns null if no country code was detected or parsing failed.
ParsedPhoneNumber? parseAutofillPhoneNumber(String digits) {
  if (digits.length < 10) return null;

  final phoneUtil = PhoneNumberUtil.instance;

  try {
    // Try parsing with "+" prefix (international format)
    final number = phoneUtil.parse('+$digits', null);
    final regionCode = phoneUtil.getRegionCodeForNumber(number);
    final nationalNumber = number.nationalNumber.toString();

    if (regionCode != null && nationalNumber.isNotEmpty) {
      return ParsedPhoneNumber(
        iso2Code: regionCode,
        nationalNumber: nationalNumber,
      );
    }
  } catch (_) {
    // Not a valid international number
  }

  return null;
}

/// Detects if a text change is likely from autofill rather than manual typing.
/// Autofill typically inserts 10+ digits at once.
bool isLikelyAutofill(String? previousValue, String newValue) {
  final prevLength = previousValue?.length ?? 0;
  final newLength = newValue.length;

  // Autofill detection: large increase AND result is phone-number-length
  return (newLength - prevLength) >= 6 && newLength >= 10;
}
