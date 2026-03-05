import 'package:api_response/api_response.dart';

abstract class ParkSpotDetailUpdatePasswordRepository {
  Future<ApiResponse<void>> updatePassword({
    required String ownerId,
    required String password,
  });
}
