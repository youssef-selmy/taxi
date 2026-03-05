import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_detail/data/graphql/shop_support_request_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_detail/data/repositories/shop_support_request_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopSupportRequestDetailRepository)
class ShopSupportRequestDetailRepositoryMock
    implements ShopSupportRequestDetailRepository {
  @override
  Future<ApiResponse<Query$shopSupportRequest>> getSupportRequest({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopSupportRequest(
        shopSupportRequest: mockShopSupportRequestDetail,
        staffs: Query$shopSupportRequest$staffs(nodes: mockStaffList),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$shopSupportRequestActivity>> addComment({
    required Input$CreateShopSupportRequestCommentInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopSupportRequestActivity1);
  }

  @override
  Future<ApiResponse<Fragment$shopSupportRequestActivity>> assignToStaffs({
    required Input$AssignShopSupportRequestInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopSupportRequestActivity1);
  }

  @override
  Future<ApiResponse<Fragment$shopSupportRequestActivity>> updateStatus({
    required Input$ChangeShopSupportRequestStatusInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopSupportRequestActivity1);
  }
}
