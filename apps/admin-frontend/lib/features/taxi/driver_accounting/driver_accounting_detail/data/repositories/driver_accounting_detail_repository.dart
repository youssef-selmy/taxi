import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/data/graphql/driver_accounting_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverAccountingDetailRepository {
  Future<ApiResponse<Query$driverWalletDetailSummary>> getWalletDetailSummary({
    required String driverId,
  });

  Future<ApiResponse<Query$driverTransactions>> getDriverTransactions({
    required String currency,
    required List<Enum$TransactionAction> actionFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String driverId,
    required List<Input$DriverTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  });
}
