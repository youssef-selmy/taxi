import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/data/graphql/shop_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/data/repositories/shop_payout_session_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopPayoutSessionListRepository)
class ShopPayoutSessionListRepositoryMock
    implements ShopPayoutSessionListRepository {
  @override
  Future<ApiResponse<Query$shopsPayoutTransactions>>
  getShopsPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$ShopTransactionSort> sorting,
    required Input$ShopTransactionFilter filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopsPayoutTransactions(
        payoutTransactions: Query$shopsPayoutTransactions$payoutTransactions(
          nodes: [
            Query$shopsPayoutTransactions$payoutTransactions$nodes(
              id: "1",
              transactionDate: DateTime.now().subtract(
                const Duration(hours: 10),
              ),
              type: Enum$TransactionType.Credit,
              status: Enum$TransactionStatus.Done,
              amount: 100,
              currency: "USD",
              createdAt: DateTime.now().subtract(const Duration(hours: 10)),
              shop: mockShopBasicInfo1,
            ),
            Query$shopsPayoutTransactions$payoutTransactions$nodes(
              id: "2",
              transactionDate: DateTime.now().subtract(
                const Duration(hours: 10),
              ),
              type: Enum$TransactionType.Credit,
              status: Enum$TransactionStatus.Done,
              amount: 120,
              currency: "USD",
              createdAt: DateTime.now().subtract(const Duration(hours: 3)),
              shop: mockShopBasicInfo1,
            ),
          ],
          totalCount: 2,
          pageInfo: mockPageInfo,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$shopsPayoutSessions>> getShopsPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$ShopPayoutSessionSort> sorting,
    required Input$ShopPayoutSessionFilter filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopsPayoutSessions(
        shopPayoutSessions: Query$shopsPayoutSessions$shopPayoutSessions(
          nodes: mockShopPayoutSessionListItems,
          totalCount: mockShopPayoutSessionListItems.length,
          pageInfo: mockPageInfo,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$shopsPendingPayoutSessions>>
  getShopsPendingPayoutSessions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopsPendingPayoutSessions(
        pendingSessions: Query$shopsPendingPayoutSessions$pendingSessions(
          nodes: mockShopPayoutSessionListItems,
          totalCount: mockShopPayoutSessionListItems.length,
        ),
      ),
    );
  }
}
