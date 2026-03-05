import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/orders_shop_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: OrdersShopRepository)
class OrdersShopRepositoryMock implements OrdersShopRepository {
  @override
  Future<ApiResponse<Query$customerOrdersShop>> getAll({
    required String customerId,
    required List<Enum$ShopOrderStatus> statuses,
    required List<Enum$PaymentMode> paymentModes,
    required Input$OffsetPaging? paging,
    required List<Input$ShopOrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$customerOrdersShop(
        shopOrders: Query$customerOrdersShop$shopOrders(
          nodes: mockShopOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockShopOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<String>> export({
    required List<Input$ShopOrderSort> sort,
    required Input$ShopOrderFilter filter,
    required Enum$ExportFormat format,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      "mocked_csv_data"
      ".${format.name.toLowerCase()}",
    );
  }
}
