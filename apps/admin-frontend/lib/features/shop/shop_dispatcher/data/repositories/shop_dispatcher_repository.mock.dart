import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/graphql/create_order.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/graphql/select_items.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/repositories/shop_dispatcher_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopDispatcherRepository)
class ShopDispatcherRepositoryMock implements ShopDispatcherRepository {
  @override
  Future<ApiResponse<Query$shopCategories>> getShopCategories({
    required String customerId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.loaded(
      Query$shopCategories(
        shopCategories: Query$shopCategories$shopCategories(
          nodes: mockShopCategories,
        ),
        // shopCategories: [
        //   Query$shopCategories$shopCategories(
        //     id: "1",
        //     name: "Grocery",
        //     image: mockMediaShopCategory1,
        //   ),
        //   Query$shopCategories$shopCategories(
        //     id: "2",
        //     name: "Pet Shop",
        //     image: mockMediaShopCategory2,
        //   ),

        //   Query$shopCategories$shopCategories(
        //     id: "3",
        //     name: "Restaurant",
        //     image: mockMediaShopCategory3,
        //   ),
        // ],
        rider: Query$shopCategories$rider(wallet: mockCustomerWallets),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$shops>> getShops({
    required String addressId,
    required String categoryId,
    required int startIndex,
    required int count,
    required String? query,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.loaded(
      Query$shops(
        dispatcherShops: List.generate(4, (i) => mockFragmentShop).toList(),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Query$items$shop$productCategories>>> getItems({
    required String shopId,
    required String? query,
  }) async {
    final List<String> categories = [
      "Fruits",
      "Vegetables",
      "Meat",
      "Dairy",
      "Beverages",
    ];
    return ApiResponse.loaded(
      List.generate(
        5,
        (i) => Query$items$shop$productCategories(
          id: i.toString(),
          name: categories[i],
          products: Query$items$shop$productCategories$products(totalCount: 10),
          subItems: Query$items$shop$productCategories$subItems(
            nodes: List.generate(20, (x) => mockShopItemListItem1),
          ),
        ),
      ).toList(),
    );
  }

  @override
  Future<ApiResponse<Query$retrieveCheckoutOptions>> retrieveCheckoutOptions({
    required String customerId,
    required Input$CalculateDeliveryFeeInput calculateFareInput,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.loaded(
      Query$retrieveCheckoutOptions(
        savedPaymentMethods: Query$retrieveCheckoutOptions$savedPaymentMethods(
          nodes: mockPaymentMethods,
        ),
        calculateDeliveryFee:
            Query$retrieveCheckoutOptions$calculateDeliveryFee(
              batchDeliveryFee: 20,
              splitDeliveryFee: 54,
              batchDeliveryDuration: 95,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$createShopOrder>> createOrder({
    required Input$ShopOrderInput input,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.loaded(
      Mutation$createShopOrder(
        createShopOrder: Mutation$createShopOrder$createShopOrder(id: "1"),
      ),
    );
  }
}
