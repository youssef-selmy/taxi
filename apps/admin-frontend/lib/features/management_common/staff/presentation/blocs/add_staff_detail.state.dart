part of 'add_staff_detail.cubit.dart';

@freezed
sealed class AddStaffDetailState with _$AddStaffDetailState {
  const factory AddStaffDetailState({
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
  }) = _AddStaffDetailState;

  factory AddStaffDetailState.initial() => AddStaffDetailState(
    staff: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
    staffRoleList: const ApiResponse.initial(),
    roles: const ApiResponse.initial(),
  );
}
