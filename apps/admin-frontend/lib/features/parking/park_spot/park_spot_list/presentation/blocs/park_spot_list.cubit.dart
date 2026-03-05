import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/graphql/park_spot_list.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/repositories/park_spot_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'park_spot_list.state.dart';
part 'park_spot_list.cubit.freezed.dart';

class ParkSpotListBloc extends Cubit<ParkSpotListState> {
  final ParkSpotListRepository _parkSpotListRepository =
      locator<ParkSpotListRepository>();

  ParkSpotListBloc() : super(ParkSpotListState());

  void onStarted() {
    _fetchParkSpots();
  }

  Future<void> _fetchParkSpots() async {
    emit(state.copyWith(parkSpotsState: const ApiResponse.loading()));

    final parkSpotsOrError = await _parkSpotListRepository.getParkSpots(
      paging: state.paging,
      filter: Input$ParkSpotFilter(
        type: Input$ParkSpotTypeFilterComparison(eq: state.parkSpotType),
        name: (state.searchQuery?.isEmpty ?? true)
            ? null
            : Input$StringFieldComparison(like: state.searchQuery),
      ),
      sorting: state.sorting,
    );

    final parkSpotsState = parkSpotsOrError;
    emit(state.copyWith(parkSpotsState: parkSpotsState));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchParkSpots();
  }

  void onTypeSelected(Enum$ParkSpotType value) {
    emit(state.copyWith(parkSpotType: value));
    _fetchParkSpots();
  }

  void onSearchQueryChanged(String p1) {
    emit(state.copyWith(searchQuery: p1));
    _fetchParkSpots();
  }

  void onSortChanged(List<Input$ParkSpotSort> p1) {
    emit(state.copyWith(sorting: p1));
    _fetchParkSpots();
  }

  void onStatusFilterChanged(List<Enum$ParkSpotStatus> p1) {
    emit(state.copyWith(statusFilter: p1));
    _fetchParkSpots();
  }
}
