part of 'add_fleet.cubit.dart';

@freezed
sealed class AddFleetState with _$AddFleetState {
  const factory AddFleetState({
    required ApiResponse<Fragment$fleetDetails> fleet,
    String? id,
    String? name,
    required (String, String?) mobileNumber,
    String? userName,
    required (String, String?) phoneNumber,
    String? address,
    String? password,
    @Default(0) double commissionSharePercent,
    @Default(0) double commissionShareFlat,
    @Default(1) double feeMultiplier,
    String? accountNumber,
    List<List<Input$PointInput>>? exclusivityAreas,
    Fragment$Media? media,
  }) = _AddFleetState;

  factory AddFleetState.initial() => AddFleetState(
    fleet: const ApiResponse.initial(),
    phoneNumber: ('US', null),
    mobileNumber: ('US', null),
  );

  const AddFleetState._();

  (CountryCode, String?) get phoneNumberParsed => phoneNumber.parse();

  (CountryCode, String?) get mobileNumberParsed => mobileNumber.parse();
}
