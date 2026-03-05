import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/data/repositories/park_spot_create_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'park_spot_create.state.dart';
part 'park_spot_create.cubit.freezed.dart';

class ParkSpotCreateBloc extends Cubit<ParkSpotCreateState> {
  final ParkSpotCreateRepository _parkSpotCreateRepository =
      locator<ParkSpotCreateRepository>();

  ParkSpotCreateBloc() : super(ParkSpotCreateState.initial());

  Null get onOwnerEmailChanged => null;

  void onStarted({String? parkSpotId}) {
    emit(state.copyWith(parkSpotId: parkSpotId));
    if (parkSpotId != null) {
      _fetchParkSpotDetail();
    } else {
      emit(state.copyWith(parkSpotState: const ApiResponse.loaded(null)));
    }
  }

  void _fetchParkSpotDetail() async {
    emit(state.copyWith(parkSpotState: const ApiResponse.loading()));

    final parkSpotOrError = await _parkSpotCreateRepository.getParkSpotDetail(
      parkSpotId: state.parkSpotId!,
    );
    final parkSpotState = parkSpotOrError;
    emit(state.copyWith(parkSpotState: parkSpotState));
  }

  void onTypeSelected(Enum$ParkSpotType type) =>
      emit(state.copyWith(type: type));

  void onNameChanged(String value) => emit(state.copyWith(name: value));

  void onAddressChanged(String value) => emit(state.copyWith(address: value));

  void onImagesChanged(List<Fragment$Media> images) =>
      emit(state.copyWith(images: images));

  void onDescriptionChanged(String value) =>
      emit(state.copyWith(description: value));

  void onPreviousPage() {
    emit(state.copyWith(wizardStep: state.wizardStep - 1));
    state.pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onNextPage() {
    emit(state.copyWith(wizardStep: state.wizardStep + 1));
    state.pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onOpenHoursChanged(List<Input$WeekdayScheduleInput> value) =>
      emit(state.copyWith(openHours: value));

  void toggleCarSpaces() {
    emit(state.copyWith(carSpaces: state.carSpaces == 0 ? 1 : 0));
  }

  void toggleBikeSpaces() {
    emit(state.copyWith(bikeSpaces: state.bikeSpaces == 0 ? 1 : 0));
  }

  void toggleTruckSpaces() {
    emit(state.copyWith(truckSpaces: state.truckSpaces == 0 ? 1 : 0));
  }

  void onCarSpacesChanged(int? p1) {
    emit(state.copyWith(carSpaces: p1!));
  }

  void onBikeSpacesChanged(int? p1) {
    emit(state.copyWith(bikeSpaces: p1!));
  }

  void onTruckSpacesChanged(int? p1) {
    emit(state.copyWith(truckSpaces: p1!));
  }

  void onCarSizeChanged(Enum$ParkSpotCarSize? p1) {
    emit(state.copyWith(carSize: p1));
  }

  void onCarPriceChanged(double? p1) {
    emit(state.copyWith(carPrice: p1));
  }

  void onBikePriceChanged(double? p1) {
    emit(state.copyWith(bikePrice: p1));
  }

  void onTruckPriceChanged(double? p1) {
    emit(state.copyWith(truckPrice: p1));
  }

  void toggleFacility(Enum$ParkSpotFacility facility) {
    if (state.facilities.contains(facility)) {
      emit(
        state.copyWith(
          facilities: state.facilities
              .where((element) => element != facility)
              .toList(),
        ),
      );
    } else {
      emit(state.copyWith(facilities: [...state.facilities, facility]));
    }
  }

  void onOwnerFirstNameChanged(String p1) =>
      emit(state.copyWith(ownerFirstName: p1));

  void onOwnerLastNameChanged(String p1) =>
      emit(state.copyWith(ownerLastName: p1));

  void onOwnerPhoneNumberChanged((String, String?)? p1) =>
      emit(state.copyWith(ownerPhoneNumber: p1!));

  void onOwnerGenderChanged(Enum$Gender? p1) =>
      emit(state.copyWith(ownerGender: p1));

  void onSubmit() async {
    final parkSpotOrError = await _parkSpotCreateRepository.createParkSpot(
      input: state.toCreateInput,
    );
    final parkSpotState = parkSpotOrError;
    emit(state.copyWith(saveState: parkSpotState));
  }
}
