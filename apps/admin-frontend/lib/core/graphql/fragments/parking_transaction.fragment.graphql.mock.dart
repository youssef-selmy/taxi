import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockParkingTransaction1 = Fragment$parkingTransaction(
  id: '1',
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  transactionDate: DateTime.now().subtract(const Duration(days: 1)),
  status: Enum$TransactionStatus.Done,
  currency: 'USD',
  amount: 400,
  type: Enum$TransactionType.Credit,
  creditType: Enum$ParkingTransactionCreditType.ParkingRentalIncome,
  debitType: Enum$ParkingTransactionDebitType.Payout,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockParkingTransaction2 = Fragment$parkingTransaction(
  id: '2',
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
  transactionDate: DateTime.now().subtract(const Duration(days: 2)),
  status: Enum$TransactionStatus.Processing,
  currency: 'USD',
  amount: -200,
  type: Enum$TransactionType.Credit,
  creditType: Enum$ParkingTransactionCreditType.ParkingRentalIncome,
  debitType: Enum$ParkingTransactionDebitType.Payout,
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodMasterCard,
);

final mockParkingTransactions = [
  mockParkingTransaction1,
  mockParkingTransaction2,
];

final mockParkingTransactionPayout1 = Fragment$parkingTransactionPayout(
  id: "1",
  status: Enum$TransactionStatus.Processing,
  amount: 43.11,
  currency: "USD",
  type: Enum$TransactionType.Debit,
  debitType: Enum$ParkingTransactionDebitType.Payout,
  customer: mockCustomerCompact3,
);

final mockParkingTransactionPayout2 = Fragment$parkingTransactionPayout(
  id: "2",
  status: Enum$TransactionStatus.Done,
  amount: 12.34,
  currency: "USD",
  type: Enum$TransactionType.Debit,
  debitType: Enum$ParkingTransactionDebitType.Payout,
  customer: mockCustomerCompact4,
);

final mockParkingTransactionPayouts = [
  mockParkingTransactionPayout1,
  mockParkingTransactionPayout2,
];
