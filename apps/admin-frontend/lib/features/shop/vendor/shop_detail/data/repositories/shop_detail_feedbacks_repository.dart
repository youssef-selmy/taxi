import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_feedbacks.graphql.dart';

abstract class ShopDetailFeedbacksRepository {
  Future<ApiResponse<Query$shopFeedbacks>> getFeedbacks({
    required String shopId,
  });
}
