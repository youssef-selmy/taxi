import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_orders.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'park_spot_detail_orders.state.dart';
part 'park_spot_detail_orders.cubit.freezed.dart';

class ParkSpotDetailOrdersBloc extends Cubit<ParkSpotDetailOrdersState> {
  final ParkSpotDetailOrdersRepository _parkSpotDetailOrdersRepository =
      locator<ParkSpotDetailOrdersRepository>();

  ParkSpotDetailOrdersBloc() : super(ParkSpotDetailOrdersState());

  void onStarted({required String parkSpotId}) {
    emit(state.copyWith(parkSpotId: parkSpotId));
    _fetchActiveOrders();
  }

  void onTabSelected(int value) {
    emit(state.copyWith(selectedTab: value));
    if (value == 0) {
      _fetchActiveOrders();
    } else {
      _fetchHistoryOrders();
    }
  }

  Future<void> _fetchActiveOrders() async {
    emit(state.copyWith(activeOrdersState: const ApiResponse.loading()));
    final activeOrdersOrError = await _parkSpotDetailOrdersRepository
        .getParkSpotActiveOrders(parkSpotId: state.parkSpotId!);
    final activeOrdersState = activeOrdersOrError;
    emit(state.copyWith(activeOrdersState: activeOrdersState));
  }

  Future<void> _fetchHistoryOrders() async {
    emit(state.copyWith(ordersHistoryState: const ApiResponse.loading()));
    final historyOrdersOrError = await _parkSpotDetailOrdersRepository
        .getParkSpotOrders(
          filter: Input$ParkOrderFilter(
            status: state.statusFilter.isEmpty
                ? null
                : Input$ParkOrderStatusFilterComparison(
                    $in: state.statusFilter,
                  ),
          ),
          paging: state.historyPaging,
          sorting: state.sorting,
        );
    final historyOrdersState = historyOrdersOrError;
    emit(state.copyWith(ordersHistoryState: historyOrdersState));
  }

  void onStatusFilterChanged(List<Enum$ParkOrderStatus> selectedItems) {
    emit(state.copyWith(statusFilter: selectedItems));
    _fetchHistoryOrders();
  }

  void onHistoryPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(historyPaging: p1));
    _fetchHistoryOrders();
  }
}
