import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_localization/country_code/country_code.dart';

part 'add_fleet.state.dart';
part 'add_fleet.cubit.freezed.dart';

class AddFleet extends Cubit<AddFleetState> {
  final FleetRepository _fleetRepository = locator<FleetRepository>();

  AddFleet() : super(AddFleetState.initial());

  Future<void> onAddFleet() async {
    emit(state.copyWith(fleet: const ApiResponse.loading()));

    final result = await _fleetRepository.create(
      input: Input$CreateFleetInput(
        name: state.name!,
        userName: state.userName!,
        password: state.password!,
        mobileNumber: state.mobileNumber.$2!,
        phoneNumber: state.phoneNumber.$2!,
        address: state.address,
        commissionSharePercent: state.commissionSharePercent,
        commissionShareFlat: state.commissionShareFlat,
        feeMultiplier: state.feeMultiplier,
        accountNumber: state.accountNumber!,
        exclusivityAreas: state.exclusivityAreas,
        profilePictureId: state.media?.id,
      ),
    );

    emit(state.copyWith(fleet: result));
  }

  void onNameChanged(String value) => emit(state.copyWith(name: value));

  void onUsernameChanged(String value) => emit(state.copyWith(userName: value));

  void onMobileNumberChanged((String, String?)? value) =>
      emit(state.copyWith(mobileNumber: value!));

  void onPhoneChanged((String, String?)? value) =>
      emit(state.copyWith(phoneNumber: value!));

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));

  void onAddressChanged(String value) => emit(state.copyWith(address: value));

  void onCommissionPercentageChanged(double? value) =>
      emit(state.copyWith(commissionSharePercent: value ?? 0));

  void onCommissionFlatChanged(double? value) =>
      emit(state.copyWith(commissionShareFlat: value ?? 0));

  void onFeeMultiplierChanged(double? value) =>
      emit(state.copyWith(feeMultiplier: value ?? 1));

  void onBankAccountInfoChanged(String value) =>
      emit(state.copyWith(accountNumber: value));

  void onExclusivityAreasChanged(List<Input$PointInput>? value) =>
      emit(state.copyWith(exclusivityAreas: [value ?? []]));

  void onImageChanged(Fragment$Media? value) {
    emit(state.copyWith(media: value));
  }
}
