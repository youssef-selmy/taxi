import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverInsertTransactionRepository {
  Future<ApiResponse<Fragment$driverTransaction>> insertTransaction({
    required String driverId,
    required Enum$TransactionAction action,
    Enum$DriverRechargeTransactionType? rechargeType,
    Enum$DriverDeductTransactionType? deductType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  });
}
