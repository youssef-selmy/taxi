part of 'gift_card_list.cubit.dart';

@freezed
sealed class GiftCardListState with _$GiftCardListState {
  const factory GiftCardListState({
    @Default(ApiResponseInitial()) ApiResponse<Query$giftBatches> batches,
    Input$OffsetPaging? paging,
    String? searchQuery,
    Input$GiftBatchFilter? filter,
    @Default([]) List<Input$GiftBatchSort> sort,
  }) = _GiftCardListState;
}
