import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/data/graphql/shop_order_detail_transactions.graphql.dart';

abstract class ShopOrderDetailTransactionsRepository {
  Future<ApiResponse<Query$getShopOrderTransactions>> getShopOrderTransactions({
    required String orderId,
  });
}
