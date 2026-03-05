import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/data/graphql/shop_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/data/repositories/shop_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopAccountingDetailRepository)
class DriverAccountingDetailRepositoryImpl
    implements ShopAccountingDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverAccountingDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopTransactions>> getShopTransactions({
    required String currency,
    required List<Enum$TransactionType> typeFilter,
    required List<Enum$TransactionStatus> statusFilter,
    required String shopId,
    required List<Input$ShopTransactionSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final driverTransactionsOrError = await graphQLDatasource.query(
      Options$Query$shopTransactions(
        variables: Variables$Query$shopTransactions(
          filter: Input$ShopTransactionFilter(
            currency: Input$StringFieldComparison(eq: currency),
            shopId: Input$IDFilterComparison(eq: shopId),
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
  Future<ApiResponse<Query$shopWalletDetailSummary>> getWalletDetailSummary({
    required String shopId,
  }) async {
    final walletDetailSummaryOrError = await graphQLDatasource.query(
      Options$Query$shopWalletDetailSummary(
        variables: Variables$Query$shopWalletDetailSummary(shopId: shopId),
      ),
    );
    return walletDetailSummaryOrError;
  }
}
