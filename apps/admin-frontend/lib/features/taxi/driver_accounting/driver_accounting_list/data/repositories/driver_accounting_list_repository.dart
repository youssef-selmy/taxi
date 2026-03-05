import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/data/graphql/driver_accounting_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverAccountingListRepository {
  Future<ApiResponse<Query$driverWalletsSummary>> getWalletsSummary({
    required String? currency,
  });

  Future<ApiResponse<Query$driverWallets>> getWalletList({
    required String? currency,
    required List<Input$DriverWalletSort> sorting,
    required Input$OffsetPaging? paging,
  });
}
