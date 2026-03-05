import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockSavedPaymentMethodVisa = Fragment$SavedPaymentMethod(
  id: "1",
  title: "VISA",
  type: Enum$SavedPaymentMethodType.CARD,
  providerBrand: Enum$ProviderBrand.Visa,
  lastFour: "1234",
  expiryDate: DateTime.now().add(const Duration(days: 365)),
);

final mockSavedPaymentMethodMasterCard = Fragment$SavedPaymentMethod(
  id: "2",
  title: "MasterCard",
  type: Enum$SavedPaymentMethodType.CARD,
  providerBrand: Enum$ProviderBrand.Mastercard,
  lastFour: "5678",
  expiryDate: DateTime.now().add(const Duration(days: 365)),
);

final mockPaymentMethods = [
  mockSavedPaymentMethodVisa,
  mockSavedPaymentMethodMasterCard,
];
