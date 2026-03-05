import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_staffs_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'fleet_staff_create.state.dart';
part 'fleet_staff_create.cubit.freezed.dart';

class FleetStaffCreateBloc extends Cubit<FleetStaffCreateState> {
  final FleetStaffsRepository _fleetStaffCreateRepository =
      locator<FleetStaffsRepository>();

  FleetStaffCreateBloc() : super(FleetStaffCreateState.initial());

  Future<void> onCreateFleetStaff() async {
    emit(state.copyWith(fleetStaffCreate: const ApiResponse.loading()));

    final result = await _fleetStaffCreateRepository.createFleetStaff(
      data: Input$CreateOneFleetStaffInput(
        fleetStaff: Input$CreateFleetStaffInput(
          firstName: state.firstName!,
          lastName: state.lastName!,
          email: state.email,
          phoneNumber: state.phoneNumber,
          userName: state.userName!,
          password: state.password!,
          fleetId: state.fleetId!,
          permissionOrder: state.permissionOrder!,
          permissionFinancial: state.permissionFinancial!,
        ),
      ),
    );

    emit(state.copyWith(fleetStaffCreate: result));
  }

  void onFirstNameChanged(String value) =>
      emit(state.copyWith(firstName: value));

  void onLastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void onUsernameChanged(String value) => emit(state.copyWith(userName: value));

  void onEmailChanged(String value) => emit(state.copyWith(email: value));

  void onPhoneChanged(String value) => emit(state.copyWith(phoneNumber: value));

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));

  void onFleetIdChanged(String value) => emit(state.copyWith(fleetId: value));
}
