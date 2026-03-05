import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/data/graphql/parking_accounting_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingAccountingListRepository {
  Future<ApiResponse<Query$parkingWalletsSummary>> getWalletsSummary({
    required String? currency,
  });

  Future<ApiResponse<Query$parkingWallets>> getWalletList({
    required String? currency,
    required List<Input$ParkingWalletSort> sorting,
    required Input$OffsetPaging? paging,
  });
}
