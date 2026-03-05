import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockProviderTransaction1 = Fragment$providerTransaction(
  id: '1',
  action: Enum$TransactionAction.Recharge,
  amount: 100,
  currency: 'USD',
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
);
final mockProviderTransaction2 = Fragment$providerTransaction(
  id: '2',
  action: Enum$TransactionAction.Deduct,
  amount: 200,
  currency: 'USD',
  createdAt: DateTime.now().subtract(const Duration(hours: 9)),
);

final List<Fragment$providerTransaction> mockProviderTransactionList = [
  mockProviderTransaction1,
  mockProviderTransaction2,
];
