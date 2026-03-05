import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/region_details_repository.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/regions_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'region_details.state.dart';
part 'region_details.cubit.freezed.dart';

@injectable
class RegionDetailsBloc extends Cubit<RegionDetailsState> {
  final RegionDetailsRepository _regionDetailsRepository =
      locator<RegionDetailsRepository>();
  final RegionsRepository _regionsRepository = locator<RegionsRepository>();

  RegionDetailsBloc() : super(RegionDetailsState.initial());

  void onStarted({required String? regionId}) {
    _getRegionCategories();
    if (regionId != null) {
      emit(
        RegionDetailsState.initial().copyWith(
          regionId: regionId,
          region: ApiResponse.loading(),
        ),
      );
      _getRegion();
    } else {
      emit(
        RegionDetailsState.initial().copyWith(
          regionId: null,
          region: ApiResponse.loaded(null),
        ),
      );
    }
  }

  Future<void> _getRegionCategories() async {
    final result = await _regionsRepository.getRegionCategories();
    final networkState = result;
    emit(state.copyWith(regionCategories: networkState.data ?? []));
  }

  Future<void> _getRegion() async {
    final regionId = state.regionId;
    final region = await _regionDetailsRepository.getRegion(
      regionId: regionId!,
    );
    emit(
      state.copyWith(
        region: region,
        location: [
          region.data?.location.firstOrNull
                  ?.map((e) => e.toPointInput())
                  .toList() ??
              [],
        ],
        currency: region.data?.currency ?? Env.defaultCurrency,
        name: region.data?.name,
        regionCategoryId: region.data?.categoryId,
      ),
    );
  }

  void createRegion() async {
    final result = await _regionDetailsRepository.createRegion(
      input: state.toCreateInput,
    );
    emit(state.copyWith(networkStateSave: result));
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  void updateRegion() async {
    final result = await _regionDetailsRepository.updateRegion(
      id: state.regionId!,
      input: state.toUpdateInput,
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void onLocationChanged(List<Input$PointInput> pointInputList) {
    emit(state.copyWith(location: [pointInputList]));
  }

  void onCurrencyChanged(String? p0) {
    emit(state.copyWith(currency: p0!));
  }

  void onNameChanged(String p0) {
    emit(state.copyWith(name: p0));
  }

  Future<void> onChangeHideStatus() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final region = await _regionDetailsRepository.updateRegion(
      id: state.regionId!,
      input: Input$UpdateRegionInput(
        enabled: state.region.data?.enabled == true ? false : true,
      ),
    );
    emit(
      state.copyWith(
        region: region,
        networkStateSave: const ApiResponse.initial(),
      ),
    );
  }

  void onDelete() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _regionDetailsRepository.deleteRegion(state.regionId!);
    emit(state.copyWith(networkStateSave: result));
  }

  void onRegionCategoryChanged(String? p0) {
    emit(state.copyWith(regionCategoryId: p0));
  }
}
