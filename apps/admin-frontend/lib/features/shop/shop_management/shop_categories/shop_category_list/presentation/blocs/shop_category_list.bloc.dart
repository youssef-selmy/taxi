import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_list/data/graphql/shop_category_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_list/data/repositories/shop_category_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_category_list.state.dart';
part 'shop_category_list.bloc.freezed.dart';

@injectable
class ShopCategoryListBloc extends Cubit<ShopCategoryListState> {
  final ShopCategoryListRepository _shopCategoryListRepository =
      locator<ShopCategoryListRepository>();

  ShopCategoryListBloc() : super(ShopCategoryListState());

  void onStarted() {
    _fetchShopCategories();
  }

  void _fetchShopCategories() async {
    emit(state.copyWith(shopCategoriesState: const ApiResponse.loading()));
    final shopCategoriesOrError = await _shopCategoryListRepository
        .getShopCategories(
          paging: state.paging,
          sorting: state.sort,
          filter: Input$ShopCategoryFilter(
            status: state.statusFilter.isEmpty
                ? null
                : Input$ShopCategoryStatusFilterComparison(
                    $in: state.statusFilter,
                  ),
          ),
        );
    final shopCategoriesState = shopCategoriesOrError;
    emit(state.copyWith(shopCategoriesState: shopCategoriesState));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchShopCategories();
  }
}
