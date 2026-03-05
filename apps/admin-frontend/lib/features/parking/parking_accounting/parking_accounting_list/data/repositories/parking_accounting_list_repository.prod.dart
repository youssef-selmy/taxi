import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/data/graphql/parking_accounting_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/data/repositories/parking_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingAccountingListRepository)
class ParkingAccountingListRepositoryImpl
    implements ParkingAccountingListRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingAccountingListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkingWallets>> getWalletList({
    required String? currency,
    required List<Input$ParkingWalletSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final walletListOrError = await graphQLDatasource.query(
      Options$Query$parkingWallets(
        variables: Variables$Query$parkingWallets(
          currency: currency,
          sorting: sorting,
          paging: paging,
        ),
      ),
    );
    return walletListOrError;
  }

  @override
  Future<ApiResponse<Query$parkingWalletsSummary>> getWalletsSummary({
    required String? currency,
  }) async {
    final walletSummaryOrError = await graphQLDatasource.query(
      Options$Query$parkingWalletsSummary(
        variables: Variables$Query$parkingWalletsSummary(currency: currency),
      ),
    );
    return walletSummaryOrError;
  }
}
