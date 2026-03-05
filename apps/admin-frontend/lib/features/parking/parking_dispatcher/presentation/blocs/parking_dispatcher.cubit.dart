import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:generic_map/interfaces/place.dart';

import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/customers_repository.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/data/repositories/parking_dispatcher_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'parking_dispatcher.state.dart';
part 'parking_dispatcher.cubit.freezed.dart';

class ParkingDispatcherBloc extends Cubit<ParkingDispatcherState> {
  final CustomersRepository _customersRepository =
      locator<CustomersRepository>();
  final ParkingDispatcherRepository _parkingDispatcherRepository =
      locator<ParkingDispatcherRepository>();

  ParkingDispatcherBloc()
    : super(
        ParkingDispatcherState(
          selectedDate: DateTime.now(),
          fromTime: TimeOfDay.now(),
          toTime: TimeOfDay.now().replacing(
            hour: (TimeOfDay.now().hour < 23) ? TimeOfDay.now().hour + 1 : 0,
          ),
        ),
      );

  Future<void> onCustomerSelected(Fragment$CustomerCompact p1) async {
    emit(
      state.copyWith(
        selectedCustomer: p1,
        currentStep: 1,
        networkState: const ApiResponse.loading(),
      ),
    );
    final addresses = await _customersRepository.getCustomerAddresses(
      customerId: p1.id,
    );
    emit(state.copyWith(customerAddresses: addresses.data ?? []));
  }

  void onAddressConfirmed() async {
    emit(state.copyWith(currentStep: 2, parkings: const ApiResponse.loading()));
    final parkingsOrError = await _parkingDispatcherRepository.getParkings(
      location: state.selectedDestination!.point,
      fromTime: DateTime(
        state.selectedDate.year,
        state.selectedDate.month,
        state.selectedDate.day,
        state.fromTime.hour,
        state.fromTime.minute,
      ),
      toTime: DateTime(
        state.selectedDate.year,
        state.selectedDate.month,
        state.selectedDate.day,
        state.toTime.hour,
        state.toTime.minute,
      ),
    );
    final parkingsState = parkingsOrError;
    emit(state.copyWith(parkings: parkingsState));
  }

  void goBack() => emit(state.copyWith(currentStep: state.currentStep - 1));

  void onMapMoved(Place? p1) {
    emit(state.copyWith(selectedDestination: p1?.toFragmentPlace()));
  }

  void fromTimeChanged(TimeOfDay? value) {
    if (value == null) return;
    emit(state.copyWith(fromTime: value));
  }

  void toTimeChanged(TimeOfDay? value) {
    if (value == null) return;
    emit(state.copyWith(toTime: value));
  }

  void dateChanged(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void onParkingSelected(Fragment$parkSpotDetail parking) {
    emit(state.copyWith(selectedParking: parking));
  }

  void confirmParkingOrder() async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final order = await _parkingDispatcherRepository.createOrder(
      parkingId: state.selectedParking!.id,
      enterExitTime: state.enterExitTime,
      vehicleType: state.vehicleType,
    );
    emit(state.copyWith(networkState: order, isSuccessful: order.isLoaded));
  }

  void reset() {
    emit(
      ParkingDispatcherState(
        selectedDate: DateTime.now(),
        fromTime: TimeOfDay.now(),
        toTime: TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1),
      ),
    );
  }
}
