import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_delivery_region.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_delivery_region.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_delivery.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_delivery_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopDetailDeliveryRepository)
class ShopDetailDeliveryRepositoryMock implements ShopDetailDeliveryRepository {
  @override
  Future<ApiResponse<void>> createShopDeliveryRegion({
    required Input$CreateShopDeliveryZoneInput input,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<void>> deleteShopDeliveryRegion({
    required String regionId,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Fragment$shopDeliveryRegion>> getShopDeliveryRegion({
    required String regionId,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopDeliveryRegion1);
  }

  @override
  Future<ApiResponse<Query$shopDeliveryZones>> getShopDeliveryRegions({
    required Input$ShopDeliveryZoneFilter filter,
    required List<Input$ShopDeliveryZoneSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopDeliveryZones(
        shopDeliveryRegions: Query$shopDeliveryZones$shopDeliveryRegions(
          nodes: mockShopDeliveryRegions,
          pageInfo: mockPageInfo,
          totalCount: mockShopDeliveryRegions.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<void>> updateShopDeliveryRegion({
    required String regionId,
    required Input$UpdateShopDeliveryZoneInput input,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
