import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/data/graphql/shop_payout_session_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopPayoutSessionListRepository {
  Future<ApiResponse<Query$shopsPendingPayoutSessions>>
  getShopsPendingPayoutSessions();

  Future<ApiResponse<Query$shopsPayoutSessions>> getShopsPayoutSessions({
    required Input$OffsetPaging? paging,
    required List<Input$ShopPayoutSessionSort> sorting,
    required Input$ShopPayoutSessionFilter filter,
  });

  Future<ApiResponse<Query$shopsPayoutTransactions>>
  getShopsPayoutTransactions({
    required Input$OffsetPaging? paging,
    required List<Input$ShopTransactionSort> sorting,
    required Input$ShopTransactionFilter filter,
  });
}
