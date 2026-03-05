import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/data/graphql/shop_order_detail_reviews.graphql.dart';

abstract class ShopOrderDetailReviewsRepository {
  Future<ApiResponse<Query$shopOrderReviews>> getFeedBacks({
    required String orderId,
  });
}
