import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff_role.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_repository.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_role_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'staff_details.state.dart';
part 'staff_details.cubit.freezed.dart';

class StaffDetailsBloc extends Cubit<StaffDetailsState> {
  final StaffRepository _staffRepository = locator<StaffRepository>();
  final StaffRoleRepository _staffRoleRepository =
      locator<StaffRoleRepository>();

  StaffDetailsBloc() : super(StaffDetailsState.initial());

  void onStarted({required String id}) async {
    getRoles();
    getOne(id);
  }

  Future<void> getOne(String id) async {
    emit(state.copyWith(staff: const ApiResponse.loading()));
    final staffDetails = await _staffRepository.getOne(id: id);

    emit(state.copyWith(staff: staffDetails));
  }

  Future<void> getRoles() async {
    emit(state.copyWith(staffRoleList: const ApiResponse.loading()));

    final staffRoles = await _staffRoleRepository.getAll(
      filter: Input$OperatorRoleFilter(),
      sorting: [],
    );

    emit(state.copyWith(roles: staffRoles.mapData((e) => e.staffRoles)));
  }

  void updateStaffDetails() async {
    final id = state.staff.data!.id;
    final updatedStaffDetails = await _staffRepository.update(
      id: id,
      input: Input$UpdateOperatorInput(
        firstName: state.firstName,
        lastName: state.lastName,
        userName: state.userName,
        email: state.email,
        mobileNumber: state.phoneNumber,
        roleId: state.roleId,
      ),
    );
    emit(
      state.copyWith(
        staff: updatedStaffDetails,
        networkStateSave: updatedStaffDetails,
      ),
    );
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  void onFirstNameChanged(String value) =>
      emit(state.copyWith(firstName: value));

  void onLastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void onUsernameChanged(String value) => emit(state.copyWith(userName: value));

  void onEmailChanged(String value) => emit(state.copyWith(email: value));

  void onPhoneChanged(String value) => emit(state.copyWith(phoneNumber: value));

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));

  void onRoleChanged(String? roleId) => emit(state.copyWith(roleId: roleId));

  Future<void> blockStaff() async {
    final id = state.staff.data!.id;
    final blockedStaffDetails = await _staffRepository.update(
      id: id,
      input: Input$UpdateOperatorInput(isBlocked: true),
    );
    emit(
      state.copyWith(
        staff: blockedStaffDetails,
        networkStateSave: blockedStaffDetails,
      ),
    );
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  Future<void> deleteStaff() async {
    final id = state.staff.data!.id;
    await _staffRepository.delete(id: id);
    emit(state.copyWith(staff: ApiResponse.error('Deleted')));
  }

  void submitPasswordChangeRequest() async {
    final id = state.staff.data!.id;
    final updatedStaffDetails = await _staffRepository.update(
      id: id,
      input: Input$UpdateOperatorInput(password: state.password),
    );
    emit(state.copyWith(networkStateSave: updatedStaffDetails));
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  Future<void> unblockStaff() async {
    final id = state.staff.data!.id;
    final updatedStaff = await _staffRepository.update(
      id: id,
      input: Input$UpdateOperatorInput(isBlocked: false),
    );
    emit(state.copyWith(staff: updatedStaff));
  }
}
