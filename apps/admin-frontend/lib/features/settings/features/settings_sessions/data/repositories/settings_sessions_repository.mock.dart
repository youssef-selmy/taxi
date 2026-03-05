import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/settings/features/settings_sessions/data/graphql/settings_sessions.graphql.dart';
import 'package:admin_frontend/features/settings/features/settings_sessions/data/repositories/settings_sessions_repository.dart';

@dev
@LazySingleton(as: SettingsSessionsRepository)
class SettingsSessionsRepositoryMock implements SettingsSessionsRepository {
  @override
  Future<ApiResponse<Query$currentUserSessions>> getSessions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$currentUserSessions(
        currentUserSessions: [
          Query$currentUserSessions$currentUserSessions(
            id: "1",
            sessionInfo: mockSessionInfo1,
          ),
          Query$currentUserSessions$currentUserSessions(
            id: "2",
            sessionInfo: mockSessionInfo2,
          ),
          Query$currentUserSessions$currentUserSessions(
            id: "3",
            sessionInfo: mockSessionInfo3,
          ),
        ],
      ),
    );
  }

  @override
  Future<ApiResponse<void>> terminateSession({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
