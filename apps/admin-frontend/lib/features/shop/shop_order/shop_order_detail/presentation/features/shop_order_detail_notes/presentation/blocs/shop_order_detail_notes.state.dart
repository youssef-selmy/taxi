part of 'shop_order_detail_notes.cubit.dart';

@freezed
sealed class ShopOrderDetailNotesState with _$ShopOrderDetailNotesState {
  const factory ShopOrderDetailNotesState({
    String? shopOrderId,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$shopOrderNote>> shopOrderDetailNotesState,
    String? note,
    @Default(ApiResponseInitial()) ApiResponse<void> createOrderNoteState,
  }) = _ShopOrderDetailNotesState;
}
