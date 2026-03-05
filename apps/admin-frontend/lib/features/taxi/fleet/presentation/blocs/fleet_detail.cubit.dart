import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'fleet_detail.state.dart';
part 'fleet_detail.cubit.freezed.dart';

class FleetDetailBloc extends Cubit<FleetDetailState> {
  final FleetRepository _fleetRepository = locator<FleetRepository>();
  FleetDetailBloc() : super(FleetDetailState.initial());

  void onStarted(String id) {
    _getOneFleet(id);
  }

  Future<void> _getOneFleet(String id) async {
    emit(state.copyWith(fleet: const ApiResponse.loading()));
    final result = await _fleetRepository.getFleetDetails(id: id);

    emit(state.copyWith(fleet: result));
  }

  Future<void> onUpdateFleet() async {
    emit(state.copyWith(fleetUpdate: const ApiResponse.loading()));
    final result = await _fleetRepository.update(
      id: state.id!,
      input: Input$UpdateFleetInput(
        name: state.name!,
        mobileNumber: state.mobileNumber!,
        userName: state.userName!,
        phoneNumber: state.phoneNumber!,
        address: state.address,
        password: state.password!,
        commissionSharePercent: state.commissionSharePercent!,
        commissionShareFlat: state.commissionShareFlat!,
        feeMultiplier: state.feeMultiplier,
        accountNumber: state.accountNumber!,
        exclusivityAreas: [state.exclusivityAreas ?? []],
      ),
    );

    emit(state.copyWith(fleetUpdate: result));
  }

  void onIdChanged(String value) => emit(state.copyWith(id: value));

  void onNameChanged(String value) => emit(state.copyWith(name: value));

  void onUsernameChanged(String value) => emit(state.copyWith(userName: value));

  void onMobileNumberChanged(String value) =>
      emit(state.copyWith(mobileNumber: value));

  void onPhoneChanged(String value) => emit(state.copyWith(phoneNumber: value));

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));

  void onAddressChanged(String value) => emit(state.copyWith(address: value));

  void onCommissionPercentageChanged(String value) =>
      emit(state.copyWith(commissionSharePercent: double.parse(value)));

  void onCommissionFlatChanged(String value) =>
      emit(state.copyWith(commissionShareFlat: double.parse(value)));

  void onFeeMultiplierChanged(String value) =>
      emit(state.copyWith(feeMultiplier: double.parse(value)));

  void onBankAccountInfoChanged(String value) =>
      emit(state.copyWith(accountNumber: value));

  void onExclusivityAreasChanged(List<Input$PointInput>? value) =>
      emit(state.copyWith(exclusivityAreas: value));

  void deleteFleet() {
    _fleetRepository.deleteFleet(id: state.id!);
  }

  Future<ApiResponse<void>> blockFleet() async {
    final fleetUpdateResponse = await _fleetRepository.update(
      id: state.id!,
      input: Input$UpdateFleetInput(isBlocked: true),
    );
    emit(state.copyWith(fleetUpdate: fleetUpdateResponse));
    return fleetUpdateResponse;
  }

  Future<ApiResponse<void>> unblockFleet() async {
    final fleetUpdateResponse = await _fleetRepository.update(
      id: state.id!,
      input: Input$UpdateFleetInput(isBlocked: false),
    );
    emit(state.copyWith(fleetUpdate: fleetUpdateResponse));
    return fleetUpdateResponse;
  }
}
