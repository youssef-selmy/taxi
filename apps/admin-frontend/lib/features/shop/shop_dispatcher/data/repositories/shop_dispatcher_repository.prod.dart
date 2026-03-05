import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/graphql/create_order.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/graphql/select_items.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/data/repositories/shop_dispatcher_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopDispatcherRepository)
class ShopDispatcherRepositoryImpl implements ShopDispatcherRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDispatcherRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopCategories>> getShopCategories({
    required String customerId,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$shopCategories(
        variables: Variables$Query$shopCategories(customerId: customerId),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Query$shops>> getShops({
    required String addressId,
    required String categoryId,
    required int startIndex,
    required int count,
    required String? query,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$shops(
        variables: Variables$Query$shops(
          addressId: addressId,
          categoryId: categoryId,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<List<Query$items$shop$productCategories>>> getItems({
    required String shopId,
    required String? query,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // final minuteOfTheDay = DateTime.now().hour * 60 + DateTime.now().minute;
    final result = await graphQLDatasource.query(
      Options$Query$items(variables: Variables$Query$items(shopId: shopId)),
    );
    return result.mapData((r) => r.shop.productCategories);
  }

  @override
  Future<ApiResponse<Query$retrieveCheckoutOptions>> retrieveCheckoutOptions({
    required String customerId,
    required Input$CalculateDeliveryFeeInput calculateFareInput,
  }) async {
    final checkoutOptions = await graphQLDatasource.query(
      Options$Query$retrieveCheckoutOptions(
        variables: Variables$Query$retrieveCheckoutOptions(
          customerId: customerId,
          input: calculateFareInput,
        ),
      ),
    );
    return checkoutOptions;
  }

  @override
  Future<ApiResponse<Mutation$createShopOrder>> createOrder({
    required Input$ShopOrderInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createShopOrder(
        variables: Variables$Mutation$createShopOrder(input: input),
      ),
    );
    return result;
  }
}
