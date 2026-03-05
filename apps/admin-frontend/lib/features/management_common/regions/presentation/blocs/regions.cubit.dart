import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/regions/data/graphql/regions.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/regions_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'regions.state.dart';
part 'regions.cubit.freezed.dart';

class RegionsBloc extends Cubit<RegionsState> {
  final RegionsRepository _regionsRepository = locator<RegionsRepository>();

  RegionsBloc()
    : super(
        RegionsState(
          regionCategories: const ApiResponse.initial(),
          regions: const ApiResponse.initial(),
        ),
      );

  void onStarted() {
    _getRegionCategories();
  }

  Future<void> _getRegionCategories() async {
    emit(
      state.copyWith(
        regionCategories: const ApiResponse.loading(),
        regions: const ApiResponse.loading(),
      ),
    );
    final result = await _regionsRepository.getRegionCategories();
    final networkState = result;
    emit(state.copyWith(regionCategories: networkState, categoryId: null));
    _getRegions();
  }

  void _getRegions() async {
    emit(state.copyWith(regions: const ApiResponse.loading()));
    final regions = await _regionsRepository.getRegions(
      regionCategoryId: state.categoryId,
      paging: state.paging,
      query: state.searchQuery,
    );
    emit(state.copyWith(regions: regions));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _getRegions();
  }

  void onCategoryChanged(String? categoryId) {
    emit(state.copyWith(categoryId: categoryId));
    _getRegions();
  }

  void onSearch(String value) {
    emit(state.copyWith(searchQuery: value));
    _getRegions();
  }
}
