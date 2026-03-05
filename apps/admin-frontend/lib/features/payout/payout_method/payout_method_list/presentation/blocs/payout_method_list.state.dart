part of 'payout_method_list.cubit.dart';

@freezed
sealed class PayoutMethodListState with _$PayoutMethodListState {
  const factory PayoutMethodListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$payoutMethods$payoutMethods> payoutMethodsState,
    @Default([]) List<Input$PayoutMethodSort> sorting,
    String? search,
    @Default([]) List<Enum$PayoutMethodType> typesFilter,
    Input$OffsetPaging? paging,
  }) = _PayoutMethodListState;
}
