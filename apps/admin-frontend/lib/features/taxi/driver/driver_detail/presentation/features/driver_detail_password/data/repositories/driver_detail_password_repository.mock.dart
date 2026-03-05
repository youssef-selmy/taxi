import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_password/data/repositories/driver_detail_password_repository.dart';

@dev
@LazySingleton(as: DriverDetailPasswordRepository)
class DriverDetailPasswordRepositoryMock
    implements DriverDetailPasswordRepository {
  @override
  Future<ApiResponse<void>> updatePassword({
    required String driverId,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
