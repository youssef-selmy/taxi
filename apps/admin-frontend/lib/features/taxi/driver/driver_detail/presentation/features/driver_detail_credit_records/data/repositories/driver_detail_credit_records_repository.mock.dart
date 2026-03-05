import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/data/graphql/driver_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/data/repositories/driver_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverDetailCreditRecordsRepository)
class DriverDetailCreditRecordsRepositoryMock
    implements DriverDetailCreditRecordsRepository {
  @override
  Future<ApiResponse<Query$driverCreditRecords>> getDriverCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$DriverTransactionFilter filter,
    required List<Input$DriverTransactionSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return ApiResponse.loaded(
      Query$driverCreditRecords(
        driverTransactions: Query$driverCreditRecords$driverTransactions(
          totalCount: mockDriverTransactionList.length,
          pageInfo: mockPageInfo,
          nodes: mockDriverTransactionList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getDriverWallets({
    required String driverId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockDriverWallets.toWalletBalanceItems());
  }

  @override
  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsOverTimeStatistics({
    required Input$ChartFilterInput filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded([
      ChartSeriesData(name: 'Jan', value: 80),
      ChartSeriesData(name: 'Feb', value: 150),
      ChartSeriesData(name: 'Mar', value: 230),
    ]);
  }

  @override
  Future<ApiResponse<String>> exportDriverCreditRecords({
    required Input$DriverTransactionFilter filter,
    required List<Input$DriverTransactionSort> sort,
    required Enum$ExportFormat format,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      "https://example.com/exported_driver_credit_records.${format.name.toLowerCase()}",
    );
  }
}
