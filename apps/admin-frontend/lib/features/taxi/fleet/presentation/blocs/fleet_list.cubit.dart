import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'fleet_list.state.dart';
part 'fleet_list.cubit.freezed.dart';

class FleetListBloc extends Cubit<FleetListState> {
  final FleetRepository _fleetRepository = locator<FleetRepository>();

  FleetListBloc() : super(FleetListState.initial());

  void onStarted() {
    _fetchFleets();
  }

  //fetch
  Future<void> _fetchFleets() async {
    emit(state.copyWith(fleets: const ApiResponse.loading()));

    final staffs = await _fleetRepository.getFleets(
      paging: state.paging,
      filter: Input$FleetFilter(
        name: (state.searchQuery?.isEmpty ?? true)
            ? null
            : Input$StringFieldComparison(like: "%${state.searchQuery}%"),
      ),
      sorting: state.sortFields,
    );

    emit(state.copyWith(fleets: staffs));
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _fetchFleets();
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchFleets();
  }

  void onSortFieldsChanged(List<Input$FleetSort> p0) {
    emit(state.copyWith(sortFields: p0));
    _fetchFleets();
  }
}
