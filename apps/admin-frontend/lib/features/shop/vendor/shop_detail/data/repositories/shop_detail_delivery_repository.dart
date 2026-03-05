import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_delivery_region.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_delivery.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopDetailDeliveryRepository {
  Future<ApiResponse<Query$shopDeliveryZones>> getShopDeliveryRegions({
    required Input$ShopDeliveryZoneFilter filter,
    required List<Input$ShopDeliveryZoneSort> sorting,
    required Input$OffsetPaging? paging,
  });

  Future<ApiResponse<Fragment$shopDeliveryRegion>> getShopDeliveryRegion({
    required String regionId,
  });

  Future<ApiResponse<void>> createShopDeliveryRegion({
    required Input$CreateShopDeliveryZoneInput input,
  });

  Future<ApiResponse<void>> updateShopDeliveryRegion({
    required String regionId,
    required Input$UpdateShopDeliveryZoneInput input,
  });

  Future<ApiResponse<void>> deleteShopDeliveryRegion({
    required String regionId,
  });
}
