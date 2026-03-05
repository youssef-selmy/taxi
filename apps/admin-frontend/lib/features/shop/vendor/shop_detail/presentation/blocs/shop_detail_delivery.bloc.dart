import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_delivery.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_delivery_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_delivery.state.dart';
part 'shop_detail_delivery.bloc.freezed.dart';

class ShopDetailDeliveryBloc extends Cubit<ShopDetailDeliveryState> {
  final ShopDetailDeliveryRepository _shopDetailDeliveryRepository =
      locator<ShopDetailDeliveryRepository>();

  ShopDetailDeliveryBloc() : super(ShopDetailDeliveryState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId, deliveryRegionsPaging: null));
    _fetchDeliveryRegions();
  }

  Future<void> _fetchDeliveryRegions() async {
    emit(state.copyWith(deliveryRegionsState: const ApiResponse.loading()));
    final deliveryRegionsOrError = await _shopDetailDeliveryRepository
        .getShopDeliveryRegions(
          filter: Input$ShopDeliveryZoneFilter(
            shopId: Input$IDFilterComparison(eq: state.shopId!),
          ),
          paging: state.deliveryRegionsPaging,
          sorting: [],
        );
    final deliveryRegionsState = deliveryRegionsOrError;
    emit(state.copyWith(deliveryRegionsState: deliveryRegionsState));
  }

  void onIsShopDeliveryAvailableChanged(bool p1) {
    emit(state.copyWith(isShopDeliveryAvailable: p1));
  }

  void onIsExpressDeliveryAvailableChanged(bool p1) {
    emit(state.copyWith(isExpressDeliveryAvailable: p1));
  }

  void onExpressDeliveryShopCommissionChanged(int? p1) {
    emit(state.copyWith(expressDeliveryShopCommission: p1 ?? 0));
  }

  void onDeliveryRegionsPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(deliveryRegionsPaging: p1));
    _fetchDeliveryRegions();
  }

  void onDeliveryRegionsSearchQueryChanged(String p1) {
    emit(
      state.copyWith(
        deliveryRegionsSearchQuery: p1,
        deliveryRegionsPaging: null,
      ),
    );
    _fetchDeliveryRegions();
  }

  Future<ApiResponse<void>> onDeleteRegionPressed({
    required String regionId,
  }) async {
    final deleteOrError = await _shopDetailDeliveryRepository
        .deleteShopDeliveryRegion(regionId: regionId);
    if (deleteOrError.isLoaded) {
      _fetchDeliveryRegions();
    }
    return deleteOrError;
  }
}
