part of 'park_spot_detail.cubit.dart';

@freezed
sealed class ParkSpotDetailState with _$ParkSpotDetailState {
  const factory ParkSpotDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$parkSpotDetail> parkSpotDetailState,
    String? parkSpotId,
    String? parkingName,
    String? description,
    String? email,
    String? mobileNumber,
    String? address,
    @Default([]) List<Fragment$Media> images,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerEmail,
    String? ownerPhoneNumber,
    Fragment$Coordinate? coordinate,
    Enum$Gender? ownerGender,
    @Default(0) int carSpaces,
    @Default(0) int bikeSpaces,
    @Default(0) int truckSpaces,
    double? carPrice,
    double? bikePrice,
    double? truckPrice,
    Enum$ParkSpotCarSize? carSize,
    @Default([]) List<Enum$ParkSpotFacility> facilities,
    @Default([]) List<Input$WeekdayScheduleInput> openHours,
  }) = _ParkSpotDetailState;
}
