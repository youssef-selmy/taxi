import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.mock.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/data/graphql/vendor_list.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/data/repositories/vendor_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: VendorListRepository)
class VendorListRepositoryMock implements VendorListRepository {
  @override
  Future<ApiResponse<Query$vendors>> getVendors({
    required Input$OffsetPaging? paging,
    required Input$ShopFilter filter,
    required List<Input$ShopSort> sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$vendors(
        shops: Query$vendors$shops(
          nodes: mockShopListItems,
          pageInfo: mockPageInfo,
          totalCount: mockShopListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$vendorCategories>> getVendorCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$vendorCategories(
        shopCategories: Query$vendorCategories$shopCategories(
          nodes: mockShopCategories,
        ),
      ),
    );
  }
}
