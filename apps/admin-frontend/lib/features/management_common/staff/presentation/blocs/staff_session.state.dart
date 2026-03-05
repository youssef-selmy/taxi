part of 'staff_session.cubit.dart';

@freezed
sealed class StaffSessionState with _$StaffSessionState {
  const factory StaffSessionState({
    required ApiResponse<void> networkStateSave,
    required ApiResponse<List<Fragment$staffSession>> staffSessionList,
  }) = _StaffSessionState;

  factory StaffSessionState.initial() => StaffSessionState(
    networkStateSave: const ApiResponse.initial(),
    staffSessionList: const ApiResponse.initial(),
  );
}
