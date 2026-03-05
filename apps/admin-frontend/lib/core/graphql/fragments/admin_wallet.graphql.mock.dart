import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockAdminTransaction1 = Fragment$adminTransactionListItem(
  amount: 112.32,
  currency: "USD",

  createdAt: DateTime.now().subtract(const Duration(days: 20)),
  id: "1",
  action: Enum$TransactionAction.Deduct,
  deductType: Enum$ProviderDeductTransactionType.Withdraw,
);

final mockAdminTransaction2 = Fragment$adminTransactionListItem(
  amount: 32.321,
  currency: "EUR",
  createdAt: DateTime.now().subtract(const Duration(days: 10)),
  id: "2",
  action: Enum$TransactionAction.Recharge,
  rechargeType: Enum$ProviderRechargeTransactionType.Commission,
);

final mockAdminTransaction3 = Fragment$adminTransactionListItem(
  amount: 10,
  currency: "GBP",
  createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
  id: "3",
  action: Enum$TransactionAction.Recharge,
  rechargeType: Enum$ProviderRechargeTransactionType.Commission,
);

final mockAdminTransaction4 = Fragment$adminTransactionListItem(
  amount: 15.53123,
  currency: "AUD",
  createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  id: "4",
  action: Enum$TransactionAction.Recharge,
  rechargeType: Enum$ProviderRechargeTransactionType.Commission,
);

final mockAdminTransaction5 = Fragment$adminTransactionListItem(
  amount: 12.32,
  currency: "CAD",
  createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
  id: "5",
  action: Enum$TransactionAction.Recharge,
  rechargeType: Enum$ProviderRechargeTransactionType.Commission,
);

final mockAdminTransactions = [
  mockAdminTransaction1,
  mockAdminTransaction2,
  mockAdminTransaction3,
  mockAdminTransaction4,
  mockAdminTransaction5,
];
