import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_category_repository.dart';

part 'pricing_category_details.state.dart';
part 'pricing_category_details.cubit.freezed.dart';

class PricingCategoryDetailsBloc extends Cubit<PricingCategoryDetailsState> {
  final PricingCategoryRepository _pricingCategoryRepository =
      locator<PricingCategoryRepository>();

  PricingCategoryDetailsBloc()
    : super(
        // ignore: prefer_const_constructors
        PricingCategoryDetailsState(),
      );

  void onStarted({required String? categoryId}) {
    if (categoryId != null) {
      emit(
        PricingCategoryDetailsState(
          remoteData: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
          pricingCategoryId: categoryId,
        ),
      );
      _getPricingCategory();
    } else {
      emit(
        PricingCategoryDetailsState(
          remoteData: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
  }

  void _getPricingCategory() async {
    final result = await _pricingCategoryRepository.getById(
      id: state.pricingCategoryId!,
    );
    emit(state.copyWith(remoteData: result));
  }

  void onSaved() {
    if (state.pricingCategoryId == null) {
      _createPricingCategory();
    } else {
      _updatePricingCategory();
    }
  }

  void _createPricingCategory() async {
    final result = await _pricingCategoryRepository.create(name: state.name!);
    emit(state.copyWith(networkStateSave: result));
  }

  void _updatePricingCategory() async {
    final result = await _pricingCategoryRepository.update(
      id: state.pricingCategoryId!,
      name: state.name!,
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onDeleted() {
    if (state.pricingCategoryId != null) {
      _deletePricingCategory();
    }
  }

  void _deletePricingCategory() async {
    final result = await _pricingCategoryRepository.delete(
      id: state.pricingCategoryId!,
    );
    emit(state.copyWith(networkStateSave: result));
  }
}
