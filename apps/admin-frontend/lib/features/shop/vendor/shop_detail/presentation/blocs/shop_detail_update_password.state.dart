part of 'shop_detail_update_password.cubit.dart';

@freezed
sealed class ShopDetailUpdatePasswordState
    with _$ShopDetailUpdatePasswordState {
  const factory ShopDetailUpdatePasswordState({
    @Default(ApiResponseInitial()) ApiResponse<void> updatePasswordState,
    String? shopId,
    String? password,
    String? confirmPassword,
  }) = _ShopDetailUpdatePasswordState;
}
