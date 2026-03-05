import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order_note.fragment.graphql.dart';

abstract class ShopOrderDetailNotesRepository {
  Future<ApiResponse<List<Fragment$shopOrderNote>>> getShopOrderNotes({
    required String id,
  });

  Future<ApiResponse<Fragment$shopOrderNote>> createShopOrderNote({
    required String note,
    required String orderId,
  });
}
