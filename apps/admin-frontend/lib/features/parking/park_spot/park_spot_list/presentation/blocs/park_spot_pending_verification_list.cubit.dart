import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/graphql/park_spot_list.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/repositories/park_spot_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'park_spot_pending_verification_list.state.dart';
part 'park_spot_pending_verification_list.cubit.freezed.dart';

class ParkSpotPendingVerificationListBloc
    extends Cubit<ParkSpotPendingVerificationListState> {
  final ParkSpotListRepository _parkSpotListRepository =
      locator<ParkSpotListRepository>();

  ParkSpotPendingVerificationListBloc()
    : super(
        // ignore: prefer_const_constructors
        ParkSpotPendingVerificationListState(),
      );

  void onStarted() {
    _fetchParkSpots();
  }

  void _fetchParkSpots() async {
    emit(state.copyWith(parkSpotsState: const ApiResponse.loading()));

    final parkSpotsOrError = await _parkSpotListRepository.getParkSpots(
      paging: state.paging,
      filter: Input$ParkSpotFilter(
        status: state.statusFilter.isEmpty
            ? null
            : Input$ParkSpotStatusFilterComparison($in: state.statusFilter),
        type: state.typeFilter.isEmpty
            ? null
            : Input$ParkSpotTypeFilterComparison($in: state.typeFilter),
        name: (state.searchQuery?.isEmpty ?? true)
            ? null
            : Input$StringFieldComparison(like: state.searchQuery),
      ),
      sorting: state.sorting,
    );
    final parkSpotsState = parkSpotsOrError;
    emit(state.copyWith(parkSpotsState: parkSpotsState));
  }

  void onSearchQueryChanged(String p1) {
    emit(state.copyWith(searchQuery: p1));
    _fetchParkSpots();
  }

  void onSortChanged(List<Input$ParkSpotSort> p1) {
    emit(state.copyWith(sorting: p1));
    _fetchParkSpots();
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchParkSpots();
  }

  void onStatusFilterChanged(List<Enum$ParkSpotStatus> p1) {
    emit(state.copyWith(statusFilter: p1));
    _fetchParkSpots();
  }

  void onTypeFilterChanged(List<Enum$ParkSpotType> p1) {
    emit(state.copyWith(typeFilter: p1));
    _fetchParkSpots();
  }
}
