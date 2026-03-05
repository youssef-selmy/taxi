part of 'park_spot_create.cubit.dart';

@freezed
sealed class ParkSpotCreateState with _$ParkSpotCreateState {
  const factory ParkSpotCreateState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$parkSpotDetail?> parkSpotState,
    String? parkSpotId,
    Enum$ParkSpotType? type,
    String? name,
    String? description,
    String? address,
    String? phoneNumber,
    @Default(0) int carSpaces,
    @Default(0) int bikeSpaces,
    @Default(0) int truckSpaces,
    double? carPrice,
    double? bikePrice,
    double? truckPrice,
    Enum$ParkSpotCarSize? carSize,
    @Default([]) List<Enum$ParkSpotFacility> facilities,
    String? currency,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerEmail,
    required (String, String?) ownerPhoneNumber,
    Enum$Gender? ownerGender,
    Fragment$Coordinate? location,
    @Default([]) List<Input$WeekdayScheduleInput> openHours,
    @Default([]) List<Fragment$Media> images,
    @Default(0) int wizardStep,
    @Default(ApiResponseInitial()) ApiResponse<void> saveState,
    required PageController pageController,
  }) = _ParkSpotCreateState;

  const ParkSpotCreateState._();

  // initial state
  factory ParkSpotCreateState.initial() => ParkSpotCreateState(
    pageController: PageController(),
    ownerPhoneNumber: (Env.defaultCountry.iso2CountryCode, null),
  );

  Input$CreateParkSpotInput get toCreateInput => Input$CreateParkSpotInput(
    type: type!,
    name: name!,
    description: description!,
    address: address!,
    phoneNumber: phoneNumber!,
    carSpaces: carSpaces,
    bikeSpaces: bikeSpaces,
    truckSpaces: truckSpaces,
    carPrice: carPrice!,
    bikePrice: bikePrice!,
    truckPrice: truckPrice!,
    ownerFirstName: ownerFirstName!,
    ownerLastName: ownerLastName!,
    ownerEmail: ownerEmail!,
    ownerPhoneNumber: ownerPhoneNumber.$2!,
    ownerGender: ownerGender!,
    location: location!.toPointInput(),
    carSize: carSize!,
    weekdaySchedule: openHours,
    facilities: facilities,
    imageIds: images.map((e) => e.id).toList(),
  );
}
