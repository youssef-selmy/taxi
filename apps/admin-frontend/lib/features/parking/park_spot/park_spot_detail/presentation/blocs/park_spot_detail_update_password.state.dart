part of 'park_spot_detail_update_password.cubit.dart';

@freezed
sealed class ParkSpotDetailUpdatePasswordState
    with _$ParkSpotDetailUpdatePasswordState {
  const factory ParkSpotDetailUpdatePasswordState({
    @Default(ApiResponseInitial()) ApiResponse<void> updatePasswordState,
    String? ownerId,
    String? password,
    String? confirmPassword,
  }) = _ParkSpotDetailUpdatePasswordState;
}
