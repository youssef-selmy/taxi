import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/data/graphql/vendor_list.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/data/repositories/vendor_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'vendor_list.state.dart';
part 'vendor_list.cubit.freezed.dart';

class VendorListBloc extends Cubit<VendorListState> {
  final VendorListRepository _vendorListRepository =
      locator<VendorListRepository>();

  VendorListBloc() : super(VendorListState());

  void onStarted() {
    _fetchVendorCategories();
  }

  Future<void> _fetchVendorCategories() async {
    emit(state.copyWith(vendorCategoriesState: ApiResponse.loading()));
    final categoriesOrError = await _vendorListRepository.getVendorCategories();
    emit(
      state.copyWith(
        vendorCategoriesState: categoriesOrError,
        selectedShopCategoryId:
            categoriesOrError.data?.shopCategories.nodes.firstOrNull?.id,
      ),
    );
    _fetchVendors();
  }

  Future<void> _fetchVendors() async {
    emit(state.copyWith(vendorsState: ApiResponse.loading()));
    final vendordsOrError = await _vendorListRepository.getVendors(
      paging: state.paging,
      filter: Input$ShopFilter(
        categories: Input$ShopFilterShopCategoryFilter(
          id: Input$IDFilterComparison(eq: state.selectedShopCategoryId!),
        ),
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: "%${state.searchQuery}%"),
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

  void onSortChanged(List<Input$ShopSort> p1) {
    emit(state.copyWith(sorting: p1, paging: null));
    _fetchVendors();
  }

  void onSearchChanged(String p1) {
    emit(state.copyWith(searchQuery: p1, paging: null));
    _fetchVendors();
  }

  void onCategoryTabChanged(String? categoryId) {
    emit(state.copyWith(selectedShopCategoryId: categoryId, paging: null));
    _fetchVendors();
  }
}
