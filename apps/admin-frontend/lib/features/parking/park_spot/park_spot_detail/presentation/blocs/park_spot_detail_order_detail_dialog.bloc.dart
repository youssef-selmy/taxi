import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_orders_repository.dart';

part 'park_spot_detail_order_detail_dialog.state.dart';
part 'park_spot_detail_order_detail_dialog.bloc.freezed.dart';

class ParkSpotDetailOrderDetailDialogBloc
    extends Cubit<ParkSpotDetailOrderDetailDialogState> {
  final ParkSpotDetailOrdersRepository _ordersRepository =
      locator<ParkSpotDetailOrdersRepository>();

  ParkSpotDetailOrderDetailDialogBloc()
    : super(const ParkSpotDetailOrderDetailDialogState());

  void onStarted({required String orderId}) {
    emit(ParkSpotDetailOrderDetailDialogState(orderId: orderId));
    _fetchOrderDetail();
  }

  Future<void> _fetchOrderDetail() async {
    emit(state.copyWith(orderDetailState: ApiResponseLoading()));
    final orderOrError = await _ordersRepository.getOrderDetail(
      orderId: state.orderId!,
    );
    final orderState = orderOrError;
    emit(
      state.copyWith(
        orderDetailState: orderState.mapData((data) => data.parkOrder),
        parkSpotDetailState: orderState.mapData(
          (data) => data.parkSpotDetail.parkSpot,
        ),
      ),
    );
  }
}
