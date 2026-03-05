part of 'gift_card_details.cubit.dart';

@freezed
sealed class GiftCardDetailsState with _$GiftCardDetailsState {
  const factory GiftCardDetailsState({
    String? batchId,
    @Default(ApiResponseInitial()) ApiResponse<Query$giftBatch> batch,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$giftCodeConnection> giftCodes,
    @Default(ApiResponseInitial()) ApiResponse<String> export,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$GiftCodeSort> sort,
  }) = _GiftCardDetailsState;
}
