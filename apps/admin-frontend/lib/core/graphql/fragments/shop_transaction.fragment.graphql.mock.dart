import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockShopTransaction1 = Fragment$shopTransaction(
  id: '1',
  createdAt: DateTime.now().subtract(const Duration(days: 3)),
  transactionDate: DateTime.now().subtract(const Duration(minutes: 40)),
  type: Enum$TransactionType.Debit,
  currency: 'USD',
  amount: 300,
  debitType: Enum$ShopTransactionDebitType.Payout,
  status: Enum$TransactionStatus.Processing,
);

final mockShopTransaction2 = Fragment$shopTransaction(
  id: '2',
  createdAt: DateTime.now().subtract(const Duration(days: 6)),
  transactionDate: DateTime.now().subtract(const Duration(minutes: 40)),
  type: Enum$TransactionType.Credit,
  currency: 'USD',
  amount: 200,
  creditType: Enum$ShopTransactionCreditType.SaleRevenue,
  status: Enum$TransactionStatus.Done,
);

final mockShopTransactions = [mockShopTransaction1, mockShopTransaction2];

final mockShopTransactionPayout1 = Fragment$shopTransactionPayout(
  id: "1",
  status: Enum$TransactionStatus.Done,
  amount: 52.41,
  currency: "USD",
  type: Enum$TransactionType.Debit,
  shop: mockShopBasicInfo1,
);

final mockShopTransactionPayout2 = Fragment$shopTransactionPayout(
  id: "2",
  status: Enum$TransactionStatus.Processing,
  amount: 431.1,
  currency: "USD",
  type: Enum$TransactionType.Debit,
  shop: mockShopBasicInfo2,
);

final mockShopTransactionPayouts = [
  mockShopTransactionPayout1,
  mockShopTransactionPayout2,
];
