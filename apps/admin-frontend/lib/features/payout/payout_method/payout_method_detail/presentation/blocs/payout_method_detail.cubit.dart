import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_detail/data/repositories/payout_method_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'payout_method_detail.state.dart';
part 'payout_method_detail.cubit.freezed.dart';

class PayoutMethodDetailBloc extends Cubit<PayoutMethodDetailState> {
  final PayoutMethodDetailRepository _payoutMethodDetailRepository =
      locator<PayoutMethodDetailRepository>();

  PayoutMethodDetailBloc() : super(PayoutMethodDetailState.initial());

  void onStarted({required String? id}) {
    if (id != null) {
      emit(PayoutMethodDetailState.initial().copyWith(id: id));
      _fetchPayoutMethod();
    } else {
      emit(
        PayoutMethodDetailState.initial().copyWith(
          payoutMethodState: const ApiResponse.loaded(null),
        ),
      );
    }
  }

  void _fetchPayoutMethod() async {
    final payoutMethodOrError = await _payoutMethodDetailRepository
        .getPayoutMethod(id: state.id!);
    emit(
      state.copyWith(
        currency: payoutMethodOrError.data?.currency ?? Env.defaultCurrency,
        payoutMethodState: payoutMethodOrError,
        name: payoutMethodOrError.data?.name,
        type: payoutMethodOrError.data?.type,
        media: payoutMethodOrError.data?.media,
        saltKey: payoutMethodOrError.data?.saltKey,
        privateKey: payoutMethodOrError.data?.privateKey,
        publicKey: payoutMethodOrError.data?.publicKey,
        description: payoutMethodOrError.data?.description,
      ),
    );
  }

  void _createPayoutMethod() async {
    final payoutMethodOrError = await _payoutMethodDetailRepository
        .createPayoutMethod(input: state.toInput);
    final payoutMethodState = payoutMethodOrError;
    emit(state.copyWith(saveState: payoutMethodState));
  }

  void _updatePayoutMethod() async {
    final payoutMethodOrError = await _payoutMethodDetailRepository
        .updatePayoutMethod(id: state.id!, update: state.toInput);
    final payoutMethodState = payoutMethodOrError;
    emit(state.copyWith(saveState: payoutMethodState));
  }

  void submitPayoutMethod() {
    if (state.id == null) {
      _createPayoutMethod();
    } else {
      _updatePayoutMethod();
    }
  }

  void onDeletePayoutMethod() async {
    final deleteResultOrError = await _payoutMethodDetailRepository
        .deletePayoutMethod(id: state.id!);
    final deleteState = deleteResultOrError;
    emit(state.copyWith(saveState: deleteState));
  }

  void onNameChanged(String name) => emit(state.copyWith(name: name));

  void onSaltKeyChanged(String saltKey) =>
      emit(state.copyWith(saltKey: saltKey));

  void onMerchantIdChanged(String merchantId) =>
      emit(state.copyWith(merchantId: merchantId));

  void onCurrencyChanged(String? currency) =>
      emit(state.copyWith(currency: currency!));

  void onPrivateKeyChanged(String privateKey) =>
      emit(state.copyWith(privateKey: privateKey));

  void onPublicKeyChanged(String publicKey) =>
      emit(state.copyWith(publicKey: publicKey));

  void onDescriptionChanged(String description) =>
      emit(state.copyWith(description: description));

  void onTypeChanged(Enum$PayoutMethodType? type) =>
      emit(state.copyWith(type: type));

  void onMediaChanged(Fragment$Media? media) =>
      emit(state.copyWith(media: media));
}
