part of 'fleet_staff_session.cubit.dart';

@freezed
sealed class FleetStaffSessionState with _$FleetStaffSessionState {
  const factory FleetStaffSessionState({
    required ApiResponse<Query$fleetStaffSession> fleetStaffSession,
  }) = _FleetStaffSessionState;

  factory FleetStaffSessionState.initial() =>
      FleetStaffSessionState(fleetStaffSession: const ApiResponse.initial());
}
