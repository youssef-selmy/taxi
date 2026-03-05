import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/data/graphql/shop_review_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopReviewListRepository {
  Future<ApiResponse<Query$shopFeedbacks>> getShopReviewsList({
    required Input$OffsetPaging? paging,
    required Input$ShopFeedbackFilter filter,
    required List<Input$ShopFeedbackSort> sorting,
  });

  Future<ApiResponse<Fragment$shopFeedback>> updateShopFeedbackStatus({
    required String id,
    required Enum$ReviewStatus status,
  });
}
