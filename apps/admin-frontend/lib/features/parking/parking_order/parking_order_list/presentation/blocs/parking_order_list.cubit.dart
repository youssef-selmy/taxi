import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/data/graphql/parking_order_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/data/repositories/parking_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'parking_order_list.state.dart';
part 'parking_order_list.cubit.freezed.dart';

class ParkingOrderListBloc extends Cubit<ParkingOrderListState> {
  final ParkingOrderListRepository _parkingOrderListRepository =
      locator<ParkingOrderListRepository>();

  ParkingOrderListBloc() : super(ParkingOrderListState());

  void onStarted() {
    _fetchParkingOrderList();
    _fetchParkingOrderStatistict();
  }

  Future<void> _fetchParkingOrderList() async {
    emit(state.copyWith(parkingOrderState: const ApiResponse.loading()));

    final parkingOrderListOrError = await _parkingOrderListRepository
        .getParkingOrderList(
          paging: state.paging,
          filter: Input$ParkOrderFilter(
            status: state.parkingOrderStatus.isEmpty
                ? null
                : Input$ParkOrderStatusFilterComparison(
                    $in: state.parkingOrderStatus,
                  ),
          ),
          sorting: state.sorting,
        );

    emit(state.copyWith(parkingOrderState: parkingOrderListOrError));
  }

  Future<void> _fetchParkingOrderStatistict() async {
    emit(state.copyWith(statistics: const ApiResponse.loading()));

    final parkingOrderStatistictOrError = await _parkingOrderListRepository
        .getShopOrderStatistics();

    emit(state.copyWith(statistics: parkingOrderStatistictOrError));
  }

  void onSortingChanged(List<Input$ParkOrderSort> value) {
    emit(state.copyWith(sorting: value));
    _fetchParkingOrderList();
  }

  void onStatusFilterChanged(List<Enum$ParkOrderStatus> listStatus) {
    emit(state.copyWith(parkingOrderStatus: listStatus));
    _fetchParkingOrderList();
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchParkingOrderList();
  }

  void onTabChangedFilter(int index) {
    switch (index) {
      case 0:
        onStatusFilterChanged([]);

      case 1:
        onStatusFilterChanged([Enum$ParkOrderStatus.ACCEPTED]);

      case 2:
        onStatusFilterChanged([Enum$ParkOrderStatus.PENDING]);

      case 3:
        onStatusFilterChanged([Enum$ParkOrderStatus.PAID]);

      case 4:
        onStatusFilterChanged([Enum$ParkOrderStatus.COMPLETED]);
      case 5:
        onStatusFilterChanged([Enum$ParkOrderStatus.REJECTED]);
      case 6:
        onStatusFilterChanged([Enum$ParkOrderStatus.CANCELLED]);
    }
  }
}
