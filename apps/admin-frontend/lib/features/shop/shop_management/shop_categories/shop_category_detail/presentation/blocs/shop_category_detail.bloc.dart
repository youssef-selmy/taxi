import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_detail/data/repositories/shop_category_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_category_detail.state.dart';
part 'shop_category_detail.bloc.freezed.dart';

@injectable
class ShopCategoryDetailBloc extends Cubit<ShopCategoryDetailState> {
  final ShopCategoryDetailRepository _shopCategoryDetailRepository =
      locator<ShopCategoryDetailRepository>();

  ShopCategoryDetailBloc() : super(const ShopCategoryDetailState());

  void onStarted({required String? id}) async {
    if (id != null) {
      _getShopCategory(id);
    } else {
      emit(
        state.copyWith(
          shopCategoryState: const ApiResponse.loaded(null),
          shopCategoryId: null,
          name: null,
          description: null,
          image: null,
          status: null,
        ),
      );
    }
  }

  void _getShopCategory(String id) async {
    emit(state.copyWith(shopCategoryState: const ApiResponse.loading()));
    final shopCategoryOrError = await _shopCategoryDetailRepository
        .getShopCategory(id);
    emit(
      state.copyWith(
        shopCategoryState: shopCategoryOrError,
        shopCategoryId: id,
        name: shopCategoryOrError.data?.name,
        image: shopCategoryOrError.data?.image,
        status: shopCategoryOrError.data?.status,
      ),
    );
  }

  void onNameChanged(String name) => emit(state.copyWith(name: name));

  void onImageChanged(Fragment$Media? image) =>
      emit(state.copyWith(image: image));

  void onSubmit() async {
    if (state.shopCategoryId == null) {
      _createShopCategory();
    } else {
      _updateShopCategory();
    }
  }

  void _createShopCategory() async {
    final shopCategoryOrError = await _shopCategoryDetailRepository
        .createShopCategory(
          input: Input$CreateShopCategoryInput(
            name: state.name!,
            description: state.description,
            imageId: state.image!.id,
          ),
        );
    emit(state.copyWith(submitState: shopCategoryOrError));
  }

  void _updateShopCategory() async {
    final shopCategoryOrError = await _shopCategoryDetailRepository
        .updateShopCategory(
          id: state.shopCategoryId!,
          input: Input$UpdateShopCategoryInput(
            name: state.name,
            description: state.description,
            imageId: state.image!.id,
          ),
        );
    emit(state.copyWith(submitState: shopCategoryOrError));
  }

  void onDelete() {
    if (state.shopCategoryId != null) {
      _deleteShopCategory(state.shopCategoryId!);
    }
  }

  void _deleteShopCategory(String id) async {
    emit(state.copyWith(submitState: const ApiResponse.loading()));
    final deleteSubmitOrError = await _shopCategoryDetailRepository
        .deleteShopCategory(id);
    emit(state.copyWith(submitState: deleteSubmitOrError));
  }

  void onEnable() {
    _updateStatus(Enum$ShopCategoryStatus.Enabled);
  }

  void onDisable() async {
    _updateStatus(Enum$ShopCategoryStatus.Disabled);
  }

  void _updateStatus(Enum$ShopCategoryStatus status) async {
    emit(state.copyWith(submitState: const ApiResponse.loading()));
    final shopCategoryOrError = await _shopCategoryDetailRepository
        .updateShopCategory(
          id: state.shopCategoryId!,
          input: Input$UpdateShopCategoryInput(status: status),
        );
    emit(
      state.copyWith(
        submitState: shopCategoryOrError,
        shopCategoryState: shopCategoryOrError,
        status: shopCategoryOrError.data?.status,
      ),
    );
  }

  void onDescriptionChanged(String p1) {
    emit(state.copyWith(description: p1));
  }
}
