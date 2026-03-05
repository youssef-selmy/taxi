part of 'cancel_reason_insights.cubit.dart';

@freezed
sealed class CancelReasonInsightsState with _$CancelReasonInsightsState {
  const factory CancelReasonInsightsState({
    required ApiResponse<Query$cancelReasonInsights> insights,
  }) = _CancelReasonInsightsState;

  factory CancelReasonInsightsState.initial() =>
      const CancelReasonInsightsState(insights: ApiResponseInitial());
}
