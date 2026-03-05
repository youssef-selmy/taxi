import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_orders.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopDetailOrdersRepository)
class ShopDetailOrdersRepositoryImpl implements ShopDetailOrdersRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailOrdersRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopActiveOrders>> getShopActiveOrders({
    required String shopId,
  }) async {
    final ordersOrError = await graphQLDatasource.query(
      Options$Query$shopActiveOrders(
        variables: Variables$Query$shopActiveOrders(shopId: shopId),
      ),
    );
    return ordersOrError;
  }

  @override
  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$ShopOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ShopOrderSort> sorting,
  }) async {
    final ordersOrError = await graphQLDatasource.query(
      Options$Query$shopOrders(
        variables: Variables$Query$shopOrders(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );
    return ordersOrError;
  }

  @override
  Future<ApiResponse<Fragment$orderShopDetail>> getOrderDetail({
    required String orderId,
  }) async {
    final orderOrError = await graphQLDatasource.query(
      Options$Query$shopOrderDetail(
        variables: Variables$Query$shopOrderDetail(orderId: orderId),
      ),
    );
    return orderOrError.mapData((r) => r.shopOrder);
  }
}
