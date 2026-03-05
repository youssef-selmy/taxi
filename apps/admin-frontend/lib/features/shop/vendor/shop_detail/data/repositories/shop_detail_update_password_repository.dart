import 'package:api_response/api_response.dart';

abstract class ShopDetailUpdatePasswordRepository {
  Future<ApiResponse<void>> updatePassword({
    required String shopId,
    required String password,
  });
}
