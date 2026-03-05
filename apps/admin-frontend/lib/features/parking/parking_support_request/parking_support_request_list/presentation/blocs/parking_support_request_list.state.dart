part of 'parking_support_request_list.cubit.dart';

@freezed
sealed class ParkingSupportRequestState with _$ParkingSupportRequestState {
  const factory ParkingSupportRequestState({
    required ApiResponse<Query$parkingSupportRequests> supportRequest,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ParkingSupportRequestSort> sortFields,
    @Default([]) List<Enum$ComplaintStatus> filterStatus,
  }) = _ParkingSupportRequestState;

  factory ParkingSupportRequestState.initial() =>
      ParkingSupportRequestState(supportRequest: const ApiResponse.initial());
}
