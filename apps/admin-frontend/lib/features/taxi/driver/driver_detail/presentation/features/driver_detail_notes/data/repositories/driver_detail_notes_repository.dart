import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/data/graphql/driver_detail_notes.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverDetailNotesRepository {
  Future<ApiResponse<Query$driverDetailNotes>> getDriverNotes({
    required String driverId,
  });

  Future<ApiResponse<Mutation$createDriverNote>> createDriverNote({
    required Input$CreateOneDriverNoteInput input,
  });
}
