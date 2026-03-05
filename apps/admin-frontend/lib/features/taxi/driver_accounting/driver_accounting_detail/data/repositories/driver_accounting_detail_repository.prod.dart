import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/data/graphql/driver_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/data/repositories/driver_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverAccountingDetailRepository)
class DriverAccountingDetailRepositoryImpl
    implements DriverAccountingDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverAccountingDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverTransactions>> getDriverTransactions({
    required String currency,
    required List<Enum$TransactionAction> actionFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String driverId,
    required List<Input$DriverTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final driverTransactionsOrError = await graphQLDatasource.query(
      Options$Query$driverTransactions(
        variables: Variables$Query$driverTransactions(
          filter: Input$DriverTransactionFilter(
            currency: Input$StringFieldComparison(eq: currency),
            driverId: Input$IDFilterComparison(eq: driverId),
            status: statusFilter.isNotEmpty
                ? Input$TransactionStatusFilterComparison($in: statusFilter)
                : null,
            action: actionFilter.isNotEmpty
                ? Input$TransactionActionFilterComparison($in: actionFilter)
                : null,
          ),
          sorting: sorting,
          paging: paging,
        ),
      ),
    );
    return driverTransactionsOrError;
  }

  @override
  Future<ApiResponse<Query$driverWalletDetailSummary>> getWalletDetailSummary({
    required String driverId,
  }) async {
    final walletDetailSummaryOrError = await graphQLDatasource.query(
      Options$Query$driverWalletDetailSummary(
        variables: Variables$Query$driverWalletDetailSummary(
          driverId: driverId,
        ),
      ),
    );
    return walletDetailSummaryOrError;
  }
}
