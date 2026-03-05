import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/data/graphql/driver_accounting_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/data/repositories/driver_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverAccountingListRepository)
class DriverAccountingListRepositoryImpl
    implements DriverAccountingListRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverAccountingListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverWallets>> getWalletList({
    required String? currency,
    required List<Input$DriverWalletSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final walletListOrError = await graphQLDatasource.query(
      Options$Query$driverWallets(
        variables: Variables$Query$driverWallets(
          currency: currency,
          sorting: sorting,
          paging: paging,
        ),
      ),
    );
    return walletListOrError;
  }

  @override
  Future<ApiResponse<Query$driverWalletsSummary>> getWalletsSummary({
    required String? currency,
  }) async {
    final walletSummaryOrError = await graphQLDatasource.query(
      Options$Query$driverWalletsSummary(
        variables: Variables$Query$driverWalletsSummary(currency: currency),
      ),
    );
    return walletSummaryOrError;
  }
}
