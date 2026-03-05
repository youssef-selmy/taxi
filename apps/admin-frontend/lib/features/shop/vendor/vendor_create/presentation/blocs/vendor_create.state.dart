part of 'vendor_create.cubit.dart';

@freezed
sealed class VendorCreateState with _$VendorCreateState {
  const factory VendorCreateState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$shopDetail?> vendorState,
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$shopCategoryCompact>> shopCategoriesState,
    String? vendorId,

    // Form fields
    String? name,
    String? password,
    String? description,
    String? address,
    required (String, String?) phoneNumber,
    String? email,
    Fragment$Media? profileImage,
    @Default([]) List<Fragment$shopCategoryCompact> categories,
    Fragment$Coordinate? location,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerEmail,
    required (String, String?) ownerPhoneNumber,
    Enum$Gender? ownerGender,
    @Default(false) bool isExpressDeliveryAvailable,
    @Default(0) int expressDeliveryShopCommission,
    @Default(false) bool isShopDeliveryAvailable,
    @Default(false) bool isOnlinePaymentAvailable,
    @Default(false) bool isCashPaymentAvailable,

    // Wizard
    @Default(0) int wizardStep,
    @Default(ApiResponseInitial()) ApiResponse<void> saveState,
    required PageController pageController,
  }) = _VendorCreateState;

  const VendorCreateState._();

  // initial state
  factory VendorCreateState.initial() => VendorCreateState(
    pageController: PageController(),
    ownerPhoneNumber: (Env.defaultCountry.iso2CountryCode, null),
    phoneNumber: (Env.defaultCountry.iso2CountryCode, null),
  );

  Input$UpsertShopInput get toInput => Input$UpsertShopInput(
    name: name!,
    password: password!,
    description: description,
    mobileNumber: phoneNumber.toInput(),
    isOnlinePaymentAvailable: isOnlinePaymentAvailable,
    isCashOnDeliveryAvailable: isCashPaymentAvailable,
    isExpressDeliveryAvailable: isExpressDeliveryAvailable,
    expressDeliveryShopCommission: expressDeliveryShopCommission,
    isShopDeliveryAvailable: isShopDeliveryAvailable,
    email: email,
    imageId: profileImage!.id,
    address: address,
    location: location!.toPointInput(),
    weeklySchedule: [],
    ownerInformation: Input$PersonalInfoInput(
      firstName: ownerFirstName!,
      lastName: ownerLastName!,
      email: ownerEmail!,
      mobileNumber: ownerPhoneNumber.toInput(),
      gender: ownerGender!,
    ),
  );
}
