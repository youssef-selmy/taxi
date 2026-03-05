import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/data/graphql/driver_detail_notes.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/data/repositories/driver_detail_notes_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverDetailNotesRepository)
class DriverDetailNotesRepositoryImpl implements DriverDetailNotesRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailNotesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverDetailNotes>> getDriverNotes({
    required String driverId,
  }) async {
    var getDriverNotesOrError = graphQLDatasource.query(
      Options$Query$driverDetailNotes(
        variables: Variables$Query$driverDetailNotes(id: driverId),
      ),
    );
    return getDriverNotesOrError;
  }

  @override
  Future<ApiResponse<Mutation$createDriverNote>> createDriverNote({
    required Input$CreateOneDriverNoteInput input,
  }) async {
    var createDriverNoteOrError = graphQLDatasource.mutate(
      Options$Mutation$createDriverNote(
        variables: Variables$Mutation$createDriverNote(input: input),
      ),
    );
    return createDriverNoteOrError;
  }
}
