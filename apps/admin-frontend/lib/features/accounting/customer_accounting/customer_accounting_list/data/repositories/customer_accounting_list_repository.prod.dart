import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/data/graphql/customer_accounting_list.graphql.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/data/repositories/customer_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomerAccountingListRepository)
class CustomerAccountingListRepositoryImpl
    implements CustomerAccountingListRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomerAccountingListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerWallets>> getWalletList({
    required String currency,
    required List<Input$RiderWalletSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final walletListOrError = await graphQLDatasource.query(
      Options$Query$customerWallets(
        variables: Variables$Query$customerWallets(
          currency: currency,
          sorting: sorting,
          paging: paging,
        ),
      ),
    );
    return walletListOrError;
  }

  @override
  Future<ApiResponse<Query$customerWalletsSummary>> getWalletsSummary({
    required String currency,
  }) async {
    final walletSummaryOrError = await graphQLDatasource.query(
      Options$Query$customerWalletsSummary(
        variables: Variables$Query$customerWalletsSummary(currency: currency),
      ),
    );
    return walletSummaryOrError;
  }
}
