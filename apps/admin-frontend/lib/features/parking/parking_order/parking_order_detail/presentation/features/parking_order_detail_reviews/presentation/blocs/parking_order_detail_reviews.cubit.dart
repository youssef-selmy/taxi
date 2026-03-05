import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/data/graphql/parking_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/data/repositories/parking_order_detail_reviews_repository.dart';

part 'parking_order_detail_reviews.state.dart';
part 'parking_order_detail_reviews.cubit.freezed.dart';

class ParkingOrderDetailReviewsBloc
    extends Cubit<ParkingOrderDetailReviewsState> {
  final ParkingOrderDetailReviewsRepository
  _parkingOrderDetailReviewRepository =
      locator<ParkingOrderDetailReviewsRepository>();

  ParkingOrderDetailReviewsBloc()
    : super(
        // ignore: prefer_const_constructors
        ParkingOrderDetailReviewsState(),
      );

  void onStarted(String parkingOrderId) {
    _fetchParkingOrderDetailNotes(parkingOrderId);
  }

  Future<void> _fetchParkingOrderDetailNotes(String parkingOrderId) async {
    emit(state.copyWith(parkingOrderReviewState: const ApiResponse.loading()));

    final parkingOrderDetailReviewOrError =
        await _parkingOrderDetailReviewRepository.getParkingOrderDetailReview(
          parkingOrderId: parkingOrderId,
        );

    emit(
      state.copyWith(parkingOrderReviewState: parkingOrderDetailReviewOrError),
    );
  }
}
