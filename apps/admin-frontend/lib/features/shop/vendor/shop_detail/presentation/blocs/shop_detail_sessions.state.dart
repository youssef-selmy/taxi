part of 'shop_detail_sessions.cubit.dart';

@freezed
sealed class ShopDetailSessionsState with _$ShopDetailSessionsState {
  const factory ShopDetailSessionsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopLoginSessions> loginSessionsState,
    String? shopId,
  }) = _ShopDetailSessionsState;
}
