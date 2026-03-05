import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/data/graphql/taxi_order_detail_notes.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/data/repositories/taxi_order_detail_notes_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: TaxiOrderDetailNotesRepository)
class TaxiOrderDetailNotesRepositoryMock
    implements TaxiOrderDetailNotesRepository {
  @override
  Future<ApiResponse<Query$taxiOrderNotes>> getTaxiOrderNotes({
    required String orderId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$taxiOrderNotes(
        taxiOrderNotes: Query$taxiOrderNotes$taxiOrderNotes(
          nodes: mockListNote,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$taxiOrderNote>> createTaxiOrderNote({
    required Input$CreateTaxiOrderNoteInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockNote1);
  }
}
