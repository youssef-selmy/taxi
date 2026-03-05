import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/settings/features/settings_password/data/repositories/settings_password_repository.dart';

@dev
@LazySingleton(as: SettingsPasswordRepository)
class SettingsPasswordRepositoryMock implements SettingsPasswordRepository {
  @override
  Future<ApiResponse<void>> updatePassword({
    required String previousPassword,
    required String newPassword,
  }) async {
    return ApiResponse.loaded(null);
  }
}
