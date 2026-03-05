part of 'parking_support_request_detail.cubit.dart';

@freezed
sealed class ParkingSupportRequestDetailState
    with _$ParkingSupportRequestDetailState {
  const factory ParkingSupportRequestDetailState({
    required ApiResponse<Query$parkingSupportRequest> supportRequestState,
    String? comment,
    String? id,
    List<String>? staffsId,
    @Default(ApiResponseInitial()) ApiResponse<void> createCommentState,
  }) = _ParkingSupportRequestDetailState;

  factory ParkingSupportRequestDetailState.initial() =>
      ParkingSupportRequestDetailState(
        supportRequestState: const ApiResponse.initial(),
      );
}
