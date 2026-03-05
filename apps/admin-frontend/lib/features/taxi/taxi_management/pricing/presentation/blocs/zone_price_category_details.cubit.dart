import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_category_repository.dart';

part 'zone_price_category_details.state.dart';
part 'zone_price_category_details.cubit.freezed.dart';

class ZonePriceCategoryDetailsBloc
    extends Cubit<ZonePriceCategoryDetailsState> {
  final ZonePriceCategoryRepository _zonePriceCategoryRepository =
      locator<ZonePriceCategoryRepository>();

  ZonePriceCategoryDetailsBloc()
    : super(ZonePriceCategoryDetailsState.initial());

  void onStarted({required String? id}) {
    if (id != null) {
      emit(
        ZonePriceCategoryDetailsState(
          zonePriceCategoryId: id,
          zonePriceCategory: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
      _getZonePriceCategory();
    } else {
      emit(
        ZonePriceCategoryDetailsState(
          zonePriceCategory: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
  }

  Future<void> _getZonePriceCategory() async {
    final zonePriceCategoryId = state.zonePriceCategoryId;
    final zonePriceCategory = await _zonePriceCategoryRepository.getOne(
      id: zonePriceCategoryId!,
    );
    emit(state.copyWith(zonePriceCategory: zonePriceCategory));
  }

  void _updateZonePriceCategory() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _zonePriceCategoryRepository.update(
      id: state.zonePriceCategoryId!,
      name: state.name!,
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void _createZonePriceCategory() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _zonePriceCategoryRepository.create(name: state.name!);
    emit(state.copyWith(networkStateSave: result));
  }

  void onSave() {
    final id = state.zonePriceCategoryId;
    if (id != null) {
      _updateZonePriceCategory();
    } else {
      _createZonePriceCategory();
    }
  }

  void deleteZonePriceCategory({required String id}) async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _zonePriceCategoryRepository.delete(id);
    emit(state.copyWith(networkStateSave: result));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }
}
