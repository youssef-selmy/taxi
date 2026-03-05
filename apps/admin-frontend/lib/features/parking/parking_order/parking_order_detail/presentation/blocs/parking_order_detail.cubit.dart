import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/data/repositories/parking_order_detail_repository.dart';

part 'parking_order_detail.state.dart';
part 'parking_order_detail.cubit.freezed.dart';

class ParkingOrderDetailBloc extends Cubit<ParkingOrderDetailState> {
  final ParkingOrderDetailRepository _parkingOrderDetailRepository =
      locator<ParkingOrderDetailRepository>();

  ParkingOrderDetailBloc()
    : super(
        // ignore: prefer_const_constructors
        ParkingOrderDetailState(),
      );

  void onStarted({required String parkingOrderId}) {
    emit(state.copyWith(parkingOrderId: parkingOrderId));
    _fetchShopOrderDetail();
  }

  Future<void> _fetchShopOrderDetail() async {
    emit(state.copyWith(parkingOrderDetailState: const ApiResponse.loading()));

    final parkingOrderDetailOrError = await _parkingOrderDetailRepository
        .getParkingOrderDetail(id: state.parkingOrderId!);

    emit(state.copyWith(parkingOrderDetailState: parkingOrderDetailOrError));
  }
}
