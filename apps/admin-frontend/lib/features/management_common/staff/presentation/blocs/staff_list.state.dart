part of 'staff_list.cubit.dart';

@freezed
sealed class StaffListState with _$StaffListState {
  const factory StaffListState({
    required ApiResponse<Query$staffs> staffList,
    required ApiResponse<Query$staffRoles> staffRoleList,
    List<FilterItem<Fragment$staffRole>>? listFilterRole,
    @Default([]) List<bool> filterStaffStatus,
    String? searchQuery,
    Input$OffsetPaging? paging,
    @Default([]) List<Fragment$staffRole> filterStaffRole,
    @Default([]) List<Input$OperatorSort> sortFields,
    String? email,
  }) = _StaffListState;

  factory StaffListState.initial() => StaffListState(
    staffList: const ApiResponse.initial(),
    staffRoleList: const ApiResponse.initial(),
  );
}
