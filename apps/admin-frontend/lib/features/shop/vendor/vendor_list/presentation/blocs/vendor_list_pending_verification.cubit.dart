import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/data/graphql/vendor_list.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/data/repositories/vendor_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'vendor_list_pending_verification.state.dart';
part 'vendor_list_pending_verification.cubit.freezed.dart';

class VendorListPendingVerificationBloc
    extends Cubit<VendorListPendingVerificationState> {
  final VendorListRepository _vendorListRepository =
      locator<VendorListRepository>();

  VendorListPendingVerificationBloc()
    : super(VendorListPendingVerificationState());

  void onStarted() {
    _fetchVendors();
  }

  Future<void> _fetchVendors() async {
    emit(state.copyWith(vendorsState: ApiResponse.loading()));
    final vendordsOrError = await _vendorListRepository.getVendors(
      paging: state.paging,
      filter: Input$ShopFilter(
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: "%${state.searchQuery}%"),
        status: Input$ShopStatusFilterComparison(
          eq: Enum$ShopStatus.PendingApproval,
        ),
      ),
      sort: state.sorting,
    );
    final vendorsState = vendordsOrError;
    emit(state.copyWith(vendorsState: vendorsState));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchVendors();
  }
}
