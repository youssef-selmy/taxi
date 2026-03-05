import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/data/graphql/shop_accounting_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/data/repositories/shop_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopAccountingListRepository)
class ShopAccountingListRepositoryMock implements ShopAccountingListRepository {
  @override
  Future<ApiResponse<Query$shopWallets>> getWalletList({
    required String? currency,
    required List<Input$ShopWalletSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopWallets(
        shopWallets: Query$shopWallets$shopWallets(
          nodes: [
            Query$shopWallets$shopWallets$nodes(
              currency: currency ?? "USD",
              balance: 43,
              shop: mockShopBasicInfo1,
            ),
            Query$shopWallets$shopWallets$nodes(
              currency: currency ?? "USD",
              balance: 12,
              shop: mockShopBasicInfo1,
            ),
            Query$shopWallets$shopWallets$nodes(
              currency: currency ?? "USD",
              balance: 53,
              shop: mockShopBasicInfo1,
            ),
            Query$shopWallets$shopWallets$nodes(
              currency: currency ?? "USD",
              balance: 65,
              shop: mockShopBasicInfo1,
            ),
          ],
          pageInfo: mockPageInfo,
          totalCount: 4,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$shopWalletsSummary>> getWalletsSummary({
    required String? currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopWalletsSummary(
        walletsCount: [
          Query$shopWalletsSummary$walletsCount(
            count: Query$shopWalletsSummary$walletsCount$count(id: 54),
          ),
        ],
        totalWalletBalance: [
          Query$shopWalletsSummary$totalWalletBalance(
            sum: Query$shopWalletsSummary$totalWalletBalance$sum(balance: 5123),
          ),
        ],
      ),
    );
  }
}
