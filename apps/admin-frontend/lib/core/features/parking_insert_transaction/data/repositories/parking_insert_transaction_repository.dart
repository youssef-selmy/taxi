import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingInsertTransactionRepository {
  Future<ApiResponse<Fragment$parkingTransaction>> insertTransaction({
    required String parkingId,
    required Enum$TransactionType type,
    Enum$ParkingTransactionCreditType? creditType,
    Enum$ParkingTransactionDebitType? debitType,
    required String currency,
    required double amount,
    required String referenceNumber,
    required String description,
  });
}
