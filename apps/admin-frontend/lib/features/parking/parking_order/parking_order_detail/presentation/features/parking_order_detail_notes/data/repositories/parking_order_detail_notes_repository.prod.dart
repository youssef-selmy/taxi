import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/data/graphql/parking_order_detail_notes.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/data/repositories/parking_order_detail_notes_repository.dart';

@prod
@LazySingleton(as: ParkingOrderDetailNotesRepository)
class ParkingOrderDetailNotesRepositoryImpl
    implements ParkingOrderDetailNotesRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingOrderDetailNotesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$getParkingOrderNotes>> getParkingOrderDetailNotes({
    required String parkingOrderId,
  }) async {
    final getParkingOrderDetailNotes = await graphQLDatasource.query(
      Options$Query$getParkingOrderNotes(
        variables: Variables$Query$getParkingOrderNotes(
          parkingId: parkingOrderId,
        ),
      ),
    );
    return getParkingOrderDetailNotes;
  }

  @override
  Future<ApiResponse<void>> createParkingOrderNote({
    required String parkingOrderId,
    required String note,
  }) async {
    final createNoteOrError = await graphQLDatasource.mutate(
      Options$Mutation$createParkingOrderNote(
        variables: Variables$Mutation$createParkingOrderNote(
          parkOrderId: parkingOrderId,
          note: note,
        ),
      ),
    );
    return createNoteOrError;
  }
}
