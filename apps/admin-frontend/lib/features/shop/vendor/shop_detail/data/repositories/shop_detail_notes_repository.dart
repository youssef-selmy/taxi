import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_note.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_notes.graphql.dart';

abstract class ShopDetailNotesRepository {
  Future<ApiResponse<Query$shopNotes>> getNotes({required String shopId});

  Future<ApiResponse<Fragment$shopNote>> createNote({
    required String shopId,
    required String note,
  });
}
