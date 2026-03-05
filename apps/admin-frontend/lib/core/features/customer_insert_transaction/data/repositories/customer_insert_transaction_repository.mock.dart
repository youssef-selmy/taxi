import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/features/customer_insert_transaction/data/repositories/customer_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomerInsertTransactionRepository)
class CustomerInsertTransactionRepositoryMock
    implements CustomerInsertTransactionRepository {
  @override
  Future<ApiResponse<Fragment$customerTransaction>> insertTransaction({
    required String customerId,
    required Enum$TransactionAction action,
    Enum$RiderRechargeTransactionType? rechargeType,
    Enum$RiderDeductTransactionType? deductType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockCustomerTransaction1);
  }
}
