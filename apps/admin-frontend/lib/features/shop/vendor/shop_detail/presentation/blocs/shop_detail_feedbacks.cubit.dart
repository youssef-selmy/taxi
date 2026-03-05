import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_feedbacks.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_feedbacks_repository.dart';

part 'shop_detail_feedbacks.state.dart';
part 'shop_detail_feedbacks.cubit.freezed.dart';

class ShopDetailFeedbacksBloc extends Cubit<ShopDetailFeedbacksState> {
  final ShopDetailFeedbacksRepository _shopDetailFeedbacksRepository =
      locator<ShopDetailFeedbacksRepository>();

  ShopDetailFeedbacksBloc() : super(ShopDetailFeedbacksState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
    _fetchShopDetailFeedbacks();
  }

  void _fetchShopDetailFeedbacks() async {
    emit(state.copyWith(shopFeedbacksState: const ApiResponse.loading()));
    final shopDetailFeedbacksOrError = await _shopDetailFeedbacksRepository
        .getFeedbacks(shopId: state.shopId!);
    final shopDetailFeedbacksState = shopDetailFeedbacksOrError;
    emit(state.copyWith(shopFeedbacksState: shopDetailFeedbacksState));
  }
}
