import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_list/data/graphql/shop_support_request.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopSupportRequestRepository {
  Future<ApiResponse<Query$shopSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$ShopSupportRequestFilter filter,
    required List<Input$ShopSupportRequestSort> sorting,
  });
}
