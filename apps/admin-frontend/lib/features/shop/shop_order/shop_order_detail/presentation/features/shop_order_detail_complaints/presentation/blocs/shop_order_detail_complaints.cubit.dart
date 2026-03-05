import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/data/graphql/shop_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/data/repositories/shop_order_detail_complaints_repository.dart';

part 'shop_order_detail_complaints.state.dart';
part 'shop_order_detail_complaints.cubit.freezed.dart';

class ShopOrderDetailComplaintsBloc
    extends Cubit<ShopOrderDetailComplaintsState> {
  final ShopOrderDetailComplaintsRepository
  _shopOrderDetailComplaintRepository =
      locator<ShopOrderDetailComplaintsRepository>();

  ShopOrderDetailComplaintsBloc() : super(ShopOrderDetailComplaintsState());

  void onStarted(String shopOrderId) {
    _fetchComplaintShopOrderDetail(shopOrderId);
  }

  Future<void> _fetchComplaintShopOrderDetail(String shopOrderId) async {
    emit(state.copyWith(shopOrderComplaintsState: const ApiResponse.loading()));

    final complaintsOrError = await _shopOrderDetailComplaintRepository
        .getShopOrderDetailComplaints(orderId: shopOrderId);

    emit(state.copyWith(shopOrderComplaintsState: complaintsOrError));
  }
}
