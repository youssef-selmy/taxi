import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/zone_price.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_category_repository.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'zone_price_list.state.dart';
part 'zone_price_list.cubit.freezed.dart';

class ZonePriceListBloc extends Cubit<ZonePriceListState> {
  final ZonePriceCategoryRepository _zonePriceCategoryRepository =
      locator<ZonePriceCategoryRepository>();
  final ZonePriceRepository _zonePriceRepository =
      locator<ZonePriceRepository>();

  ZonePriceListBloc() : super(ZonePriceListState.initial());

  void onStarted() {
    _getZonePriceCategories();
  }

  Future<void> _getZonePriceCategories() async {
    emit(
      state.copyWith(
        categories: const ApiResponse.loading(),
        zonePrices: const ApiResponse.loading(),
      ),
    );
    final result = await _zonePriceCategoryRepository.getAll();
    final networkState = result;
    emit(
      state.copyWith(
        categories: networkState,
        categoryId: networkState.data?.firstOrNull?.id,
      ),
    );
    _getZonePrices();
  }

  void _getZonePrices() async {
    emit(state.copyWith(zonePrices: const ApiResponse.loading()));
    final zonePrices = await _zonePriceRepository.getAll(
      categoryId: state.categoryId,
      search: state.searchQuery,
    );
    emit(state.copyWith(zonePrices: zonePrices));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: state.paging));
    _getZonePrices();
  }

  void onSearchQueryChanged(String searchQuery) {
    emit(state.copyWith(searchQuery: searchQuery));
    _getZonePrices();
  }

  void onCategoryChanged(String categoryId) {
    emit(state.copyWith(categoryId: categoryId));
    _getZonePrices();
  }
}
