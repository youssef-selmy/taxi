import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:generic_map/generic_map.dart';

import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_calculate_fare.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/customers_repository.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/data/graphql/taxi_calculate_fare.graphql.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/data/repositories/dispatcher_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'dispatcher_taxi.state.dart';
part 'dispatcher_taxi.cubit.freezed.dart';

class DispatcherTaxiBloc extends Cubit<DispatcherTaxiState> {
  final CustomersRepository _customersRepository =
      locator<CustomersRepository>();
  final DispatcherTaxiRepository _dispatcherTaxiRepository =
      locator<DispatcherTaxiRepository>();

  DispatcherTaxiBloc() : super(DispatcherTaxiState());

  void _resetErrorState() {
    Future.delayed(const Duration(microseconds: 300), () {
      emit(state.copyWith(networkState: const ApiResponse.initial()));
    });
  }

  void onCustomerSelected(Fragment$CustomerCompact customer) async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final result = await _customersRepository.getCustomerAddresses(
      customerId: customer.id,
    );
    result.fold(
      (l, {failure}) {
        emit(state.copyWith(networkState: ApiResponse.error(l.toString())));
        _resetErrorState();
      },
      (r) => emit(
        state.copyWith(
          selectedCustomer: customer,
          customerAddresses: r,
          currentStep: 1,
          mapCenter: r.isNotEmpty ? r.first.toFragmentPlace() : null,
          networkState: const ApiResponse.initial(),
        ),
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.customerAddresses.length < 2) {
        return;
      }
      state.selectLocationMapController?.fitBounds(
        state.customerAddresses.map((e) => e.location.toLatLngLib()).toList(),
      );
    });
  }

  void goBack() {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void onAddressConfirmed() async {
    final fare = await _dispatcherTaxiRepository.calculateFare(
      customerId: state.selectedCustomer!.id,
      locations: state.locations,
    );

    await fare.fold(
      (l, {failure}) async {
        emit(state.copyWith(networkState: ApiResponse.error(l.toString())));
        _resetErrorState();
      },
      (r) async => emit(
        state.copyWith(
          fare: r.calculateFare,
          selectedServiceCategoryIndex: 0,
          selectedServiceIndex: 0,
          currentStep: 2,
          networkState: const ApiResponse.initial(),
        ),
      ),
    );
  }

  void onAddressSelected(Fragment$Address p1) {
    state.selectLocationMapController?.moveCamera(
      p1.location.toLatLngLib(),
      null,
    );
    emit(state.copyWith(mapCenter: p1.toFragmentPlace()));
  }

  void onSelectLocationMapControllerReady(MapViewController controller) {
    emit(state.copyWith(selectLocationMapController: controller));
  }

  void onSearchForDriverMapControllerReady(MapViewController controller) {
    emit(state.copyWith(searchForDriverMapController: controller));
  }

  void onMapMoved(MapMoveEventType eventType, Place place) {
    if (eventType == MapMoveEventType.start) {
      emit(state.copyWith(mapCenter: null));
      return;
    }
    if (eventType == MapMoveEventType.addressResolved) {
      emit(state.copyWith(mapCenter: place.toFragmentPlace()));
    }
  }

  void addLocation() {
    emit(state.copyWith(locations: [...state.locations, state.mapCenter!]));
  }

  void onServiceSelected(int index) {
    emit(state.copyWith(selectedServiceIndex: index));
  }

  void setRoundTrip(bool p0) {
    emit(state.copyWith(isRoundTrip: p0));
  }

  void setWaitingTime(int? p1) {
    emit(state.copyWith(waitingTime: p1 ?? 0));
  }

  void setRideOption(Fragment$taxiOrderOption rideOption, bool value) {
    emit(
      state.copyWith(
        rideOptions: value
            ? [...state.rideOptions, rideOption]
            : state.rideOptions
                  .where((element) => element.id != rideOption.id)
                  .toList(),
      ),
    );
  }

  void onServiceCategorySelected(int value) {
    emit(state.copyWith(selectedServiceCategoryIndex: value));
  }

  void onReserveRideDateChanged(DateTime? newDateTime) {
    emit(state.copyWith(bookingTime: newDateTime));
  }

  void onReserveRide() async {
    if (state.bookingTime != null) {
      bookRide(assignDriver: false);
      return;
    }
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final driversLocations = await _dispatcherTaxiRepository.getDriverLocations(
      location: state.locations.first.point,
    );

    driversLocations.fold(
      (l, {failure}) {
        emit(state.copyWith(networkState: ApiResponse.error(l.toString())));
        _resetErrorState();
      },
      (r) {
        state.searchForDriverMapController?.fitBounds([
          ...r.map((e) => e.location.toLatLngLib()),
          ...state.locations.toLatLngList(),
        ]);
        emit(
          state.copyWith(
            driverLocations: r,
            currentStep: 3,
            selectedDriverLocation: null,
            networkState: const ApiResponse.initial(),
          ),
        );
      },
    );
  }

  void selectDriverLocation(Fragment$DriverLocation driverLocation) {
    emit(state.copyWith(selectedDriverLocation: driverLocation));
    state.searchForDriverMapController?.moveCamera(
      driverLocation.location.toLatLngLib(),
      null,
    );
  }

  Future<void> bookRide({required bool assignDriver}) async {
    emit(state.copyWith(networkState: ApiResponseLoading()));
    int intervalMinutes = 0;
    if (state.bookingTime != null) {
      intervalMinutes = DateTime.now().difference(state.bookingTime!).inMinutes;
    }
    final order = await _dispatcherTaxiRepository.createOrder(
      input: Input$CreateOrderInput(
        riderId: state.selectedCustomer!.id,
        serviceId: state.selectedService!.id,
        twoWay: state.isRoundTrip,
        waitingTimeMinutes: state.waitingTime,
        intervalMinutes: intervalMinutes,
        points: state.locations.toPointInputList(),
        addresses: state.locations.map((e) => e.address).toList(),
        driverId: assignDriver ? state.selectedDriverLocation!.id : null,
      ),
    );
    order.fold((l, {failure}) {
      emit(state.copyWith(networkState: ApiResponse.error(l.toString())));
      _resetErrorState();
    }, (r) => emit(state.copyWith(isSuccessful: true)));
  }

  void removeLastLocation() {
    if (state.locations.isNotEmpty) {
      emit(
        state.copyWith(
          locations: state.locations.sublist(0, state.locations.length - 1),
        ),
      );
    }
  }
}
