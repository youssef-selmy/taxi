import 'package:api_response/api_response.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff_role.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_repository.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_role_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'staff_list.state.dart';
part 'staff_list.cubit.freezed.dart';

class StaffListBloc extends Cubit<StaffListState> {
  final StaffRepository _staffRepository = locator<StaffRepository>();
  final StaffRoleRepository _staffRoleRepository =
      locator<StaffRoleRepository>();

  StaffListBloc() : super(StaffListState.initial());

  void onStarted() {
    _fetchStaffs();
    getRoles();
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _fetchStaffs();
  }

  void onFilterStaffRoleChanged(List<Fragment$staffRole> filterStaffRole) {
    emit(state.copyWith(filterStaffRole: filterStaffRole));
    _fetchStaffs();
  }

  void onFilterCustomerStatusChanged(List<bool> filterStaffStatus) {
    emit(state.copyWith(filterStaffStatus: filterStaffStatus));
    _fetchStaffs();
  }

  void onSortFieldsChanged(List<Input$OperatorSort> sortFields) {
    emit(state.copyWith(sortFields: sortFields));
    _fetchStaffs();
  }

  Future<void> _fetchStaffs() async {
    emit(state.copyWith(staffList: const ApiResponse.loading()));

    final staffs = await _staffRepository.getAll(
      paging: state.paging,
      filter: Input$OperatorFilter(id: Input$IDFilterComparison()),
      sorting: state.sortFields,
    );

    emit(state.copyWith(staffList: staffs));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchStaffs();
  }

  late List<FilterItem<Fragment$staffRole>> listFilterRole = [];

  Future<void> getRoles() async {
    emit(state.copyWith(staffRoleList: const ApiResponse.loading()));

    final staffRoles = await _staffRoleRepository.getAll(
      filter: Input$OperatorRoleFilter(),
      sorting: [],
    );

    staffRoles.fold(
      (l, {failure}) =>
          emit(state.copyWith(staffRoleList: const ApiResponse.error('error'))),
      (success) {
        listFilterRole = success.staffRoles
            .map((e) => FilterItem(label: e.title, value: e))
            .toList();

        emit(state.copyWith(listFilterRole: listFilterRole));
      },
    );
  }
}
