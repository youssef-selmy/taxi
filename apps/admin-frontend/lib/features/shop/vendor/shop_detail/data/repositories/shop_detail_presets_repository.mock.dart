import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_presets_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopDetailPresetsRepository)
class ShopDetailPresetsRepositoryMock implements ShopDetailPresetsRepository {
  @override
  Future<ApiResponse<Query$shopPresets>> getShopPresets({
    required Input$ShopItemPresetFilter filter,
    required List<Input$ShopItemPresetSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopPresets(
        shopItemPresets: Query$shopPresets$shopItemPresets(
          nodes: mockShopItemPresets,
          pageInfo: mockPageInfo,
          totalCount: mockShopItemPresets.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$shopItemPresetDetail>> getShopItemPreset({
    required String id,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopItemPresetDetail);
  }

  @override
  Future<ApiResponse<void>> deleteShopItemPreset({required String id}) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<void>> createShopItemPreset({
    required Input$CreateShopItemPresetInput input,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<void>> updateShopItemPreset({
    required String id,
    required Input$UpdateShopItemPresetInput input,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
