import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_staffs_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'fleet_staff_detail.state.dart';
part 'fleet_staff_detail.cubit.freezed.dart';

class FleetStaffDetailBloc extends Cubit<FleetStaffDetailState> {
  final FleetStaffsRepository _fleetStaffDetailRepository =
      locator<FleetStaffsRepository>();

  FleetStaffDetailBloc() : super(FleetStaffDetailState());

  void onStarted(String id) {
    _fetchFleetStaff(id);
  }

  Future<void> _fetchFleetStaff(String id) async {
    emit(state.copyWith(fleetStaff: const ApiResponse.loading()));

    final result = await _fleetStaffDetailRepository.getFleetStaffDetails(
      id: id,
    );

    emit(state.copyWith(fleetStaff: result));
  }

  Future<void> onUpdateFleetStaff() async {
    emit(state.copyWith(fleetStaffUpdate: const ApiResponse.loading()));

    final result = await _fleetStaffDetailRepository.updateFleetStaff(
      data: Input$UpdateOneFleetStaffInput(
        id: state.id!,
        update: Input$UpdateFleetStaffInput(
          firstName: state.firstName,
          lastName: state.lastName,
          phoneNumber: state.phoneNumber,
          mobileNumber: state.mobileNumber,
          userName: state.userName,
          permissionFinancial: state.permissionFinancial,
          permissionOrder: state.permissionOrder,
        ),
      ),
    );

    emit(state.copyWith(fleetStaffUpdate: result));
  }

  void onFirstNameChanged(String value) =>
      emit(state.copyWith(firstName: value));

  void onLastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void onUsernameChanged(String value) => emit(state.copyWith(userName: value));

  void onEmailChanged(String value) => emit(state.copyWith(email: value));

  void onPhoneChanged(String value) => emit(state.copyWith(phoneNumber: value));

  void onIdChanged(String value) => emit(state.copyWith(id: value));

  void onPermissionOrderChanged(Enum$FleetStaffPermissionOrder value) =>
      emit(state.copyWith(permissionOrder: value));

  void onPermissionFinancialChanged(Enum$FleetStaffPermissionFinancial value) =>
      emit(state.copyWith(permissionFinancial: value));

  void updateOrderPermission(Enum$FleetStaffPermissionOrder? value) {
    emit(state.copyWith(permissionOrder: value));
  }

  void updateFinancialPermission(Enum$FleetStaffPermissionFinancial? value) {
    emit(state.copyWith(permissionFinancial: value));
  }

  void onMobileNumberChanged(String value) {
    emit(state.copyWith(mobileNumber: value));
  }

  Future<void> deleteStaff() async {
    emit(state.copyWith(fleetStaffDelete: const ApiResponse.loading()));

    final result = await _fleetStaffDetailRepository.deleteFleetStaff(
      id: state.id!,
    );

    emit(state.copyWith(fleetStaffDelete: result));
  }

  Future<void> unblockStaff() async {
    final result = await _fleetStaffDetailRepository.updateFleetStaff(
      data: Input$UpdateOneFleetStaffInput(
        id: state.id!,
        update: Input$UpdateFleetStaffInput(isBlocked: false),
      ),
    );

    emit(state.copyWith(fleetStaff: result));
  }

  Future<void> blockStaff() async {
    final result = await _fleetStaffDetailRepository.updateFleetStaff(
      data: Input$UpdateOneFleetStaffInput(
        id: state.id!,
        update: Input$UpdateFleetStaffInput(isBlocked: true),
      ),
    );

    emit(state.copyWith(fleetStaff: result));
  }
}
