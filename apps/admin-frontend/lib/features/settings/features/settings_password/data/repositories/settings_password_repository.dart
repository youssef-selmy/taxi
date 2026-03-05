import 'package:api_response/api_response.dart';

abstract class SettingsPasswordRepository {
  Future<ApiResponse<void>> updatePassword({
    required String previousPassword,
    required String newPassword,
  });
}
