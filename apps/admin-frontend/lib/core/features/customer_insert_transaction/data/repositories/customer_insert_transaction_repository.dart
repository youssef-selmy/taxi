import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomerInsertTransactionRepository {
  Future<ApiResponse<Fragment$customerTransaction>> insertTransaction({
    required String customerId,
    required Enum$TransactionAction action,
    Enum$RiderRechargeTransactionType? rechargeType,
    Enum$RiderDeductTransactionType? deductType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  });
}
