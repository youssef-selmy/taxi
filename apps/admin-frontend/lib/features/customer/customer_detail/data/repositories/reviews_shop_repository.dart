import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_shop.graphql.dart';

abstract class ReviewsShopRepository {
  Future<ApiResponse<Query$customerShopReviews>> getCustomerShopReviews(
    String customerId,
  );
}
