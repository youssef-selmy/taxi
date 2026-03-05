part of 'park_spot_detail_feedbacks.cubit.dart';

@freezed
sealed class ParkSpotDetailFeedbacksState with _$ParkSpotDetailFeedbacksState {
  const factory ParkSpotDetailFeedbacksState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkSpotFeedbacks> parkSpotFeedbacksState,
    String? parkSpotId,
  }) = _ParkSpotDetailFeedbacksState;
}
