import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopDetailRepository)
class ShopDetailRepositoryMock implements ShopDetailRepository {
  @override
  Future<ApiResponse<Fragment$shopDetail>> getShopDetail({
    required String shopId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopDetail);
  }

  @override
  Future<ApiResponse<Fragment$shopDetail>> updateShop({
    required String shopId,
    required Input$UpsertShopInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopDetail);
  }
}
