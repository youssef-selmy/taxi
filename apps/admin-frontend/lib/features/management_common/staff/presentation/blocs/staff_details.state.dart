part of 'staff_details.cubit.dart';

@freezed
sealed class StaffDetailsState with _$StaffDetailsState {
  const factory StaffDetailsState({
    required ApiResponse<Fragment$staffDetails?> staff,
    required ApiResponse<void> networkStateSave,
    required ApiResponse<Query$staffRoles> staffRoleList,
    required ApiResponse<List<Fragment$staffRole>> roles,
    String? firstName,
    String? lastName,
    String? userName,
    String? countryCode,
    String? phoneNumber,
    String? password,
    String? roleId,
    String? email,
  }) = _StaffDetailsState;

  factory StaffDetailsState.initial() => StaffDetailsState(
    staff: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
    staffRoleList: const ApiResponse.initial(),
    roles: const ApiResponse.initial(),
  );
}
