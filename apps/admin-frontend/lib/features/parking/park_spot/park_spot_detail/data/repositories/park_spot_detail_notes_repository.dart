import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_note.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_notes.graphql.dart';

abstract class ParkSpotDetailNotesRepository {
  Future<ApiResponse<Query$parkSpotNotes>> getNotes({
    required String parkSpotId,
  });

  Future<ApiResponse<Fragment$parkingNote>> createNote({
    required String parkSpotId,
    required String note,
  });
}
