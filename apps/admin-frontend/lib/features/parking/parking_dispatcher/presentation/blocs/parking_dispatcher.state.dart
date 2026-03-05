part of 'parking_dispatcher.cubit.dart';

@freezed
sealed class ParkingDispatcherState with _$ParkingDispatcherState {
  factory ParkingDispatcherState({
    @Default(ApiResponse.initial()) ApiResponse<String> networkState,
    @Default(0) int currentStep,
    @Default([]) List<Fragment$Address> customerAddresses,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$customerWallet>> customerWallets,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$parkSpotDetail>> parkings,
    @Default(Enum$ParkSpotVehicleType.Car) Enum$ParkSpotVehicleType vehicleType,
    Fragment$CustomerCompact? selectedCustomer,
    Fragment$Place? selectedDestination,
    required DateTime selectedDate,
    required TimeOfDay fromTime,
    required TimeOfDay toTime,
    Fragment$parkSpotDetail? selectedParking,
    PaymentMethodEntity? paymentMethod,
    @Default(false) bool isSuccessful,
  }) = _ParkingDispatcherState;

  const ParkingDispatcherState._();

  Fragment$customerWallet? get mainWallet => customerWallets.data?.firstOrNull;

  DateTime get fromDateTime => DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    fromTime.hour,
    fromTime.minute,
  );

  DateTime get toDateTime => DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    toTime.hour,
    toTime.minute,
  );

  (DateTime, DateTime) get enterExitTime => (fromDateTime, toDateTime);
}
