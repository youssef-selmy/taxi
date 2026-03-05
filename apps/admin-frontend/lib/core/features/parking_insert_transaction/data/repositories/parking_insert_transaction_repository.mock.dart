import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/features/parking_insert_transaction/data/repositories/parking_insert_transaction_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingInsertTransactionRepository)
class ParkingInsertTransactionRepositoryMock
    implements ParkingInsertTransactionRepository {
  @override
  Future<ApiResponse<Fragment$parkingTransaction>> insertTransaction({
    required String parkingId,
    required Enum$TransactionType type,
    Enum$ParkingTransactionCreditType? creditType,
    Enum$ParkingTransactionDebitType? debitType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkingTransaction1);
  }
}
