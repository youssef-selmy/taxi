import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/region_category_details_repository.dart';

part 'region_category_details.state.dart';
part 'region_category_details.cubit.freezed.dart';

class RegionCategoryDetailsBloc extends Cubit<RegionCategoryDetailsState> {
  final RegionCategoryDetailsRepository _regionCategoryDetailsRepository =
      locator<RegionCategoryDetailsRepository>();

  RegionCategoryDetailsBloc()
    : super(
        RegionCategoryDetailsState.initial().copyWith(
          regionCategory: const ApiResponse.initial(),
          networkStateSave: const ApiResponse.initial(),
        ),
      );

  void onStarted({required String? regionCategoryId}) {
    if (regionCategoryId != null) {
      emit(
        RegionCategoryDetailsState.initial().copyWith(
          regionCategory: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
          regionCategoryId: regionCategoryId,
        ),
      );
      _getRegionCategory();
    } else {
      emit(
        RegionCategoryDetailsState.initial().copyWith(
          regionCategory: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
  }

  void onSaved() {
    if (state.regionCategoryId == null) {
      _createRegionCategory();
    } else {
      _updateRegionCategory();
    }
  }

  void _createRegionCategory() async {
    final result = await _regionCategoryDetailsRepository.createRegionCategory(
      name: state.name!,
      currency: state.currency,
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void _updateRegionCategory() async {
    final result = await _regionCategoryDetailsRepository.updateRegionCategory(
      id: state.regionCategoryId!,
      name: state.name!,
      currency: state.currency,
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void deleteRegionCategory(String regionCategoryId) async {
    final result = await _regionCategoryDetailsRepository.deleteRegionCategory(
      regionCategoryId,
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void regionCurrencyChanged(String? p1) {
    emit(state.copyWith(currency: p1!));
  }

  void regionNameChanged(String p1) {
    emit(state.copyWith(name: p1));
  }

  void _getRegionCategory() async {
    final regionCategoryId = state.regionCategoryId;
    emit(state.copyWith(regionCategory: const ApiResponse.loading()));
    final regionCategory = await _regionCategoryDetailsRepository
        .getRegionCategory(regionCategoryId: regionCategoryId!);
    final networkState = regionCategory;
    emit(
      state.copyWith(
        regionCategory: networkState,
        currency: networkState.data?.currency ?? Env.defaultCurrency,
        name: networkState.data?.name,
      ),
    );
  }
}
