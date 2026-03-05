import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/vendor/vendor_list/data/graphql/vendor_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class VendorListRepository {
  Future<ApiResponse<Query$vendorCategories>> getVendorCategories();
  Future<ApiResponse<Query$vendors>> getVendors({
    required Input$OffsetPaging? paging,
    required Input$ShopFilter filter,
    required List<Input$ShopSort> sort,
  });
}
