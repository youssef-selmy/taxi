import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockCustomerTransaction1 = Fragment$customerTransaction(
  id: "1",
  action: Enum$TransactionAction.Recharge,
  status: Enum$TransactionStatus.Processing,
  rechargeType: Enum$RiderRechargeTransactionType.InAppPayment,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  amount: 100,
  currency: "USD",
  createdAt: DateTime(2025, 1, 1),
  refrenceNumber: "1234567890",
  paymentGateway: mockPaymentGatewayCompact1,
);

final mockCustomerTransaction2 = Fragment$customerTransaction(
  id: "2",
  action: Enum$TransactionAction.Recharge,
  status: Enum$TransactionStatus.Rejected,
  rechargeType: Enum$RiderRechargeTransactionType.InAppPayment,
  savedPaymentMethod: mockSavedPaymentMethodMasterCard,
  amount: 25,
  currency: "USD",
  createdAt: DateTime(2025, 1, 2),
  refrenceNumber: "1234567890",
);

final mockCustomerTransaction3 = Fragment$customerTransaction(
  id: "3",
  action: Enum$TransactionAction.Deduct,
  deductType: Enum$RiderDeductTransactionType.OrderFee,
  status: Enum$TransactionStatus.Canceled,
  amount: -12.6,
  currency: "USD",
  createdAt: DateTime(2025, 1, 3),
  refrenceNumber: "1234567890",
  paymentGateway: mockPaymentGatewayCompact1,
);

final mockCustomerTransaction4 = Fragment$customerTransaction(
  id: "4",
  action: Enum$TransactionAction.Deduct,
  deductType: Enum$RiderDeductTransactionType.OrderFee,
  status: Enum$TransactionStatus.Done,
  amount: -10.1,
  currency: "USD",
  createdAt: DateTime(2025, 1, 4),
  refrenceNumber: "1234567890",
  paymentGateway: mockPaymentGatewayCompact2,
);

final mockCustomerTransactions = [
  mockCustomerTransaction1,
  mockCustomerTransaction2,
  mockCustomerTransaction3,
  mockCustomerTransaction4,
];
