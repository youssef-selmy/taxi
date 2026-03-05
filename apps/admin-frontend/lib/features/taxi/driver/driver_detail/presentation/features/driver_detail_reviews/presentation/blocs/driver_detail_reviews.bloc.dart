import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/data/graphql/driver_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/data/repositories/driver_detail_reviews_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_detail_reviews.state.dart';
part 'driver_detail_reviews.bloc.freezed.dart';

class DriverDetailReviewsBloc extends Cubit<DriverDetailReviewsState> {
  final DriverDetailReviewsRepository _driverDetailReviewsRepository =
      locator<DriverDetailReviewsRepository>();

  DriverDetailReviewsBloc()
    : super(
        // ignore: prefer_const_constructors
        DriverDetailReviewsState(),
      );

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));
    _fetchDriverReviews();
  }

  Future<void> _fetchDriverReviews() async {
    emit(state.copyWith(driverReviewsState: const ApiResponse.loading()));

    var driverReviewsOrError = await _driverDetailReviewsRepository
        .getDriverReviews(driverId: state.driverId!, paging: state.paging);

    emit(state.copyWith(driverReviewsState: driverReviewsOrError));
  }

  void onPageChanged(Input$OffsetPaging value) {
    emit(state.copyWith(paging: value));
    _fetchDriverReviews();
  }
}
