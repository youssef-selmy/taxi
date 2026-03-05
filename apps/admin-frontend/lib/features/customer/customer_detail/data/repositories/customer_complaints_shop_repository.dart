import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_shop.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomerComplaintsShopRepository {
  Future<ApiResponse<Query$customerComplaintsShop>> getCustomerComplaintsShop({
    required Input$OffsetPaging? paging,
    required Input$ShopSupportRequestFilter filter,
    required List<Input$ShopSupportRequestSort> sorting,
  });
}
