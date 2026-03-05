import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopDetailPresetsRepository {
  Future<ApiResponse<Query$shopPresets>> getShopPresets({
    required Input$ShopItemPresetFilter filter,
    required List<Input$ShopItemPresetSort> sorting,
    required Input$OffsetPaging? paging,
  });

  Future<ApiResponse<Fragment$shopItemPresetDetail>> getShopItemPreset({
    required String id,
  });

  Future<ApiResponse<void>> deleteShopItemPreset({required String id});

  Future<ApiResponse<void>> createShopItemPreset({
    required Input$CreateShopItemPresetInput input,
  });

  Future<ApiResponse<void>> updateShopItemPreset({
    required String id,
    required Input$UpdateShopItemPresetInput input,
  });
}
