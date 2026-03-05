import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/data/graphql/shop_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/data/repositories/shop_order_detail_reviews_repository.dart';

@dev
@LazySingleton(as: ShopOrderDetailReviewsRepository)
class ShopOrderDetailReviewsRepositoryMock
    implements ShopOrderDetailReviewsRepository {
  @override
  Future<ApiResponse<Query$shopOrderReviews>> getFeedBacks({
    required String orderId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopOrderReviews(
        shopOrder: Query$shopOrderReviews$shopOrder(
          carts: [
            Query$shopOrderReviews$shopOrder$carts(
              shop: mockFragmentShopBasic1,
              feedbacks: [mockShopFeedback1, mockReviewShop4],
            ),
            Query$shopOrderReviews$shopOrder$carts(
              shop: mockFragmentShopBasic2,
              feedbacks: [mockReviewShop2, mockReviewShop3],
            ),
          ],
        ),
      ),
    );
  }
}
