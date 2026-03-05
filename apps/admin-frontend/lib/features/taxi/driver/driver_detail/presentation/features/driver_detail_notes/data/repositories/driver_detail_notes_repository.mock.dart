import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_note.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/data/graphql/driver_detail_notes.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/data/repositories/driver_detail_notes_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverDetailNotesRepository)
class DriverDetailNotesRepositoryMock implements DriverDetailNotesRepository {
  @override
  Future<ApiResponse<Query$driverDetailNotes>> getDriverNotes({
    required String driverId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverDetailNotes(
        driverNotes: Query$driverDetailNotes$driverNotes(
          nodes: mockDriverNotesList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$createDriverNote>> createDriverNote({
    required Input$CreateOneDriverNoteInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$createDriverNote(createOneDriverNote: mockDriverNote1),
    );
  }
}
