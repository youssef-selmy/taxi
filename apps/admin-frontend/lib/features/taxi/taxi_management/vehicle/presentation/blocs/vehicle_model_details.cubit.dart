import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/repositories/vehicle_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'vehicle_model_details.state.dart';
part 'vehicle_model_details.cubit.freezed.dart';

class VehicleModelDetailsBloc extends Cubit<VehicleModelDetailsState> {
  final VehicleRepository _vehicleRepository = locator<VehicleRepository>();

  VehicleModelDetailsBloc() : super(VehicleModelDetailsState());

  void onStarted({required String? vehicleModelId}) async {
    if (vehicleModelId != null) {
      emit(state.copyWith(id: vehicleModelId));
      _fetchVehicleModel();
    } else {
      emit(state.copyWith(vehicleModel: const ApiResponse.loaded(null)));
    }
  }

  Future<void> _fetchVehicleModel() async {
    emit(state.copyWith(vehicleModel: const ApiResponse.loading()));
    final result = await _vehicleRepository.getVehicleModel(id: state.id!);
    final networkState = result;
    emit(
      state.copyWith(vehicleModel: networkState, name: networkState.data?.name),
    );
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onSave() async {
    if (state.id != null) {
      await _updateVehicleModel();
    } else {
      await _createVehicleModel();
    }
  }

  Future<void> _updateVehicleModel() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _vehicleRepository.updateVehicleModel(
      id: state.id!,
      input: Input$CarModelInput(name: state.name!),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  Future<void> _createVehicleModel() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _vehicleRepository.createVehicleModel(
      input: Input$CarModelInput(name: state.name!),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }
}
