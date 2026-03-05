part of 'driver_pending_verification_list.bloc.dart';

@freezed
sealed class DriverPendingVerificationListState
    with _$DriverPendingVerificationListState {
  const factory DriverPendingVerificationListState({
    @Default(ApiResponse.initial()) ApiResponse<Query$drivers> driversState,
    String? searchQuery,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$DriverSort> sorting,
    @Default([]) List<Enum$DriverStatus> driverStatusFilter,
  }) = _DriverPendingVerificationListState;
}
