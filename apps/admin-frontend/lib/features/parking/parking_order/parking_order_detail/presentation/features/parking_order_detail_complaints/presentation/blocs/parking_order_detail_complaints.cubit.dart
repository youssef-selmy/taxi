import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/data/graphql/parking_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/data/repositories/parking_order_detail_complaints_repository.dart';

part 'parking_order_detail_complaints.state.dart';
part 'parking_order_detail_complaints.cubit.freezed.dart';

class ParkingOrderDetailComplaintsBloc
    extends Cubit<ParkingOrderDetailComplaintsState> {
  final ParkingOrderDetailComplaintsRepository
  _parkingOrderDetailComplaintRepository =
      locator<ParkingOrderDetailComplaintsRepository>();

  ParkingOrderDetailComplaintsBloc()
    : super(ParkingOrderDetailComplaintsState());

  void onStarted(String parkingOrderId) {
    _fetchParkingOrderDetailSupportRequest(parkingOrderId);
  }

  Future<void> _fetchParkingOrderDetailSupportRequest(
    String parkingOrderId,
  ) async {
    emit(
      state.copyWith(parkingOrderComplaintsState: const ApiResponse.loading()),
    );

    final parkingOrderSupportRequestOrError =
        await _parkingOrderDetailComplaintRepository
            .getParkingOrderDetailCpmplaints(parkingOrderId: parkingOrderId);

    emit(
      state.copyWith(
        parkingOrderComplaintsState: parkingOrderSupportRequestOrError,
      ),
    );
  }
}
