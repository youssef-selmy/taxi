import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkSpotDetailCreditRecordsRepository)
class ParkSpotDetailCreditRecordsRepositoryImpl
    implements ParkSpotDetailCreditRecordsRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotDetailCreditRecordsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkSpotCreditRecords>> getCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$ParkingTransactionFilter filter,
    required List<Input$ParkingTransactionSort> sorting,
  }) async {
    final transactionsOrError = await graphQLDatasource.query(
      Options$Query$parkSpotCreditRecords(
        variables: Variables$Query$parkSpotCreditRecords(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return transactionsOrError;
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getWalletBalance({
    required String ownerId,
  }) async {
    final walletsOrError = await graphQLDatasource.query(
      Options$Query$parkingWallets(
        variables: Variables$Query$parkingWallets(ownerId: ownerId),
      ),
    );
    return walletsOrError.mapData(
      (r) =>
          r.parkingWallets.nodes.map((e) => e.toWalletBalanceItem()).toList(),
    );
  }

  @override
  Future<ApiResponse<String>> exportCreditRecords({
    required List<Input$ParkingTransactionSort> sort,
    required Input$ParkingTransactionFilter filter,
    required Enum$ExportFormat format,
  }) async {
    final exportResult = await graphQLDatasource.query(
      Options$Query$exportParkingTransactions(
        variables: Variables$Query$exportParkingTransactions(
          sorting: sort,
          filter: filter,
          format: format,
        ),
      ),
    );
    return exportResult.mapData((data) => data.exportParkingTransactions);
  }
}
