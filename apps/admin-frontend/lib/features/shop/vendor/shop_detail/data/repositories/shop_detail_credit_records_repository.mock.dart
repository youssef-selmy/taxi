import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopDetailCreditRecordsRepository)
class ShopDetailCreditRecordsRepositoryMock
    implements ShopDetailCreditRecordsRepository {
  @override
  Future<ApiResponse<Query$shopCreditRecords>> getCreditRecords({
    required Input$OffsetPaging? paging,
    required Input$ShopTransactionFilter filter,
    required List<Input$ShopTransactionSort> sorting,
  }) async {
    return ApiResponse.loaded(
      Query$shopCreditRecords(
        shopTransactions: Query$shopCreditRecords$shopTransactions(
          nodes: mockShopTransactions,
          pageInfo: mockPageInfo,
          totalCount: mockShopTransactions.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<WalletBalanceItem>>> getWalletBalance({
    required String ownerId,
  }) async {
    return ApiResponse.loaded(
      mockShopWallets.map((r) => r.toWalletBalanceItem()).toList(),
    );
  }

  @override
  Future<ApiResponse<String>> export({
    required Input$ShopTransactionFilter filter,
    required List<Input$ShopTransactionSort> sorting,
    required Enum$ExportFormat format,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.loaded(
      "https://example.com/exported_credit_records.${format.name.toLowerCase()}",
    );
  }
}
