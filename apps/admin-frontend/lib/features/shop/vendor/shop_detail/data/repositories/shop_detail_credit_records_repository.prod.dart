import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopDetailCreditRecordsRepository)
class ShopDetailCreditRecordsRepositoryImpl
    implements ShopDetailCreditRecordsRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailCreditRecordsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopCreditRecords>> getCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$ShopTransactionFilter filter,
    required List<Input$ShopTransactionSort> sorting,
  }) async {
    final transactionsOrError = await graphQLDatasource.query(
      Options$Query$shopCreditRecords(
        variables: Variables$Query$shopCreditRecords(
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
      Options$Query$shopWallets(
        variables: Variables$Query$shopWallets(shopId: ownerId),
      ),
    );
    return walletsOrError.mapData(
      (r) => r.shopWallets.nodes.map((e) => e.toWalletBalanceItem()).toList(),
    );
  }

  @override
  Future<ApiResponse<String>> export({
    required Input$ShopTransactionFilter filter,
    required List<Input$ShopTransactionSort> sorting,
    required Enum$ExportFormat format,
  }) async {
    final exportOrError = await graphQLDatasource.query(
      Options$Query$exportShopTransactions(
        variables: Variables$Query$exportShopTransactions(
          filter: filter,
          sorting: sorting,
          format: format,
        ),
      ),
    );
    return exportOrError.mapData((data) => data.exportShopTransactions);
  }
}
