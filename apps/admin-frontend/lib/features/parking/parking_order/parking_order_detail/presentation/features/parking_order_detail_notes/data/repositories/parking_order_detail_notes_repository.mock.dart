import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_order_note.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/data/graphql/parking_order_detail_notes.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/data/repositories/parking_order_detail_notes_repository.dart';

@dev
@LazySingleton(as: ParkingOrderDetailNotesRepository)
class ParkingOrderDetailNotesRepositoryMock
    implements ParkingOrderDetailNotesRepository {
  @override
  Future<ApiResponse<Query$getParkingOrderNotes>> getParkingOrderDetailNotes({
    required String parkingOrderId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getParkingOrderNotes(
        parkOrder: Query$getParkingOrderNotes$parkOrder(
          notes: mockParkingOrderList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<void>> createParkingOrderNote({
    required String parkingOrderId,
    required String note,
  }) async {
    return ApiResponse.loaded(null);
  }
}
