import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/features/driver_insert_transaction/data/repositories/driver_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverInsertTransactionRepository)
class DriverInsertTransactionRepositoryMock
    implements DriverInsertTransactionRepository {
  @override
  Future<ApiResponse<Fragment$driverTransaction>> insertTransaction({
    required String driverId,
    required Enum$TransactionAction action,
    Enum$DriverRechargeTransactionType? rechargeType,
    Enum$DriverDeductTransactionType? deductType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockDriverTransaction1);
  }
}
