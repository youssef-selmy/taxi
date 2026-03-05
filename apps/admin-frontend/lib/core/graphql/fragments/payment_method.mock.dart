import 'package:admin_frontend/core/graphql/fragments/payment_method.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockPaymentMethod = Fragment$PaymentMethod$$SavedAccount(
  mode: Enum$PaymentMode.Cash,
  nullableId: '1',
  id: '1',
  isDefault: true,
  providerBrand: Enum$ProviderBrand.Visa,
  name: 'Visa **** 4242',
);
