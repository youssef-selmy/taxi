import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_feedbacks.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_feedbacks_repository.dart';

@dev
@LazySingleton(as: ShopDetailFeedbacksRepository)
class ShopDetailFeedbacksRepositoryMock
    implements ShopDetailFeedbacksRepository {
  @override
  Future<ApiResponse<Query$shopFeedbacks>> getFeedbacks({
    required String shopId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopFeedbacks(
        shopFeedbacks: Query$shopFeedbacks$shopFeedbacks(
          nodes: mockShopReviewsList,
          pageInfo: mockPageInfo,
          totalCount: mockShopReviewsList.length,
        ),
      ),
    );
  }
}
