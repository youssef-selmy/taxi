import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_drivers.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_drivers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'fleet_drivers.state.dart';
part 'fleet_drivers.cubit.freezed.dart';

class FleetDriversBloc extends Cubit<FleetDriversState> {
  final FleetDriversRepository _fleetDriversRepository =
      locator<FleetDriversRepository>();

  FleetDriversBloc() : super(FleetDriversState.initial());

  void onStarted(String value) {
    onFleetIdChanged(value);
    _fetchFleetDrivers();
  }

  Future<void> _fetchFleetDrivers() async {
    emit(state.copyWith(fleetDrivers: const ApiResponse.loading()));

    final result = await _fleetDriversRepository.getFleetDrivers(
      paging: state.paging,
      filter: Input$DriverFilter(
        fleetId: Input$IDFilterComparison(eq: state.fleetId),
        status: Input$DriverStatusFilterComparison(
          $in: state.driverStatusFilter,
        ),
        lastName: Input$StringFieldComparison(like: '%${state.search}%'),
      ),
      sorting: state.sortFields,
      fleetId: state.fleetId!,
    );

    emit(state.copyWith(fleetDrivers: result));
  }

  void onFleetIdChanged(String value) => emit(state.copyWith(fleetId: value));

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchFleetDrivers();
  }

  void onSortingChanged(List<Input$DriverSort> value) {
    emit(state.copyWith(sortFields: value, paging: null));
    _fetchFleetDrivers();
  }

  void onStatusChanged(List<Enum$DriverStatus> value) {
    emit(state.copyWith(driverStatusFilter: value, paging: null));
    _fetchFleetDrivers();
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(search: query, paging: null));
    _fetchFleetDrivers();
  }

  void refresh() {
    _fetchFleetDrivers();
  }
}
