import 'package:api_response/api_response.dart';

abstract class DriverDetailPasswordRepository {
  Future<ApiResponse<void>> updatePassword({
    required String driverId,
    required String password,
  });
}
