import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_note.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_notes.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_notes_repository.dart';

@prod
@LazySingleton(as: ShopDetailNotesRepository)
class ShopDetailNotesRepositoryImpl implements ShopDetailNotesRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailNotesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopNotes>> getNotes({
    required String shopId,
  }) async {
    final noteOrError = await graphQLDatasource.query(
      Options$Query$shopNotes(
        variables: Variables$Query$shopNotes(shopId: shopId),
      ),
    );
    return noteOrError;
  }

  @override
  Future<ApiResponse<Fragment$shopNote>> createNote({
    required String shopId,
    required String note,
  }) async {
    final noteOrError = await graphQLDatasource.mutate(
      Options$Mutation$createShopNote(
        variables: Variables$Mutation$createShopNote(
          shopId: shopId,
          note: note,
        ),
      ),
    );
    return noteOrError.mapData((r) => r.createOneShopNote);
  }
}
