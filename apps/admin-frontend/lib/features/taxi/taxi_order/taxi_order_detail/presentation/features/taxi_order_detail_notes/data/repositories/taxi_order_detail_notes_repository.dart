import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/data/graphql/taxi_order_detail_notes.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class TaxiOrderDetailNotesRepository {
  Future<ApiResponse<Query$taxiOrderNotes>> getTaxiOrderNotes({
    required String orderId,
  });

  Future<ApiResponse<Fragment$taxiOrderNote>> createTaxiOrderNote({
    required Input$CreateTaxiOrderNoteInput input,
  });
}
