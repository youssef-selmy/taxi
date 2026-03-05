import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/data/graphql/shop_order_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/data/repositories/shop_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopOrderListRepository)
class ShopOrderListRepositoryImpl implements ShopOrderListRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopOrderListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$OffsetPaging? paging,
    required Input$ShopOrderFilter filter,
    required List<Input$ShopOrderSort> sorting,
  }) async {
    final getShopOrderList = await graphQLDatasource.query(
      Options$Query$shopOrders(
        variables: Variables$Query$shopOrders(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getShopOrderList;
  }

  @override
  Future<ApiResponse<Query$getShopOrdersOverview>> getShopOrderStatistics() {
    final lastWeekStartDate = DateTime.now().subtract(const Duration(days: 7));
    final lastWeekEndDate = DateTime.now();
    final thisWeekStartDate = DateTime.now();
    final thisWeekEndDate = DateTime.now().add(const Duration(days: 7));
    final overviewOrError = graphQLDatasource.query(
      Options$Query$getShopOrdersOverview(
        variables: Variables$Query$getShopOrdersOverview(
          lastWeekStartDate: lastWeekStartDate,
          lastWeekEndDate: lastWeekEndDate,
          thisWeekStartDate: thisWeekStartDate,
          thisWeekEndDate: thisWeekEndDate,
        ),
      ),
    );
    return overviewOrError;
  }

  @override
  Future<ApiResponse<Query$shopCategories>> getShopCategories() async {
    final getShopCategories = await graphQLDatasource.query(
      Options$Query$shopCategories(),
    );
    return getShopCategories;
  }
}
