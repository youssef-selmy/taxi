part of 'taxi_support_request_detail.cubit.dart';

@freezed
sealed class TaxiSupportRequestDetailState
    with _$TaxiSupportRequestDetailState {
  const factory TaxiSupportRequestDetailState({
    required ApiResponse<Query$taxiSupportRequest> supportRequestState,
    String? comment,
    String? id,
    List<String>? staffsId,
    @Default(ApiResponseInitial()) ApiResponse<void> createCommentState,
  }) = _TaxiSupportRequestDetailState;

  factory TaxiSupportRequestDetailState.initial() =>
      TaxiSupportRequestDetailState(
        supportRequestState: const ApiResponse.initial(),
      );
}
