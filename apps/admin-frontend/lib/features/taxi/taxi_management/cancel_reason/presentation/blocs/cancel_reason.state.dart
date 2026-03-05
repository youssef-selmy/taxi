part of 'cancel_reason.cubit.dart';

@freezed
sealed class CancelReasonState with _$CancelReasonState {
  const factory CancelReasonState({
    required ApiResponse<List<Fragment$cancelReason>> cancelReasons,
  }) = _CancelReasonState;

  const CancelReasonState._();

  factory CancelReasonState.initial() =>
      CancelReasonState(cancelReasons: const ApiResponse.initial());

  ApiResponse<List<Fragment$cancelReason>> get cancelReasonsDrivers =>
      switch (cancelReasons) {
        ApiResponseLoaded(:final data) => ApiResponse.loaded(
          data.driverReasons,
        ),
        _ => cancelReasons,
      };

  ApiResponse<List<Fragment$cancelReason>> get cancelReasonsCustomers =>
      switch (cancelReasons) {
        ApiResponseLoaded(:final data) => ApiResponse.loaded(
          data.customerReasons,
        ),
        _ => cancelReasons,
      };
}
