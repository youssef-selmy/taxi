import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_shop.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class OrdersShopRepository {
  Future<ApiResponse<Query$customerOrdersShop>> getAll({
    required String customerId,
    required List<Enum$ShopOrderStatus> statuses,
    required List<Enum$PaymentMode> paymentModes,
    required Input$OffsetPaging? paging,
    required List<Input$ShopOrderSort> sorting,
  });

  Future<ApiResponse<String>> export({
    required List<Input$ShopOrderSort> sort,
    required Input$ShopOrderFilter filter,
    required Enum$ExportFormat format,
  });
}
