import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/data/graphql/shop_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/data/repositories/shop_order_detail_reviews_repository.dart';

part 'shop_order_detail_reviews.state.dart';
part 'shop_order_detail_reviews.cubit.freezed.dart';

class ShopOrderDetailReviewsBloc extends Cubit<ShopOrderDetailReviewsState> {
  final ShopOrderDetailReviewsRepository _shopOrderDetailReviewRepository =
      locator<ShopOrderDetailReviewsRepository>();

  ShopOrderDetailReviewsBloc() : super(ShopOrderDetailReviewsState());

  void onStarted(String shopOrderId) {
    _fetchReviews(shopOrderId);
  }

  Future<void> _fetchReviews(String shopOrderId) async {
    emit(
      state.copyWith(shopOrderDetailReviewsState: const ApiResponse.loading()),
    );
    final reviewsOrError = await _shopOrderDetailReviewRepository.getFeedBacks(
      orderId: shopOrderId,
    );

    emit(state.copyWith(shopOrderDetailReviewsState: reviewsOrError));
  }
}
