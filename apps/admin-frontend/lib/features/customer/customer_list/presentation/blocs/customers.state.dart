part of 'customers.cubit.dart';

@freezed
sealed class CustomersState with _$CustomersState {
  const factory CustomersState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$CustomersListConnection> customers,
    String? query,
    Input$OffsetPaging? paging,
    @Default([]) List<Enum$RiderStatus> filterCustomerStatus,
    required List<Input$RiderSort> sortFields,
  }) = _CustomersState;

  factory CustomersState.initial() {
    return CustomersState(
      sortFields: [
        Input$RiderSort(
          field: Enum$RiderSortFields.id,
          direction: Enum$SortDirection.DESC,
        ),
      ],
    );
  }
}
