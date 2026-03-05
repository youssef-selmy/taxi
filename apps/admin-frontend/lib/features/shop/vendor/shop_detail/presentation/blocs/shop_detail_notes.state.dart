part of 'shop_detail_notes.cubit.dart';

@freezed
sealed class ShopDetailNotesState with _$ShopDetailNotesState {
  const factory ShopDetailNotesState({
    @Default(ApiResponseInitial()) ApiResponse<Query$shopNotes> shopNotesState,
    String? shopId,
    String? note,
    @Default(ApiResponseInitial()) ApiResponse<void> createShopNoteState,
  }) = _ShopDetailNotesState;

  const ShopDetailNotesState._();
}
