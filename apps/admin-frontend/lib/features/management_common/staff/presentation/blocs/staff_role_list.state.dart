part of 'staff_role_list.cubit.dart';

@freezed
sealed class StaffRoleListState with _$StaffRoleListState {
  const factory StaffRoleListState({
    required ApiResponse<List<Fragment$staffRole>> staffRoleList,
    required ApiResponse<Query$staffRoles> staffRoles,
    String? searchQuery,
    Input$OffsetPaging? paging,
  }) = _StaffRoleListState;

  factory StaffRoleListState.initial() => StaffRoleListState(
    staffRoleList: const ApiResponse.initial(),
    staffRoles: const ApiResponse.initial(),
  );
}
