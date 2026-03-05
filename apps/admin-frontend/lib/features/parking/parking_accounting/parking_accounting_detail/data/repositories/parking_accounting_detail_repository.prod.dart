import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/data/graphql/parking_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/data/repositories/parking_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingAccountingDetailRepository)
class DriverAccountingDetailRepositoryImpl
    implements ParkingAccountingDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverAccountingDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkingTransactions>> getParkingTransactions({
    required String currency,
    required List<Enum$TransactionType> typeFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String parkingId,
    required List<Input$ParkingTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final driverTransactionsOrError = await graphQLDatasource.query(
      Options$Query$parkingTransactions(
        variables: Variables$Query$parkingTransactions(
          filter: Input$ParkingTransactionFilter(
            currency: Input$StringFieldComparison(eq: currency),
            customerId: Input$IDFilterComparison(eq: parkingId),
            status: statusFilter.isNotEmpty
                ? Input$TransactionStatusFilterComparison($in: statusFilter)
                : null,
            type: typeFilter.isNotEmpty
                ? Input$TransactionTypeFilterComparison($in: typeFilter)
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
  Future<ApiResponse<Query$parkingWalletDetailSummary>> getWalletDetailSummary({
    required String parkingId,
  }) async {
    final walletDetailSummaryOrError = await graphQLDatasource.query(
      Options$Query$parkingWalletDetailSummary(
        variables: Variables$Query$parkingWalletDetailSummary(
          parkingId: parkingId,
        ),
      ),
    );
    return walletDetailSummaryOrError;
  }
}
