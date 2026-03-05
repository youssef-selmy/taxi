import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_update_password_repository.dart';

@dev
@LazySingleton(as: ParkSpotDetailUpdatePasswordRepository)
class ParkSpotDetailUpdatePasswordRepositoryMock
    implements ParkSpotDetailUpdatePasswordRepository {
  @override
  Future<ApiResponse<void>> updatePassword({
    required String ownerId,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
