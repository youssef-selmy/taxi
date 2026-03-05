import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_dispatcher/data/graphql/create_order.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/graphql/select_items.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopDispatcherRepository {
  Future<ApiResponse<Query$shopCategories>> getShopCategories({
    required String customerId,
  });

  Future<ApiResponse<Query$shops>> getShops({
    required String addressId,
    required String categoryId,
    required int startIndex,
    required int count,
    required String? query,
  });

  Future<ApiResponse<List<Query$items$shop$productCategories>>> getItems({
    required String shopId,
    required String? query,
  });

  Future<ApiResponse<Query$retrieveCheckoutOptions>> retrieveCheckoutOptions({
    required String customerId,
    required Input$CalculateDeliveryFeeInput calculateFareInput,
  });

  Future<ApiResponse<Mutation$createShopOrder>> createOrder({
    required Input$ShopOrderInput input,
  });
}
