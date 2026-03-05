import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_note.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_notes.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_notes_repository.dart';

@dev
@LazySingleton(as: ParkSpotDetailNotesRepository)
class ParkSpotDetailNotesRepositoryMock
    implements ParkSpotDetailNotesRepository {
  @override
  Future<ApiResponse<Fragment$parkingNote>> createNote({
    required String parkSpotId,
    required String note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkingNote1);
  }

  @override
  Future<ApiResponse<Query$parkSpotNotes>> getNotes({
    required String parkSpotId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkSpotNotes(parkSpotNotes: mockParkingNotes),
    );
  }
}
