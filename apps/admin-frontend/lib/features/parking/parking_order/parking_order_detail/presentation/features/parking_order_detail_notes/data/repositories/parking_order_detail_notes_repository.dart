import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/data/graphql/parking_order_detail_notes.graphql.dart';

abstract class ParkingOrderDetailNotesRepository {
  Future<ApiResponse<Query$getParkingOrderNotes>> getParkingOrderDetailNotes({
    required String parkingOrderId,
  });

  Future<ApiResponse<void>> createParkingOrderNote({
    required String parkingOrderId,
    required String note,
  });
}
