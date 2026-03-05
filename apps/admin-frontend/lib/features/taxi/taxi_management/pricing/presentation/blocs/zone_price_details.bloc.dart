import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_category_repository.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'zone_price_details.state.dart';
part 'zone_price_details.bloc.freezed.dart';

@injectable
class ZonePriceDetailsBloc extends Cubit<ZonePriceDetailsState> {
  final ZonePriceRepository _zonePriceRepository =
      locator<ZonePriceRepository>();
  final ZonePriceCategoryRepository _zonePriceCategoryRepository =
      locator<ZonePriceCategoryRepository>();

  ZonePriceDetailsBloc() : super(ZonePriceDetailsState.initial());

  void onStarted({required String? id}) {
    _getFieldOptions();
    if (id != null) {
      emit(
        ZonePriceDetailsState(
          zonePrice: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
          zonePriceId: id,
        ),
      );
      _getZonePrice();
    } else {
      emit(
        ZonePriceDetailsState(
          zonePrice: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
  }

  Future<void> _getFieldOptions() async {
    final result = await _zonePriceCategoryRepository.getAll();
    final fieldOptions = await _zonePriceRepository.getFieldOptions();
    final networkState = result;
    emit(
      state.copyWith(
        zonePriceCategories: networkState.data ?? [],
        services: fieldOptions.data?.services ?? [],
        fleets: fieldOptions.data?.fleets.nodes.map((e) => e).toList() ?? [],
      ),
    );
  }

  Future<void> _getZonePrice() async {
    final zonePriceId = state.zonePriceId;
    final zonePrice = await _zonePriceRepository.getOne(id: zonePriceId!);
    final networkState = zonePrice;
    final ApiResponse<Fragment$zonePrice> zonePriceState =
        switch (networkState) {
          ApiResponseLoaded(:final data) => ApiResponse.loaded(data.zonePrice),
          ApiResponseInitial() => const ApiResponse.initial(),
          ApiResponseLoading() => const ApiResponse.loading(),
          ApiResponseError(:final message) => ApiResponse.error(message),
        };
    emit(
      state.copyWith(
        zonePrice: zonePriceState,
        name: zonePriceState.data?.name,
        from:
            zonePriceState.data?.from
                .map((e) => e.map((e) => e.toPointInput()).toList())
                .toList() ??
            [],
        to:
            zonePriceState.data?.to
                .map((e) => e.map((e) => e.toPointInput()).toList())
                .toList() ??
            [],
        serviceIds:
            zonePriceState.data?.services.map((e) => e.id).toList() ?? [],
        fleetIds: zonePriceState.data?.fleets.map((e) => e.id).toList() ?? [],
      ),
    );
  }

  void _createZonePrice() async {
    final result = await _zonePriceRepository.create(
      input: state.toCreateInput,
      fleetIds: state.fleetIds,
      serviceIds: state.serviceIds,
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  void _updateZonePrice() async {
    final result = await _zonePriceRepository.update(
      id: state.zonePriceId!,
      input: state.toCreateInput,
      fleetIds: state.fleetIds,
      serviceIds: state.serviceIds,
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  void save() {
    if (state.zonePriceId == null) {
      _createZonePrice();
    } else {
      _updateZonePrice();
    }
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onFromChanged(List<Input$PointInput>? from) {
    emit(state.copyWith(from: from == null ? [] : [from]));
  }

  void onToChanged(List<Input$PointInput>? to) {
    emit(state.copyWith(to: to == null ? [] : [to]));
  }

  void onServiceIdsChanged(List<String> serviceIds) {
    emit(state.copyWith(serviceIds: serviceIds));
  }

  void onFleetIdsChanged(List<String>? fleetIds) {
    emit(state.copyWith(fleetIds: fleetIds ?? []));
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

  void onServiceChanged(List<String>? p1) {
    emit(state.copyWith(serviceIds: p1 ?? []));
  }
}
