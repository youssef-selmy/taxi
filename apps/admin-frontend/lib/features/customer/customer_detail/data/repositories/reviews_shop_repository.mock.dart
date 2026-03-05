import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/reviews_shop_repository.dart';

@dev
@LazySingleton(as: ReviewsShopRepository)
class ReviewsShopRepositoryMock implements ReviewsShopRepository {
  @override
  Future<ApiResponse<Query$customerShopReviews>> getCustomerShopReviews(
    String customerId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$customerShopReviews(
        shopFeedbacks: Query$customerShopReviews$shopFeedbacks(
          nodes: mockShopReviewsList,
          pageInfo: mockPageInfo,
          totalCount: mockShopReviewsList.length,
        ),
      ),
    );
  }
}
