import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/repositories/payment_gateway_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'payment_gateway_details.state.dart';
part 'payment_gateway_details.cubit.freezed.dart';

class PaymentGatewayDetailsBloc extends Cubit<PaymentGatewayDetailsState> {
  final PaymentGatewayRepository _paymentGatewayRepository =
      locator<PaymentGatewayRepository>();

  PaymentGatewayDetailsBloc() : super(PaymentGatewayDetailsState.initial());

  void onStarted({required String? id}) {
    if (id != null) {
      emit(
        PaymentGatewayDetailsState(
          paymentGatewayId: id,
          paymentGateway: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
      _getPaymentGateway();
    } else {
      emit(
        PaymentGatewayDetailsState(
          paymentGateway: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
  }

  Future<void> _getPaymentGateway() async {
    final paymentGatewayId = state.paymentGatewayId;
    final paymentGateway = await _paymentGatewayRepository.getOne(
      id: paymentGatewayId!,
    );
    final networkState = paymentGateway;
    emit(
      state.copyWith(
        paymentGateway: networkState,
        name: networkState.data?.title,
        privateKey: networkState.data?.privateKey,
        publicKey: networkState.data?.publicKey,
        saltKey: networkState.data?.saltKey,
        merchantId: networkState.data?.merchantId,
        media: networkState.data?.media,
        type: networkState.data?.type,
      ),
    );
  }

  void _updatePaymentGateway() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _paymentGatewayRepository.update(
      id: state.paymentGatewayId!,
      input: state.toUpdateInput(),
    );
    emit(state.copyWith(networkStateSave: result));
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  void _createPaymentGateway() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _paymentGatewayRepository.create(
      input: state.toCreateInput(),
    );
    emit(state.copyWith(networkStateSave: result));
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  void onSave() {
    final id = state.paymentGatewayId;
    if (id != null) {
      _updatePaymentGateway();
    } else {
      _createPaymentGateway();
    }
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onPrivateKeyChanged(String privateKey) {
    emit(state.copyWith(privateKey: privateKey));
  }

  void onPublicKeyChanged(String publicKey) {
    emit(state.copyWith(publicKey: publicKey));
  }

  void onSaltKeyChanged(String saltKey) {
    emit(state.copyWith(saltKey: saltKey));
  }

  void onMerchantIdChanged(String merchantId) {
    emit(state.copyWith(merchantId: merchantId));
  }

  void onTypeChanged(Enum$PaymentGatewayType? type) {
    emit(state.copyWith(type: type));
  }

  void onIsEnabledChanged(bool isEnabled) {
    emit(state.copyWith(isEnabled: isEnabled));
  }

  void deletePaymentGateway({required String id}) async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _paymentGatewayRepository.delete(id: id);
    emit(state.copyWith(networkStateSave: result));
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
  }

  void onImageChanged(Fragment$Media? value) {
    emit(state.copyWith(media: value));
  }

  void onDelete() {
    final id = state.paymentGatewayId;
    if (id != null) {
      deletePaymentGateway(id: id);
    }
  }

  void onSetAsDefault() {}

  void onHide() {
    _changeVisibility(false);
  }

  void _changeVisibility(bool isVisible) async {
    emit(state.copyWith(networkStateSave: const ApiResponse.initial()));
    final result = await _paymentGatewayRepository.update(
      id: state.paymentGatewayId!,
      input: Input$UpdatePaymentGatewayInput(enabled: isVisible),
    );
    final networkState = result;
    emit(
      state.copyWith(
        paymentGateway: networkState,
        isEnabled: networkState.data?.enabled ?? state.isEnabled,
      ),
    );
  }

  void onShow() {
    _changeVisibility(true);
  }
}
