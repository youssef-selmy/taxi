import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/repositories/vehicle_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'vehicle_color_details.state.dart';
part 'vehicle_color_details.cubit.freezed.dart';

class VehicleColorDetailsBloc extends Cubit<VehicleColorDetailsState> {
  final VehicleRepository _vehicleRepository = locator<VehicleRepository>();

  VehicleColorDetailsBloc() : super(VehicleColorDetailsState());

  void onStarted({required String? vehicleColorId}) async {
    if (vehicleColorId != null) {
      emit(state.copyWith(id: vehicleColorId));
      _fetchVehicleColor();
    } else {
      emit(state.copyWith(vehicleColor: const ApiResponse.loaded(null)));
    }
  }

  Future<void> _fetchVehicleColor() async {
    emit(state.copyWith(vehicleColor: const ApiResponse.loading()));
    final result = await _vehicleRepository.getVehicleColor(id: state.id!);
    final networkState = result;
    emit(
      state.copyWith(vehicleColor: networkState, name: networkState.data?.name),
    );
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onSave() async {
    if (state.id != null) {
      _updateVehicleColor();
    } else {
      _createVehicleColor();
    }
  }

  Future<void> _updateVehicleColor() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _vehicleRepository.updateVehicleColor(
      id: state.id!,
      input: Input$CarColorInput(name: state.name!),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  Future<void> _createVehicleColor() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _vehicleRepository.createVehicleColor(
      input: Input$CarColorInput(name: state.name!),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }
}
