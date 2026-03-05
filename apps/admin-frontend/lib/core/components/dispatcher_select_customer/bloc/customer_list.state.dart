part of 'customer_list.cubit.dart';

@freezed
sealed class CustomerListState with _$CustomerListState {
  const factory CustomerListState({
    @Default(ApiResponse.initial()) ApiResponse<Query$Customers> customerList,
    Input$OffsetPaging? paging,
    String? query,
  }) = _CustomerListState;
}
