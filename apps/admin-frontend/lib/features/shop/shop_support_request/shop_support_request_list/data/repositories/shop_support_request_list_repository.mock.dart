import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_list/data/graphql/shop_support_request.graphql.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_list/data/repositories/shop_support_request_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopSupportRequestRepository)
class ShopSupportRequestRepositoryMock implements ShopSupportRequestRepository {
  @override
  Future<ApiResponse<Query$shopSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$ShopSupportRequestFilter filter,
    required List<Input$ShopSupportRequestSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopSupportRequests(
        shopSupportRequests: Query$shopSupportRequests$shopSupportRequests(
          pageInfo: mockPageInfo,
          totalCount: mockShopSupportRequests.length,
          nodes: mockShopSupportRequests,
        ),
      ),
    );
  }
}
