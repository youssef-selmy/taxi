import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/data/graphql/shop_order_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/data/repositories/shop_order_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopOrderDetailRepository)
class ShopOrderDetailRepositoryImpl implements ShopOrderDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopOrderDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$orderShopDetail>> getShopOrderDetail({
    required String id,
  }) async {
    final shopOrderDetailOrError = await graphQLDatasource.query(
      Options$Query$shopOrderDetail(
        variables: Variables$Query$shopOrderDetail(id: id),
      ),
    );
    return shopOrderDetailOrError.mapData((f) => f.shopOrder);
  }

  @override
  Future<ApiResponse<Fragment$orderShopDetail>> shopOrderDetailCancelOrder({
    required Input$CancelShopOrderCartsInput input,
  }) async {
    final shopOrderDetailOrError = await graphQLDatasource.mutate(
      Options$Mutation$cancelShopOrderCarts(
        variables: Variables$Mutation$cancelShopOrderCarts(input: input),
      ),
    );
    return shopOrderDetailOrError.mapData((f) => f.cancelShopOrderCarts);
  }

  @override
  Future<ApiResponse<Fragment$orderShopDetail>> shopOrderDetailRemoveItem({
    required Input$RemoveItemFromCartInput input,
  }) async {
    final shopOrderDetailOrError = await graphQLDatasource.mutate(
      Options$Mutation$removeItemsFromCart(
        variables: Variables$Mutation$removeItemsFromCart(input: input),
      ),
    );
    return shopOrderDetailOrError.mapData((f) => f.removeItemFromCart);
  }
}
