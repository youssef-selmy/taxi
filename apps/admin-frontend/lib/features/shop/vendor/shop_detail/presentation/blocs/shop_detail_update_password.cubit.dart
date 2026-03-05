import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_update_password_repository.dart';

part 'shop_detail_update_password.state.dart';
part 'shop_detail_update_password.cubit.freezed.dart';

class ShopDetailUpdatePasswordBloc
    extends Cubit<ShopDetailUpdatePasswordState> {
  final ShopDetailUpdatePasswordRepository _shopDetailUpdatePasswordRepository =
      locator<ShopDetailUpdatePasswordRepository>();

  ShopDetailUpdatePasswordBloc() : super(const ShopDetailUpdatePasswordState());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void onUpdatePassword() async {
    emit(state.copyWith(updatePasswordState: ApiResponse.loading()));
    final updatePasswordOrError = await _shopDetailUpdatePasswordRepository
        .updatePassword(shopId: state.shopId!, password: state.password!);
    final updatePasswordState = updatePasswordOrError;
    emit(state.copyWith(updatePasswordState: updatePasswordState));
  }
}
