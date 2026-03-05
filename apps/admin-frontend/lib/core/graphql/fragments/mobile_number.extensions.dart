import 'package:admin_frontend/core/graphql/fragments/mobile_number.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_localization/country_code/country_code.dart';

extension MobileNumberExtensions on (String, String?) {
  /// Parses the mobile number into a format suitable for GraphQL input.
  Input$PhoneNumberInput toInput() {
    final countryCode = this.$1;
    final phoneNumber = this.$2;
    if (phoneNumber == null || phoneNumber.isEmpty) {
      throw ArgumentError('Phone number cannot be null or empty');
    }

    return Input$PhoneNumberInput(
      countryCode: countryCode,
      number: phoneNumber,
    );
  }

  (CountryCode, String?) parse() {
    final countryCode = this.$1;
    final phoneNumber = this.$2;
    if (phoneNumber == null || phoneNumber.isEmpty) {
      throw ArgumentError('Phone number cannot be null or empty');
    }

    final country = CountryCode.parseByIso(countryCode)!;
    return (country, phoneNumber);
  }
}

extension MobileNumberGqlX on Fragment$mobileNumber {
  /// Converts the GraphQL mobile number fragment to a tuple of country code and number.
  (String, String?) toPrimitive() {
    return (countryCode, number);
  }
}
