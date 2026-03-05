import 'package:admin_frontend/schema.graphql.dart';

extension PayoutMethodTypeX on Enum$PayoutMethodType {
  bool get isAutomatic => switch (this) {
    Enum$PayoutMethodType.Stripe => true,
    Enum$PayoutMethodType.BankTransfer => false,
    Enum$PayoutMethodType.$unknown => throw Exception(
      'Unknown payout method type',
    ),
  };
}
