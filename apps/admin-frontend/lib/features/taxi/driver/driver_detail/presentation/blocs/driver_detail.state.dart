part of 'driver_detail.bloc.dart';

@freezed
sealed class DriverDetailState with _$DriverDetailState {
  const factory DriverDetailState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverDetail> driverDetailResponse,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$updateDriver> updateDriverState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$updateDriverService> updateDriverServiceState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$updateDriverStatusDetail> updateDriverStatusState,
    Fragment$driverDetail? updatedDriverDetail,
    String? driverId,
    String? selectedServiceCategoryId,
    @Default([]) List<String> selectedServiceIds,
  }) = _DriverDetailState;

  const DriverDetailState._();

  List<Fragment$taxiPricingListItem> get selectedTabServices =>
      driverDetailResponse.data?.serviceCategories
          .firstWhereOrNull((e) => e.id == selectedServiceCategoryId)
          ?.services
          .toList() ??
      [];
}
