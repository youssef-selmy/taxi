part of 'fleet_detail.cubit.dart';

@freezed
sealed class FleetDetailState with _$FleetDetailState {
  const factory FleetDetailState({
    required ApiResponse<Query$fleetDetails> fleet,
    required ApiResponse<Fragment$fleetDetails> fleetUpdate,
    String? id,
    String? name,
    String? mobileNumber,
    String? userName,
    String? phoneNumber,
    String? address,
    String? password,
    double? commissionSharePercent,
    double? commissionShareFlat,
    double? feeMultiplier,
    String? accountNumber,
    List<Input$PointInput>? exclusivityAreas,
    Fragment$Media? profilePicture,
  }) = _FleetDetailState;

  factory FleetDetailState.initial() => FleetDetailState(
    fleet: const ApiResponse.initial(),
    fleetUpdate: const ApiResponse.initial(),
  );
}
