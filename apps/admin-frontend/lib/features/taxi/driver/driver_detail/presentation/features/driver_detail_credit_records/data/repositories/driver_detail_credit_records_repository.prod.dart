import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/data/graphql/driver_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/data/repositories/driver_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverDetailCreditRecordsRepository)
class DriverDetailCreditRecordsRepositoryImpl
    implements DriverDetailCreditRecordsRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailCreditRecordsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverCreditRecords>> getDriverCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$DriverTransactionFilter filter,
    required List<Input$DriverTransactionSort> sorting,
  }) async {
    var getDriverCreditRecordsOrError = graphQLDatasource.query(
      Options$Query$driverCreditRecords(
        variables: Variables$Query$driverCreditRecords(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );

    return getDriverCreditRecordsOrError;
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getDriverWallets({
    required String driverId,
  }) async {
    final getDriverWalletsOrError = await graphQLDatasource.query(
      Options$Query$driverWallets(
        variables: Variables$Query$driverWallets(id: driverId),
      ),
    );
    return getDriverWalletsOrError.mapData(
      (wallet) => wallet.driverWallets.nodes.toWalletBalanceItems(),
    );
  }

  @override
  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsOverTimeStatistics({
    required Input$ChartFilterInput filter,
  }) async {
    // TODO: implement getEarningsOverTimeStatistics
    return ApiResponse.loaded([]);
  }

  @override
  Future<ApiResponse<String>> exportDriverCreditRecords({
    required Input$DriverTransactionFilter filter,
    required List<Input$DriverTransactionSort> sort,
    required Enum$ExportFormat format,
  }) async {
    final exportOrError = await graphQLDatasource.query(
      Options$Query$exportDriverTransactions(
        variables: Variables$Query$exportDriverTransactions(
          filter: filter,
          sorting: sort,
          format: format,
        ),
      ),
    );
    return exportOrError.mapData((data) => data.exportDriverTransactions);
  }
}
