import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/sms_provider.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/repositories/sms_provider_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'sms_provider_details.state.dart';
part 'sms_provider_details.cubit.freezed.dart';

class SmsProviderDetailsBloc extends Cubit<SmsProviderDetailsState> {
  final SmsProviderRepository _smsProviderRepository =
      locator<SmsProviderRepository>();

  SmsProviderDetailsBloc() : super(SmsProviderDetailsState.initial());

  void onStarted({required String? id}) {
    if (id != null) {
      emit(
        SmsProviderDetailsState(
          smsProviderId: id,
          smsProvider: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
      _getSmsProvider();
    } else {
      emit(
        SmsProviderDetailsState(
          smsProvider: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
  }

  void _getSmsProvider() async {
    final smsProviderId = state.smsProviderId;
    final smsProvider = await _smsProviderRepository.getOne(id: smsProviderId!);
    final networkState = smsProvider;
    emit(
      state.copyWith(
        smsProvider: networkState,
        name: networkState.data?.name,
        type: networkState.data?.type,
        isDefault: networkState.data?.isDefault ?? true,
        accountId: networkState.data?.accountId,
        authToken: networkState.data?.authToken,
        fromNumber: networkState.data?.fromNumber,
        smsType: networkState.data?.smsType,
        verificationTemplate: networkState.data?.verificationTemplate,
        callMaskingNumber: networkState.data?.callMaskingNumber,
        callMaskingEnabled: networkState.data?.callMaskingEnabled ?? false,
      ),
    );
  }

  void _createSmsProvider() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final createResult = await _smsProviderRepository.create(
      input: state.toInput(),
    );
    final createApiResponse = createResult;
    emit(state.copyWith(networkStateSave: createApiResponse));
  }

  void _updateSmsProvider() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _smsProviderRepository.update(
      id: state.smsProviderId!,
      input: state.toInput(),
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void onSave() {
    final id = state.smsProviderId;
    if (id != null) {
      _updateSmsProvider();
    } else {
      _createSmsProvider();
    }
  }

  void onVerificationTemplateChanged(String p1) =>
      emit(state.copyWith(verificationTemplate: p1));

  void onSmsTypeChanged(String p1) => emit(state.copyWith(smsType: p1));

  void onFromNumberChanged(String p1) => emit(state.copyWith(fromNumber: p1));

  void onAuthTokenChanged(String p1) => emit(state.copyWith(authToken: p1));

  void onAccountIdChanged(String p1) => emit(state.copyWith(accountId: p1));

  void onSetAsDefault() async {
    final id = state.smsProviderId;
    if (id == null) return;

    emit(state.copyWith(networkStateSetDefault: const ApiResponse.loading()));
    final result = await _smsProviderRepository.markAsDefault(id: id);
    emit(
      state.copyWith(
        networkStateSetDefault: result.mapData((_) {}),
        isDefault: result.isLoaded ? true : state.isDefault,
      ),
    );
  }

  void onDelete() {
    final id = state.smsProviderId;
    if (id != null) {
      _deleteSmsProvider();
    }
  }

  void onNameChanged(String p1) {
    emit(state.copyWith(name: p1));
  }

  void onTypeChanged(Enum$SMSProviderType? p1) {
    emit(state.copyWith(type: p1));
  }

  void onCallMaskingNumberChanged(String p1) =>
      emit(state.copyWith(callMaskingNumber: p1));

  void onCallMaskingEnabledChanged(bool p1) =>
      emit(state.copyWith(callMaskingEnabled: p1));

  void _deleteSmsProvider() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _smsProviderRepository.delete(
      id: state.smsProviderId!,
    );
    emit(state.copyWith(networkStateSave: result));
  }
}
