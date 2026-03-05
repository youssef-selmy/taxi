part of 'shop_detail.cubit.dart';

@freezed
sealed class ShopDetailState with _$ShopDetailState {
  const factory ShopDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$shopDetail> shopDetailState,
    String? shopId,
    String? shopName,
    String? description,
    String? email,
    required (String, String?) mobileNumber,
    String? address,
    @Default([]) List<Fragment$Media> images,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerEmail,
    required (String, String?) ownerPhoneNumber,
    Fragment$Coordinate? coordinate,
    Enum$Gender? ownerGender,
    @Default([]) List<Input$WeekdayScheduleInput> openHours,
  }) = _ShopDetailState;

  // init state
  factory ShopDetailState.initial() => ShopDetailState(
    ownerPhoneNumber: (Env.defaultCountry.iso2CountryCode, null),
    mobileNumber: (Env.defaultCountry.iso2CountryCode, null),
  );
}
