import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/settings/features/settings_sessions/data/graphql/settings_sessions.graphql.dart';

abstract class SettingsSessionsRepository {
  Future<ApiResponse<Query$currentUserSessions>> getSessions();

  Future<ApiResponse<void>> terminateSession({required String id});
}
