import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_delivery_region.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_delivery_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail_upsert_delivery_dialog.state.dart';
part 'shop_detail_upsert_delivery_dialog.bloc.freezed.dart';

class ShopDetailUpsertDeliveryDialogBloc
    extends Cubit<ShopDetailUpsertDeliveryDialogState> {
  final ShopDetailDeliveryRepository _deliveryRepository =
      locator<ShopDetailDeliveryRepository>();

  ShopDetailUpsertDeliveryDialogBloc()
    : super(ShopDetailUpsertDeliveryDialogState());

  void onStarted({required String shopId, required String? regionId}) {
    emit(
      state.copyWith(
        shopId: shopId,
        regionId: regionId,
        deliveryZoneState: regionId == null
            ? ApiResponse.loaded(null)
            : ApiResponse.loading(),
      ),
    );
    if (regionId != null) {
      _fetchDeliveryZone();
    }
  }

  Future<void> _fetchDeliveryZone() async {
    emit(state.copyWith(deliveryZoneState: ApiResponse.loading()));
    final deliveryZoneOrError = await _deliveryRepository.getShopDeliveryRegion(
      regionId: state.regionId!,
    );
    final deliveryZoneState = deliveryZoneOrError;
    emit(state.copyWith(deliveryZoneState: deliveryZoneState));
  }

  void onSubmit() {
    if (state.regionId != null) {
      _updateDeliveryZone();
    } else {
      _createDeliveryZone();
    }
  }

  void onNameChanged(String p1) => emit(state.copyWith(name: p1));

  void _updateDeliveryZone() async {
    final deliveryZoneOrError = await _deliveryRepository
        .updateShopDeliveryRegion(
          regionId: state.regionId!,
          input: state.toUpdateInput,
        );
    final deliveryZoneState = deliveryZoneOrError;
    emit(state.copyWith(submitState: deliveryZoneState));
  }

  void _createDeliveryZone() async {
    final deliveryZoneOrError = await _deliveryRepository
        .createShopDeliveryRegion(input: state.toCreateInput);
    final deliveryZoneState = deliveryZoneOrError;
    emit(state.copyWith(submitState: deliveryZoneState));
  }

  void onPolylineDrawn(List<Input$PointInput>? p1) {
    emit(state.copyWith(location: p1 ?? []));
  }

  void onDeliveryFeeChanged(double? p1) {
    emit(state.copyWith(deliveryFee: p1 ?? 0));
  }

  void onMinDeliveryTimeChanged(int? p1) {
    emit(state.copyWith(minDeliveryTimeMinutes: p1 ?? 0));
  }

  void onMaxDeliveryTimeChanged(int? p1) {
    emit(state.copyWith(maxDeliveryTimeMinutes: p1 ?? 0));
  }

  void onMinimumOrderAmountChanged(double? p1) {
    emit(state.copyWith(minimumOrderAmount: p1 ?? 0));
  }
}
