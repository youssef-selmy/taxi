import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/graphql/gift_card.graphql.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/repositories/gift_card_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'gift_card_list.state.dart';
part 'gift_card_list.cubit.freezed.dart';

class GiftCardListBloc extends Cubit<GiftCardListState> {
  final GiftCardRepository _giftCardRepository = locator<GiftCardRepository>();

  GiftCardListBloc() : super(GiftCardListState());

  void onStarted() {
    _getGiftCards();
  }

  Future<void> _getGiftCards() async {
    emit(state.copyWith(batches: const ApiResponse.loading()));
    final giftCards = await _giftCardRepository.getAll(
      paging: state.paging,
      filter: Input$GiftBatchFilter(
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: "%${state.searchQuery}%"),
      ),
      sort: state.sort,
    );
    emit(state.copyWith(batches: giftCards));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _getGiftCards();
  }

  void onSearchQueryChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _getGiftCards();
  }
}
