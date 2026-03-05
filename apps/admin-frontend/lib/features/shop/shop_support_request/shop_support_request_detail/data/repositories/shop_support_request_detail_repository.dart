import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_detail/data/graphql/shop_support_request_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopSupportRequestDetailRepository {
  Future<ApiResponse<Query$shopSupportRequest>> getSupportRequest({
    required String id,
  });

  Future<ApiResponse<Fragment$shopSupportRequestActivity>> addComment({
    required Input$CreateShopSupportRequestCommentInput input,
  });

  Future<ApiResponse<Fragment$shopSupportRequestActivity>> assignToStaffs({
    required Input$AssignShopSupportRequestInput input,
  });

  Future<ApiResponse<Fragment$shopSupportRequestActivity>> updateStatus({
    required Input$ChangeShopSupportRequestStatusInput input,
  });
}
