part of 'cancel_reason_details.cubit.dart';

@freezed
sealed class CancelReasonDetailsState with _$CancelReasonDetailsState {
  const factory CancelReasonDetailsState({
    String? name,
    Enum$AnnouncementUserType? userType,
    required ApiResponse<Fragment$cancelReason?> cancelReason,
    required ApiResponse<void> networkStateSave,
  }) = _CancelReasonDetailsState;

  factory CancelReasonDetailsState.initial() => const CancelReasonDetailsState(
    cancelReason: ApiResponseInitial(),
    networkStateSave: ApiResponseInitial(),
  );
}
