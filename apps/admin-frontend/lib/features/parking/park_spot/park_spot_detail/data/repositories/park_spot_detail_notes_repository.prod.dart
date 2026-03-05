import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_note.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_notes.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_notes_repository.dart';

@prod
@LazySingleton(as: ParkSpotDetailNotesRepository)
class ParkSpotDetailNotesRepositoryImpl
    implements ParkSpotDetailNotesRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotDetailNotesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkSpotNotes>> getNotes({
    required String parkSpotId,
  }) async {
    final noteOrError = await graphQLDatasource.query(
      Options$Query$parkSpotNotes(
        variables: Variables$Query$parkSpotNotes(parkSpotId: parkSpotId),
      ),
    );
    return noteOrError;
  }

  @override
  Future<ApiResponse<Fragment$parkingNote>> createNote({
    required String parkSpotId,
    required String note,
  }) async {
    final noteOrError = await graphQLDatasource.mutate(
      Options$Mutation$createParkSpotNote(
        variables: Variables$Mutation$createParkSpotNote(
          parkSpotId: parkSpotId,
          note: note,
        ),
      ),
    );
    return noteOrError.mapData((r) => r.createOneParkSpotNote);
  }
}
