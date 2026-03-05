import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/settings/features/settings_sessions/data/graphql/settings_sessions.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_sessions/data/repositories/settings_sessions_repository.dart';

@prod
@LazySingleton(as: SettingsSessionsRepository)
class SettingsSessionsRepositoryImpl implements SettingsSessionsRepository {
  final GraphqlDatasource graphQLDatasource;

  SettingsSessionsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$currentUserSessions>> getSessions() async {
    final sessionsOrError = await graphQLDatasource.query(
      Options$Query$currentUserSessions(),
    );
    return sessionsOrError;
  }

  @override
  Future<ApiResponse<void>> terminateSession({required String id}) async {
    return ApiResponse.loaded(null);
  }
}
