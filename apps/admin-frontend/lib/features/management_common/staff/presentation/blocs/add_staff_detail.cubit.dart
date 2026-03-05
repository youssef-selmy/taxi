import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff_role.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_repository.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_role_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'add_staff_detail.state.dart';
part 'add_staff_detail.cubit.freezed.dart';

class AddStaffDetailBloc extends Cubit<AddStaffDetailState> {
  final StaffRepository _staffRepository = locator<StaffRepository>();
  final StaffRoleRepository _staffRoleRepository =
      locator<StaffRoleRepository>();

  AddStaffDetailBloc() : super(AddStaffDetailState.initial());

  void onStarted() {
    getRoles();
  }

  Future<void> onAddStaff() async {
    emit(state.copyWith(staff: const ApiResponse.loading()));

    final result = await _staffRepository.create(
      input: Input$CreateOperatorInput(
        roleId: state.roleId!,
        userName: state.userName!,
        password: state.password!,
        mobileNumber: state.phoneNumber!,
        email: state.email,
        firstName: state.firstName,
        lastName: state.lastName,
      ),
    );

    emit(state.copyWith(staff: result));
  }

  Future<void> getRoles() async {
    emit(state.copyWith(staffRoleList: const ApiResponse.loading()));

    final staffRoles = await _staffRoleRepository.getAll(
      filter: Input$OperatorRoleFilter(),
      sorting: [],
    );

    emit(state.copyWith(roles: staffRoles.mapData((e) => e.staffRoles)));
  }

  void onFirstNameChanged(String value) =>
      emit(state.copyWith(firstName: value));

  void onLastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void onUsernameChanged(String value) => emit(state.copyWith(userName: value));

  void onEmailChanged(String value) => emit(state.copyWith(email: value));

  void onPhoneChanged(String value) => emit(state.copyWith(phoneNumber: value));

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));

  void onRoleChanged(String? roleId) => emit(state.copyWith(roleId: roleId));
}
