part of 'park_spot_pending_verification_list.cubit.dart';

@freezed
sealed class ParkSpotPendingVerificationListState
    with _$ParkSpotPendingVerificationListState {
  const factory ParkSpotPendingVerificationListState({
    @Default(ApiResponseInitial()) ApiResponse<Query$parkSpots> parkSpotsState,
    @Default([]) List<Enum$ParkSpotType> parkSpotType,
    String? searchQuery,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ParkSpotSort> sorting,
    @Default([Enum$ParkSpotStatus.Pending])
    List<Enum$ParkSpotStatus> statusFilter,
    @Default([]) List<Enum$ParkSpotType> typeFilter,
  }) = _ParkSpotPendingVerificationListState;
}
