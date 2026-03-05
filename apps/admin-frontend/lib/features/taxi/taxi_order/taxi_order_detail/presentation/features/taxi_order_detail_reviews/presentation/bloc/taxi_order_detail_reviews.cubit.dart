import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/data/graphql/taxi_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/data/repositories/taxi_order_detail_reviews_repository.dart';

part 'taxi_order_detail_reviews.state.dart';
part 'taxi_order_detail_reviews.cubit.freezed.dart';

class TaxiOrderDetailReviewsBloc extends Cubit<TaxiOorderDetailReviewsState> {
  final TaxiOrderDetailReviewsRepository _feedBackRepository =
      locator<TaxiOrderDetailReviewsRepository>();

  TaxiOrderDetailReviewsBloc() : super(TaxiOorderDetailReviewsState());

  void onStarted(String orderId) {
    _fetchFeedBacks(orderId);
  }

  Future<void> _fetchFeedBacks(String orderId) async {
    emit(state.copyWith(taxiOrderReviewsState: const ApiResponse.loading()));
    final feedTaxiOrderReviewsOrError = await _feedBackRepository
        .getTaxiOrderDetailReviews(id: orderId);

    emit(state.copyWith(taxiOrderReviewsState: feedTaxiOrderReviewsOrError));
  }
}
