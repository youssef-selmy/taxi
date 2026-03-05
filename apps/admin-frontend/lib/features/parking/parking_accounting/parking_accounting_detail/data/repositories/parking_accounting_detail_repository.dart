import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/data/graphql/parking_accounting_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingAccountingDetailRepository {
  Future<ApiResponse<Query$parkingWalletDetailSummary>> getWalletDetailSummary({
    required String parkingId,
  });

  Future<ApiResponse<Query$parkingTransactions>> getParkingTransactions({
    required String currency,
    required List<Enum$TransactionType> typeFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String parkingId,
    required List<Input$ParkingTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  });
}
