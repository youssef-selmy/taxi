part of 'park_spot_detail_sessions.cubit.dart';

@freezed
sealed class ParkSpotDetailSessionsState with _$ParkSpotDetailSessionsState {
  const factory ParkSpotDetailSessionsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingLoginSessions> loginSessionsState,
    String? ownerId,
  }) = _ParkSpotDetailSessionsState;
}
