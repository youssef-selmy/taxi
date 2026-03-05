import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_credit_records.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkSpotDetailCreditRecordsRepository {
  Future<ApiResponse<Query$parkSpotCreditRecords>> getCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$ParkingTransactionFilter filter,
    required List<Input$ParkingTransactionSort> sorting,
  });

  Future<ApiResponse<List<WalletBalanceItem>>> getWalletBalance({
    required String ownerId,
  });

  Future<ApiResponse<String>> exportCreditRecords({
    required List<Input$ParkingTransactionSort> sort,
    required Input$ParkingTransactionFilter filter,
    required Enum$ExportFormat format,
  });
}
