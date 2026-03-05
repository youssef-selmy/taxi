import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_presets_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_presets.state.dart';
part 'shop_detail_presets.cubit.freezed.dart';

class ShopDetailPresetsBloc extends Cubit<ShopDetailPresetsState> {
  final ShopDetailPresetsRepository _presetsRepository =
      locator<ShopDetailPresetsRepository>();

  ShopDetailPresetsBloc() : super(ShopDetailPresetsState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
    _fetchPresets();
  }

  void _fetchPresets() async {
    emit(state.copyWith(presetsState: ApiResponse.loading()));

    final presetsOrError = await _presetsRepository.getShopPresets(
      filter: Input$ShopItemPresetFilter(
        shopId: Input$IDFilterComparison(eq: state.shopId!),
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: '%${state.searchQuery}%'),
      ),
      sorting: [],
      paging: state.paging,
    );
    final presetsState = presetsOrError;
    emit(state.copyWith(presetsState: presetsState));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchPresets();
  }

  void onSearchQueryChanged(String p1) {
    emit(state.copyWith(searchQuery: p1));
    _fetchPresets();
  }

  void onDeletePressed({required String presetId}) async {
    final deleteOrError = await _presetsRepository.deleteShopItemPreset(
      id: presetId,
    );
    if (deleteOrError.isLoaded) {
      _fetchPresets();
    }
  }
}
