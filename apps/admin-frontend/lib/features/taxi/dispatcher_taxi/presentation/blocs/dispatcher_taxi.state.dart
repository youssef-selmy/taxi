part of 'dispatcher_taxi.cubit.dart';

@freezed
sealed class DispatcherTaxiState with _$DispatcherTaxiState {
  const factory DispatcherTaxiState({
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$createTaxiOrder> networkState,
    @Default(0) int currentStep,
    Fragment$CustomerCompact? selectedCustomer,
    Fragment$Place? mapCenter,
    @Default([]) List<Fragment$Address> customerAddresses,
    @Default([]) List<Fragment$Place> locations,
    Fragment$TaxiCalculateFare? fare,
    @Default(0) int selectedServiceCategoryIndex,
    @Default(0) int selectedServiceIndex,
    @Default(false) bool isRoundTrip,
    @Default(0) int waitingTime,
    @Default([]) List<Fragment$taxiOrderOption> rideOptions,
    @Default([]) List<Fragment$DriverLocation> driverLocations,
    Fragment$DriverLocation? selectedDriverLocation,
    DateTime? bookingTime,
    @Default(false) bool isSuccessful,
    MapViewController? selectLocationMapController,
    MapViewController? searchForDriverMapController,
  }) = _DispatcherTaxiState;

  const DispatcherTaxiState._();

  Fragment$TaxiCalculateFare$services? get selectedServiceCategory =>
      fare?.services.elementAtOrNull(selectedServiceCategoryIndex);

  Fragment$TaxiCalculateFare$services$services? get selectedService =>
      selectedServiceCategory?.services.elementAtOrNull(selectedServiceIndex);
}
