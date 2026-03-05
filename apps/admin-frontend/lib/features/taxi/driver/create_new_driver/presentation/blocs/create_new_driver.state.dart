part of 'create_new_driver.bloc.dart';

@freezed
sealed class CreateNewDriverState with _$CreateNewDriverState {
  const factory CreateNewDriverState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverDetails> driverDetailsState,
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverDocuments> driverDocumentsState,
    @Default(ApiResponse.initial()) ApiResponse<Query$services> servicesState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$createDriver> createDriverState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$setEnabledServices> setEnabledServicesState,
    String? selectedServiceCategoryId,
    @Default([]) List<String> selectedServiceIds,
    CreateNewDriverDocumentsModel? driverDocuments,
    @Default(0) int stepperCurrentIndex,
    Enum$DeliveryPackageSize? deliveryPackageSize,
    @Default(true) bool canDeliver,

    // Update fields
    Fragment$Media? profileImage,
    String? firstName,
    String? lastName,
    String? email,
    required (String, String?) phoneNumber,
    Enum$Gender? gender,
    Fragment$fleetListItem? fleet,
    Fragment$vehicleModel? carModel,
    Fragment$vehicleColor? carColor,
    int? carProductionYear,
    String? carPlateNumber,
    String? accountNumber,
    String? bankName,
    String? bankRoutingNumber,
    String? bankSwift,
    String? password,
    String? address,

    required GlobalKey<FormState> formKeyDriverDetails,
  }) = _CreateNewDriverState;

  // initial state
  factory CreateNewDriverState.initial() {
    return CreateNewDriverState(
      formKeyDriverDetails: GlobalKey<FormState>(),
      phoneNumber: (Env.defaultCountry.iso2CountryCode, null),
    );
  }

  const CreateNewDriverState._();

  List<Fragment$taxiPricingListItem> get services =>
      servicesState.data?.serviceCategories
          .firstWhereOrNull((e) => e.id == selectedServiceCategoryId)
          ?.services ??
      [];
}
