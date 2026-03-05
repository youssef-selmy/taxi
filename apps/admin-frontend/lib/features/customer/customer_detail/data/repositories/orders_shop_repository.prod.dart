import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/orders_shop_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: OrdersShopRepository)
class OrdersShopRepositoryImpl implements OrdersShopRepository {
  final GraphqlDatasource graphQLDatasource;

  OrdersShopRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerOrdersShop>> getAll({
    required String customerId,
    required List<Enum$ShopOrderStatus> statuses,
    required List<Enum$PaymentMode> paymentModes,
    required Input$OffsetPaging? paging,
    required List<Input$ShopOrderSort> sorting,
  }) async {
    final orders = await graphQLDatasource.query(
      Options$Query$customerOrdersShop(
        variables: Variables$Query$customerOrdersShop(
          sorting: sorting,
          paging: paging,
          filter: Input$ShopOrderFilter(
            customerId: Input$IDFilterComparison(eq: customerId),
            status: statuses.isEmpty
                ? null
                : Input$ShopOrderStatusFilterComparison($in: statuses),
            paymentMethod: paymentModes.isEmpty
                ? null
                : Input$PaymentModeFilterComparison($in: paymentModes),
          ),
        ),
      ),
    );
    return orders;
  }

  @override
  Future<ApiResponse<String>> export({
    required List<Input$ShopOrderSort> sort,
    required Input$ShopOrderFilter filter,
    required Enum$ExportFormat format,
  }) async {
    final exportOrError = await graphQLDatasource.query(
      Options$Query$exportShopOrders(
        variables: Variables$Query$exportShopOrders(
          sorting: sort,
          filter: filter,
          format: format,
        ),
      ),
    );
    return exportOrError.mapData((data) => data.exportShopOrders);
  }
}
