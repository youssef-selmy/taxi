import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_staffs.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_staffs_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'fleet_staffs.state.dart';
part 'fleet_staffs.cubit.freezed.dart';

class FleetStaffsBloc extends Cubit<FleetStaffsState> {
  final FleetStaffsRepository _fleetStaffsRepository =
      locator<FleetStaffsRepository>();

  FleetStaffsBloc() : super(FleetStaffsState.initial());

  void onStarted(String id) {
    onIdChange(id);
    _fetchFleetStaffs();
  }

  Future<void> _fetchFleetStaffs() async {
    emit(state.copyWith(fleetStaffs: const ApiResponse.loading()));

    final staffs = await _fleetStaffsRepository.getFleetStaffs(
      paging: state.paging,
      filter: Input$FleetStaffFilter(
        fleetId: Input$IDFilterComparison(eq: state.fleetId),
        and: [
          Input$FleetStaffFilter(
            or: [
              Input$FleetStaffFilter(
                firstName: Input$StringFieldComparison(
                  like: "%${state.searchQuery}%",
                ),
              ),
              Input$FleetStaffFilter(
                lastName: Input$StringFieldComparison(
                  like: "%${state.searchQuery}%",
                ),
              ),
              Input$FleetStaffFilter(
                userName: Input$StringFieldComparison(
                  like: "%${state.searchQuery}%",
                ),
              ),
            ],
          ),
        ],
        isBlocked: state.statusFilter.length != 1
            ? null
            : Input$BooleanFieldComparison($is: state.statusFilter[0]),
      ),
      sorting: state.sortFields,
    );

    emit(state.copyWith(fleetStaffs: staffs));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchFleetStaffs();
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _fetchFleetStaffs();
  }

  void onSortFieldsChanged(List<Input$FleetStaffSort> value) {
    emit(state.copyWith(sortFields: value, paging: null));
    _fetchFleetStaffs();
  }

  void onIdChange(String id) {
    emit(state.copyWith(fleetId: id));
  }

  void onFilterStatusChanged(List<bool> selectedItems) {
    emit(state.copyWith(statusFilter: selectedItems, paging: null));
    _fetchFleetStaffs();
  }
}
