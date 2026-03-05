import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_note.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_notes.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_notes_repository.dart';

@dev
@LazySingleton(as: ShopDetailNotesRepository)
class ShopDetailNotesRepositoryMock implements ShopDetailNotesRepository {
  @override
  Future<ApiResponse<Fragment$shopNote>> createNote({
    required String shopId,
    required String note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopNote1);
  }

  @override
  Future<ApiResponse<Query$shopNotes>> getNotes({
    required String shopId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(Query$shopNotes(shopNotes: mockShopNotes));
  }
}
