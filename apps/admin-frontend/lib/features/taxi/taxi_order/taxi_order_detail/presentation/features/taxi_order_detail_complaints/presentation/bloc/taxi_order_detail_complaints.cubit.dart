import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/data/graphql/taxi_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/data/repositories/taxi_order_detail_complaints_repository.dart';

part 'taxi_order_detail_complaints.state.dart';
part 'taxi_order_detail_complaints.cubit.freezed.dart';

class TaxiOrderDetailComplaintsBloc
    extends Cubit<TaxiOrderDetailComplaintsState> {
  final TaxiOrderDetailComplaintsRepository
  _taxiOrderDetailComplaintsRepository =
      locator<TaxiOrderDetailComplaintsRepository>();

  TaxiOrderDetailComplaintsBloc() : super(TaxiOrderDetailComplaintsState());
  void onStarted(String orderId) {
    _fetchComplaint(orderId);
  }

  Future<void> _fetchComplaint(String orderId) async {
    emit(state.copyWith(complaintState: const ApiResponse.loading()));

    final complaintsOrError = await _taxiOrderDetailComplaintsRepository
        .getTaxiOrderComplaints(id: orderId);

    emit(state.copyWith(complaintState: complaintsOrError));
  }
}
