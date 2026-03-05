import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_category_repository.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'pricing_list.state.dart';
part 'pricing_list.cubit.freezed.dart';

class PricingListBloc extends Cubit<PricingListState> {
  final PricingCategoryRepository _pricingCategoryRepository =
      locator<PricingCategoryRepository>();
  final PricingRepository _pricingRepository = locator<PricingRepository>();

  PricingListBloc() : super(PricingListState.initial());

  void onStarted() {
    _getPricingCategories();
  }

  Future<void> _getPricingCategories() async {
    emit(
      state.copyWith(
        categories: const ApiResponse.loading(),
        pricings: const ApiResponse.loading(),
      ),
    );
    final result = await _pricingCategoryRepository.getAll();
    final networkState = result;
    emit(
      state.copyWith(
        categories: networkState,
        categoryId: networkState.data?.firstOrNull?.id,
      ),
    );
    _getPricings();
  }

  void _getPricings() async {
    emit(state.copyWith(pricings: const ApiResponse.loading()));
    final pricings = await _pricingRepository.getAll(
      categoryId: state.categoryId,
      searchQuery: state.searchQuery,
      paging: state.paging,
    );
    emit(state.copyWith(pricings: pricings));
  }

  void onCategoryChanged(String categoryId) {
    emit(state.copyWith(categoryId: categoryId));
    _getPricings();
  }

  void onSearch(String value) {
    emit(state.copyWith(searchQuery: value));
    _getPricings();
  }

  void onPageChanged(Input$OffsetPaging page) {
    emit(state.copyWith(paging: page));
  }
}
