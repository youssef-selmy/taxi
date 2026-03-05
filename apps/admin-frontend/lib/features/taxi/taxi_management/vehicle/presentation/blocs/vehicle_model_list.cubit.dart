import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/graphql/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/repositories/vehicle_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'vehicle_model_list.state.dart';
part 'vehicle_model_list.cubit.freezed.dart';

class VehicleModelListBloc extends Cubit<VehicleModelListState> {
  final VehicleRepository _vehicleRepository = locator<VehicleRepository>();

  VehicleModelListBloc() : super(VehicleModelListState());

  void onStarted() {
    _fetchVehicleModels();
  }

  Future<void> _fetchVehicleModels() async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final vehicleModels = await _vehicleRepository.getVehicleModels(
      paging: state.paging,
      sort: [],
      filter: Input$CarModelFilter(
        name: Input$StringFieldComparison(like: state.search),
      ),
    );
    final networkState = vehicleModels;
    emit(state.copyWith(networkState: networkState));
  }

  void onSearch(String search) {
    emit(state.copyWith(search: search));
    _fetchVehicleModels();
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchVehicleModels();
  }
}
