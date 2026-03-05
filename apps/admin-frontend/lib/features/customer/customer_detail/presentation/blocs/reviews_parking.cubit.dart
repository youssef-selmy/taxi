import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_parking.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/reviews_parking_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'reviews_parking.state.dart';
part 'reviews_parking.cubit.freezed.dart';

class ReviewsParkingBloc extends Cubit<ReviewsParkingState> {
  final ReviewsParkingRepository _reviewsParkingRepository =
      locator<ReviewsParkingRepository>();

  ReviewsParkingBloc()
    : super(ReviewsParkingState(networkState: const ApiResponse.initial()));

  void onStarted({required String customerId}) {
    emit(state.copyWith(customerId: customerId));
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final reviewsOrError = await _reviewsParkingRepository
        .getCustomerParkingReviews(state.customerId!);
    final reviewsState = reviewsOrError;
    emit(state.copyWith(networkState: reviewsState));
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchReviews();
  }
}
