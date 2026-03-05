import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/data/graphql/driver_detail_credit_records.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverDetailCreditRecordsRepository {
  Future<ApiResponse<Query$driverCreditRecords>> getDriverCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$DriverTransactionFilter filter,
    required List<Input$DriverTransactionSort> sorting,
  });

  Future<ApiResponse<List<WalletBalanceItem>>> getDriverWallets({
    required String driverId,
  });

  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsOverTimeStatistics({required Input$ChartFilterInput filter});

  Future<ApiResponse<String>> exportDriverCreditRecords({
    required Input$DriverTransactionFilter filter,
    required List<Input$DriverTransactionSort> sort,
    required Enum$ExportFormat format,
  });
}
