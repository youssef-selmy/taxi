import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/pricing.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_option_repository.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'pricing_details.state.dart';
part 'pricing_details.cubit.freezed.dart';

class PricingDetailsBloc extends Cubit<PricingDetailsState> {
  final PricingRepository _pricingRepository = locator<PricingRepository>();
  final PricingOptionRepository _pricingOptionRepository =
      locator<PricingOptionRepository>();

  PricingDetailsBloc() : super(PricingDetailsState());

  void onStarted({required String? pricingId}) {
    if (pricingId != null) {
      emit(
        PricingDetailsState(
          remoteData: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
          pricingId: pricingId,
        ),
      );
      _getPricing();
    } else {
      emit(
        PricingDetailsState(
          remoteData: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
    _fetchFieldOptions();
  }

  void refreshOptions() {
    _fetchOptions();
  }

  void _getPricing() async {
    final pricing = await _pricingRepository.getById(id: state.pricingId!);
    final networkState = pricing;
    final service = networkState.data?.service;
    emit(
      state.copyWith(
        remoteData: networkState,
        name: service?.name,
        categoryId: service?.categoryId,
        baseFare: service?.baseFare ?? 0,
        perHundredMeters: service?.perHundredMeters ?? 0,
        perMinuteDrive: service?.perMinuteDrive ?? 0,
        perMinuteWait: service?.perMinuteWait ?? 0,
        prepayPercent: (service?.prepayPercent ?? 0) * 100,
        searchRadius: service?.searchRadius ?? 0,
        maximumDestinationDistance: service?.maximumDestinationDistance ?? 0,
        cancellationDriverShare: service?.cancellationDriverShare ?? 0,
        cancellationTotalFee: service?.cancellationTotalFee ?? 0,
        personCapacity: service?.personCapacity ?? 0,
        providerShareFlat: service?.providerShareFlat ?? 0,
        providerSharePercent: service?.providerSharePercent ?? 0,
        description: service?.description,
        roundingFactor: service?.roundingFactor ?? 0,
        minimumFee: service?.minimumFee ?? 0,
        image: service?.media,
        selectedRegionIds: service?.regions.map((e) => e.id).toList() ?? [],
        orderTypes: service?.orderTypes ?? [],
        paymentMethod:
            service?.paymentMethod ??
            Enum$ServicePaymentMethod.CashCredit,
        twoWayAvailable: service?.twoWayAvailable ?? false,
        displayPriority: service?.displayPriority ?? 0,
        pricingMode: service?.pricingMode ?? Enum$PricingMode.FIXED,
        rangePolicy: service?.rangePolicy ?? Enum$RangePolicy.ENFORCE,
        priceRangeMinPercent: (service?.priceRangeMinPercent ?? 0.8) * 100,
        priceRangeMaxPercent: (service?.priceRangeMaxPercent ?? 1.5) * 100,
        serviceOptionIds: service?.options.map((e) => e.id).toList() ?? [],
        timeMultipliers: service?.timeToInput() ?? [],
        distanceMultipliers: service?.distanceToInput() ?? [],
        weekdayMultipliers: service?.weekDayToInput() ?? [],
        dateRangeMultipliers: service?.dateRangeToInput() ?? [],
      ),
    );
  }

  void _fetchFieldOptions() async {
    final result = await _pricingRepository.getFieldOptions();
    emit(
      state.copyWith(
        categories: result.data?.serviceCategories ?? [],
        options: result.data?.serviceOptions ?? [],
        regions: result.data?.regions.nodes ?? [],
      ),
    );
  }

  void onSaved() {
    if (state.pricingId == null) {
      _createPricing();
    } else {
      _updatePricing();
    }
  }

  void _createPricing() async {
    final result = await _pricingRepository.create(
      input: state.toInput,
      regionIds: state.selectedRegionIds,
      optionIds: state.serviceOptionIds,
    );
    emit(state.copyWith(networkStateSave: result));
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  void _updatePricing() async {
    final result = await _pricingRepository.update(
      id: state.pricingId!,
      input: state.toInput,
      regionIds: state.selectedRegionIds,
      optionIds: state.serviceOptionIds,
    );
    emit(state.copyWith(networkStateSave: result));
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  void onNameChanged(String name) => emit(state.copyWith(name: name));

  void onCategoryIdChanged(String? categoryId) =>
      emit(state.copyWith(categoryId: categoryId));

  void onBaseFareChanged(double? baseFare) =>
      emit(state.copyWith(baseFare: baseFare ?? 0));

  void onPerHundredMetersChanged(double? perHundredMeters) =>
      emit(state.copyWith(perHundredMeters: perHundredMeters ?? 0));

  void onPerMinuteDriveChanged(double? perMinuteDrive) =>
      emit(state.copyWith(perMinuteDrive: perMinuteDrive ?? 0));

  void onPerMinuteWaitChanged(double? perMinuteWait) =>
      emit(state.copyWith(perMinuteWait: perMinuteWait ?? 0));

  void onPrepayPercentChanged(double? prepayPercent) =>
      emit(state.copyWith(prepayPercent: prepayPercent ?? 0));

  void onSearchRadiusChanged(int? searchRadius) =>
      emit(state.copyWith(searchRadius: searchRadius ?? 0));

  void onMaximumDestinationDistanceChanged(int? maximumDestinationDistance) =>
      emit(
        state.copyWith(
          maximumDestinationDistance: maximumDestinationDistance ?? 0,
        ),
      );

  void onCancellationDriverShareChanged(double? cancellationDriverShare) =>
      emit(
        state.copyWith(cancellationDriverShare: cancellationDriverShare ?? 0),
      );

  void onCancellationTotalFeeChanged(double? cancellationTotalFee) =>
      emit(state.copyWith(cancellationTotalFee: cancellationTotalFee ?? 0));

  void onPersonCapacityChanged(int? personCapacity) =>
      emit(state.copyWith(personCapacity: personCapacity));

  void onProviderShareFlatChanged(double? providerShareFlat) =>
      emit(state.copyWith(providerShareFlat: providerShareFlat ?? 0));

  void onProviderSharePercentChanged(int? providerSharePercent) =>
      emit(state.copyWith(providerSharePercent: providerSharePercent ?? 0));

  void onDescriptionChanged(String description) =>
      emit(state.copyWith(description: description));

  void onRoundingFactorChanged(double? roundingFactor) =>
      emit(state.copyWith(roundingFactor: roundingFactor ?? 0));

  void onMinimumFeeChanged(double? minimumFee) =>
      emit(state.copyWith(minimumFee: minimumFee ?? 0));

  void onTwoWayAvailableChanged(bool twoWayAvailable) =>
      emit(state.copyWith(twoWayAvailable: twoWayAvailable));

  void onTimeMultipliersChanged(
    List<Input$TimeMultiplierInput> timeMultipliers,
  ) => emit(state.copyWith(timeMultipliers: timeMultipliers));

  void onDistanceMultipliersChanged(
    List<Input$DistanceMultiplierInput> distanceMultipliers,
  ) => emit(state.copyWith(distanceMultipliers: distanceMultipliers));

  void onWeekdayMultipliersChanged(
    List<Input$WeekdayMultiplierInput> weekdayMultipliers,
  ) => emit(state.copyWith(weekdayMultipliers: weekdayMultipliers));

  void onDateRangeMultipliersChanged(
    List<Input$DateRangeMultiplierInput> dateRangeMultipliers,
  ) => emit(state.copyWith(dateRangeMultipliers: dateRangeMultipliers));

  void onDistanceMultiplierAdded(Input$DistanceMultiplierInput dialogResult) {
    final distanceMultipliers = List<Input$DistanceMultiplierInput>.from(
      state.distanceMultipliers,
    );
    distanceMultipliers.add(dialogResult);
    emit(state.copyWith(distanceMultipliers: distanceMultipliers));
  }

  void onDistanceMultiplierRemoved(Input$DistanceMultiplierInput e) {
    final distanceMultipliers = List<Input$DistanceMultiplierInput>.from(
      state.distanceMultipliers,
    );
    distanceMultipliers.remove(e);
    emit(state.copyWith(distanceMultipliers: distanceMultipliers));
  }

  void onWeekdayMultiplierAdded(Input$WeekdayMultiplierInput e) {
    final weekdayMultipliers = List<Input$WeekdayMultiplierInput>.from(
      state.weekdayMultipliers,
    );
    weekdayMultipliers.add(e);
    emit(state.copyWith(weekdayMultipliers: weekdayMultipliers));
  }

  void onWeekdayMultiplierRemoved(Input$WeekdayMultiplierInput e) {
    final weekdayMultipliers = List<Input$WeekdayMultiplierInput>.from(
      state.weekdayMultipliers,
    );
    weekdayMultipliers.remove(e);
    emit(state.copyWith(weekdayMultipliers: weekdayMultipliers));
  }

  void onTimeMultiplierAdded(Input$TimeMultiplierInput dialogResult) {
    final timeMultipliers = List<Input$TimeMultiplierInput>.from(
      state.timeMultipliers,
    );
    timeMultipliers.add(dialogResult);
    emit(state.copyWith(timeMultipliers: timeMultipliers));
  }

  void onTimeMultiplierRemoved(Input$TimeMultiplierInput e) {
    final timeMultipliers = List<Input$TimeMultiplierInput>.from(
      state.timeMultipliers,
    );
    timeMultipliers.remove(e);
    emit(state.copyWith(timeMultipliers: timeMultipliers));
  }

  void onDateRangeMultiplierAdded(Input$DateRangeMultiplierInput dialogResult) {
    final dateRangeMultipliers = List<Input$DateRangeMultiplierInput>.from(
      state.dateRangeMultipliers,
    );
    dateRangeMultipliers.add(dialogResult);
    emit(state.copyWith(dateRangeMultipliers: dateRangeMultipliers));
  }

  void onDateRangeMultiplierRemoved(Input$DateRangeMultiplierInput e) {
    final dateRangeMultipliers = List<Input$DateRangeMultiplierInput>.from(
      state.dateRangeMultipliers,
    );
    dateRangeMultipliers.remove(e);
    emit(state.copyWith(dateRangeMultipliers: dateRangeMultipliers));
  }

  void onServiceOptionRemoved(Fragment$taxiOrderOption e) async {
    await _pricingOptionRepository.delete(id: e.id);
    _fetchOptions();
  }

  void _fetchOptions() async {
    final result = await _pricingOptionRepository.getAll();
    emit(state.copyWith(options: result.data ?? []));
  }

  void _onServiceOptionUnselected(Fragment$taxiOrderOption e) {
    final serviceOptionIds = List<String>.from(state.serviceOptionIds);
    serviceOptionIds.remove(e.id);
    emit(state.copyWith(serviceOptionIds: serviceOptionIds));
  }

  void _onServiceOptionSelected(Fragment$taxiOrderOption e) {
    final serviceOptionIds = List<String>.from(state.serviceOptionIds);
    serviceOptionIds.add(e.id);
    emit(state.copyWith(serviceOptionIds: serviceOptionIds));
  }

  void onServiceOptionSelected(Fragment$taxiOrderOption e, bool? selected) {
    if (selected == false) {
      _onServiceOptionUnselected(e);
    } else {
      _onServiceOptionSelected(e);
    }
  }

  Future<void> onServiceOptionAdded(
    Input$ServiceOptionInput input$serviceOptionInput,
  ) async {
    await _pricingOptionRepository.create(input: input$serviceOptionInput);
    _fetchOptions();
  }

  void onImageChanged(Fragment$Media? p1) => emit(state.copyWith(image: p1));

  void onOrderTypesChanged(List<Enum$TaxiOrderType>? p1) =>
      emit(state.copyWith(orderTypes: p1));

  void onSelectedRegionsChanged(List<Fragment$regionWithCategory>? regions) =>
      emit(
        state.copyWith(
          selectedRegionIds: regions?.map((e) => e.id).toList() ?? [],
        ),
      );

  void onDisplayPriorityChanged(int i) =>
      emit(state.copyWith(displayPriority: i));

  void onPricingModeChanged(Enum$PricingMode? pricingMode) =>
      emit(state.copyWith(pricingMode: pricingMode ?? Enum$PricingMode.FIXED));

  void onRangePolicyChanged(Enum$RangePolicy? rangePolicy) => emit(
    state.copyWith(rangePolicy: rangePolicy ?? Enum$RangePolicy.ENFORCE),
  );

  void onPriceRangeMinPercentChanged(double? priceRangeMinPercent) =>
      emit(state.copyWith(priceRangeMinPercent: priceRangeMinPercent ?? 80));

  void onPriceRangeMaxPercentChanged(double? priceRangeMaxPercent) =>
      emit(state.copyWith(priceRangeMaxPercent: priceRangeMaxPercent ?? 150));
}
