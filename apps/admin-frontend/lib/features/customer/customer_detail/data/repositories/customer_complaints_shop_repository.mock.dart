import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_complaints_shop_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomerComplaintsShopRepository)
class CustomerComplaintsShopRepositoryMock
    implements CustomerComplaintsShopRepository {
  @override
  Future<ApiResponse<Query$customerComplaintsShop>> getCustomerComplaintsShop({
    required Input$OffsetPaging? paging,
    required Input$ShopSupportRequestFilter filter,
    required List<Input$ShopSupportRequestSort> sorting,
  }) async {
    return ApiResponse.loaded(
      Query$customerComplaintsShop(
        shopSupportRequests: Query$customerComplaintsShop$shopSupportRequests(
          nodes: mockShopSupportRequests,
          pageInfo: mockPageInfo,
          totalCount: mockShopSupportRequests.length,
        ),
      ),
    );
  }
}
