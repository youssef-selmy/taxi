import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_update_password_repository.dart';

@dev
@LazySingleton(as: ShopDetailUpdatePasswordRepository)
class ShopDetailUpdatePasswordRepositoryMock
    implements ShopDetailUpdatePasswordRepository {
  @override
  Future<ApiResponse<void>> updatePassword({
    required String shopId,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
