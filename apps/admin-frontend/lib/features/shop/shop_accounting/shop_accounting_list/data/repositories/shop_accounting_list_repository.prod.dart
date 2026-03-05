import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/data/graphql/shop_accounting_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/data/repositories/shop_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopAccountingListRepository)
class ShopAccountingListRepositoryImpl implements ShopAccountingListRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopAccountingListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopWallets>> getWalletList({
    required String? currency,
    required List<Input$ShopWalletSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final walletListOrError = await graphQLDatasource.query(
      Options$Query$shopWallets(
        variables: Variables$Query$shopWallets(
          currency: currency,
          sorting: sorting,
          paging: paging,
        ),
      ),
    );
    return walletListOrError;
  }

  @override
  Future<ApiResponse<Query$shopWalletsSummary>> getWalletsSummary({
    required String? currency,
  }) async {
    final walletSummaryOrError = await graphQLDatasource.query(
      Options$Query$shopWalletsSummary(
        variables: Variables$Query$shopWalletsSummary(currency: currency),
      ),
    );
    return walletSummaryOrError;
  }
}
