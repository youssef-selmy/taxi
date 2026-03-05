import 'package:admin_frontend/core/graphql/fragments/payout_account.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockPayoutAccount1 = Fragment$payoutAccount(
  id: "1",
  last4: "5472",
  type: Enum$SavedPaymentMethodType.CARD,
  currency: "USD",
  payoutMethod: mockPayoutMethodCompact1,
);
