import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockDriverTransaction1 = Fragment$driverTransaction(
  id: '1',
  action: Enum$TransactionAction.Recharge,
  amount: 200,
  currency: 'EUR',
  rechargeType: Enum$DriverRechargeTransactionType.InAppPayment,
  refrenceNumber: '1211516163',
  status: Enum$TransactionStatus.Done,
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  paymentGateway: mockPaymentGatewayCompact1,
  savedPaymentMethod: mockSavedPaymentMethodVisa,
);

final mockDriverTransaction2 = Fragment$driverTransaction(
  id: '2',
  action: Enum$TransactionAction.Deduct,
  amount: 100,
  currency: 'USD',
  deductType: Enum$DriverDeductTransactionType.Commission,
  refrenceNumber: '3432453123',
  status: Enum$TransactionStatus.Done,
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  savedPaymentMethod: mockSavedPaymentMethodVisa,
  paymentGateway: mockPaymentGatewayCompact2,
);

final mockDriverTransactionList = [
  mockDriverTransaction1,
  mockDriverTransaction2,
];

final mockDriverTransactionPayout1 = Fragment$driverTransactionPayout(
  id: "1",
  status: Enum$TransactionStatus.Processing,
  amount: 53.21,
  currency: "USD",
  action: Enum$TransactionAction.Deduct,
  driver: mockDriverName4,
);

final mockDriverTransactionPayout2 = Fragment$driverTransactionPayout(
  id: "2",
  status: Enum$TransactionStatus.Processing,
  amount: 15.42,
  currency: "USD",
  action: Enum$TransactionAction.Deduct,
  driver: mockDriverName2,
);

final mockDriverTransactionPayouts = [
  mockDriverTransactionPayout1,
  mockDriverTransactionPayout2,
];
