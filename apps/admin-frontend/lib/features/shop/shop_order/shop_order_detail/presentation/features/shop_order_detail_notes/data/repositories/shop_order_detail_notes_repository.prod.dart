import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order_note.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_notes/data/graphql/shop_order_detail_notes.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_notes/data/repositories/shop_order_detail_notes_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopOrderDetailNotesRepository)
class ShopOrderDetailNotesRepositoryImpl
    implements ShopOrderDetailNotesRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopOrderDetailNotesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$shopOrderNote>>> getShopOrderNotes({
    required String id,
  }) async {
    final getShopOrderNotes = await graphQLDatasource.query(
      Options$Query$getShopOrderNotes(
        variables: Variables$Query$getShopOrderNotes(
          orderId: Input$IDFilterComparison(eq: id),
        ),
      ),
    );
    return getShopOrderNotes.mapData((f) => f.shopOrderNotes);
  }

  @override
  Future<ApiResponse<Fragment$shopOrderNote>> createShopOrderNote({
    required String note,
    required String orderId,
  }) async {
    final shopOrderNote = await graphQLDatasource.mutate(
      Options$Mutation$createShopOrderNote(
        variables: Variables$Mutation$createShopOrderNote(
          input: Input$CreateShopOrderNoteInput(note: note, orderId: orderId),
        ),
      ),
    );
    return shopOrderNote.mapData((f) => f.createOneShopOrderNote);
  }
}
