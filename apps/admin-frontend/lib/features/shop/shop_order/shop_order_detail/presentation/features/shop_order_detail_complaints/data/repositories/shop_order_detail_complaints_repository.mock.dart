import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/data/graphql/shop_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/data/repositories/shop_order_detail_complaints_repository.dart';

@dev
@LazySingleton(as: ShopOrderDetailComplaintsRepository)
class ShopOrderDetailComplaintsRepositoryMock
    implements ShopOrderDetailComplaintsRepository {
  @override
  Future<ApiResponse<Query$getShopOrderComplaints>>
  getShopOrderDetailComplaints({required String orderId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getShopOrderComplaints(
        shopComplaints: Query$getShopOrderComplaints$shopComplaints(
          nodes: mockShopOrderSupportRequests,
        ),
        customerComplaints: Query$getShopOrderComplaints$customerComplaints(
          nodes: mockShopOrderSupportRequests,
        ),
      ),
    );
  }
}
