import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/data/graphql/shop_review_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/data/repositories/shop_review_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopReviewListRepository)
class ShopReviewListRepositoryMock implements ShopReviewListRepository {
  @override
  Future<ApiResponse<Query$shopFeedbacks>> getShopReviewsList({
    required Input$OffsetPaging? paging,
    required Input$ShopFeedbackFilter filter,
    required List<Input$ShopFeedbackSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopFeedbacks(
        shopFeedbacks: Query$shopFeedbacks$shopFeedbacks(
          pageInfo: mockPageInfo,
          totalCount: mockShopReviewsList.length,
          nodes: mockShopReviewsList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$shopFeedback>> updateShopFeedbackStatus({
    required String id,
    required Enum$ReviewStatus status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopFeedback1);
  }
}
