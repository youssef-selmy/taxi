import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/data/graphql/shop_review_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/data/repositories/shop_review_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_review_list.state.dart';
part 'shop_review_list.cubit.freezed.dart';

class ShopReviewListBloc extends Cubit<ShopReviewListState> {
  final ShopReviewListRepository _shopReviewListRepository =
      locator<ShopReviewListRepository>();

  ShopReviewListBloc() : super(ShopReviewListState());

  void onStarted() {
    _fetchShopReviewsList();
  }

  Future<void> _fetchShopReviewsList() async {
    emit(state.copyWith(shopReviewsState: const ApiResponse.loading()));

    final shopReviewsListOrError = await _shopReviewListRepository
        .getShopReviewsList(
          paging: state.paging,
          filter: Input$ShopFeedbackFilter(
            status: state.filterStatus.isEmpty
                ? null
                : Input$ReviewStatusFilterComparison($in: state.filterStatus),
            comment: (state.search?.isEmpty ?? true)
                ? null
                : Input$StringFieldComparison(like: "%${state.search}%"),
          ),
          sorting: state.sortFields,
        );

    emit(state.copyWith(shopReviewsState: shopReviewsListOrError));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchShopReviewsList();
  }

  void onSortingChanged(List<Input$ShopFeedbackSort> value) {
    emit(state.copyWith(sortFields: value));
    _fetchShopReviewsList();
  }

  void onStatusFilterChanged(List<Enum$ReviewStatus> value) {
    emit(state.copyWith(filterStatus: value));
    _fetchShopReviewsList();
  }

  void onSearchFilterChanged(String value) {
    emit(state.copyWith(search: value));
    _fetchShopReviewsList();
  }

  void onUpdateFeedbackStatus(String id, Enum$ReviewStatus status) async {
    final updateOrError = await _shopReviewListRepository
        .updateShopFeedbackStatus(id: id, status: status);

    if (updateOrError.isLoaded) {
      _fetchShopReviewsList();
    }
  }
}
