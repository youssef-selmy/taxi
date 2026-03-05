part of 'vendor_list_pending_verification.cubit.dart';

@freezed
sealed class VendorListPendingVerificationState
    with _$VendorListPendingVerificationState {
  const factory VendorListPendingVerificationState({
    @Default(ApiResponseInitial()) ApiResponse<Query$vendors> vendorsState,
    String? searchQuery,
    @Default([]) List<Input$ShopSort> sorting,
    Input$OffsetPaging? paging,
  }) = _VendorListPendingVerificationState;
}
