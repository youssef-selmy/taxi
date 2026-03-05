import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/data/graphql/shop_order_detail_complaints.graphql.dart';

abstract class ShopOrderDetailComplaintsRepository {
  Future<ApiResponse<Query$getShopOrderComplaints>>
  getShopOrderDetailComplaints({required String orderId});
}
