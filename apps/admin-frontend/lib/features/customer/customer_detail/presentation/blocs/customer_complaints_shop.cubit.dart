import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_complaints_shop_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'customer_complaints_shop.state.dart';
part 'customer_complaints_shop.cubit.freezed.dart';

class CustomerComplaintsShopCubit extends Cubit<CustomerComplaintsShopState> {
  final CustomerComplaintsShopRepository _customerComplaintsShopRepository =
      locator<CustomerComplaintsShopRepository>();

  CustomerComplaintsShopCubit() : super(const CustomerComplaintsShopState());

  void onStarted({required String customerId}) {
    emit(state.copyWith(customerId: customerId));
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    emit(state.copyWith(complaintsResponse: const ApiResponse.loading()));
    final complaintsResponse = await _customerComplaintsShopRepository
        .getCustomerComplaintsShop(
          paging: state.paging,
          sorting: state.sorting,
          filter: Input$ShopSupportRequestFilter(
            status: state.filterStatus.isEmpty
                ? null
                : Input$ComplaintStatusFilterComparison(
                    $in: state.filterStatus,
                  ),
            requestedByShop: Input$BooleanFieldComparison($is: false),
            order: Input$ShopSupportRequestFilterShopOrderFilter(
              customerId: Input$IDFilterComparison(eq: state.customerId),
            ),
          ),
        );
    emit(state.copyWith(complaintsResponse: complaintsResponse));
  }

  void onStatusFilterChanged(List<Enum$ComplaintStatus> p1) {
    emit(state.copyWith(filterStatus: p1));
    _fetchComplaints();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchComplaints();
  }

  void onSortingChanged(List<Input$ShopSupportRequestSort> p1) {
    emit(state.copyWith(sorting: p1));
    _fetchComplaints();
  }
}
