import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order_note.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_notes/data/repositories/shop_order_detail_notes_repository.dart';

@dev
@LazySingleton(as: ShopOrderDetailNotesRepository)
class ShopOrderDetailNotesRepositoryMock
    implements ShopOrderDetailNotesRepository {
  @override
  Future<ApiResponse<List<Fragment$shopOrderNote>>> getShopOrderNotes({
    required String id,
  }) async {
    return ApiResponse.loaded(mockShopOrderListNotes);
  }

  @override
  Future<ApiResponse<Fragment$shopOrderNote>> createShopOrderNote({
    required String note,
    required String orderId,
  }) async {
    return ApiResponse.loaded(mockShopOrderNote1);
  }
}
