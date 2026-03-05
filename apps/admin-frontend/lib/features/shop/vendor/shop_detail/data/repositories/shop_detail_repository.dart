import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopDetailRepository {
  Future<ApiResponse<Fragment$shopDetail>> getShopDetail({
    required String shopId,
  });

  Future<ApiResponse<Fragment$shopDetail>> updateShop({
    required String shopId,
    required Input$UpsertShopInput input,
  });
}
