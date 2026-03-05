part of 'taxi_order_detail_chat_histories.cubit.dart';

@freezed
sealed class TaxiOrderDetailChatHistoriesState
    with _$TaxiOrderDetailChatHistoriesState {
  const factory TaxiOrderDetailChatHistoriesState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$getTaxiOrderDetailChatHistories>
    taxiOrderConversationState,
  }) = _TaxiOrderDetailChatHistoriesState;
}
