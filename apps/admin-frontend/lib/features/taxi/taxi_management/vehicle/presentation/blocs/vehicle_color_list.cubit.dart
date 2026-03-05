import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/graphql/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/repositories/vehicle_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'vehicle_color_list.state.dart';
part 'vehicle_color_list.cubit.freezed.dart';

class VehicleColorListBloc extends Cubit<VehicleColorListState> {
  final VehicleRepository _vehicleRepository = locator<VehicleRepository>();

  VehicleColorListBloc() : super(VehicleColorListState());

  void onStarted() {
    _fetchVehicleColors();
  }

  Future<void> _fetchVehicleColors() async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final vehicleColors = await _vehicleRepository.getVehicleColors(
      paging: state.paging,
      sort: [],
      filter: Input$CarColorFilter(
        name: Input$StringFieldComparison(like: state.search),
      ),
    );
    final networkState = vehicleColors;
    emit(state.copyWith(networkState: networkState));
  }

  void onSearch(String search) {
    emit(state.copyWith(search: search));
    _fetchVehicleColors();
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchVehicleColors();
  }
}
