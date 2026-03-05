import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/email_provider.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/email_provider/data/repositories/email_provider_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'email_provider_details.state.dart';
part 'email_provider_details.cubit.freezed.dart';

class EmailProviderDetailsBloc extends Cubit<EmailProviderDetailsState> {
  final EmailProviderRepository _emailProviderRepository =
      locator<EmailProviderRepository>();

  EmailProviderDetailsBloc() : super(EmailProviderDetailsState.initial());

  void onStarted({required String? id}) {
    if (id != null) {
      emit(
        EmailProviderDetailsState(
          emailProviderId: id,
          emailProvider: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
      _getEmailProvider();
    } else {
      emit(
        EmailProviderDetailsState(
          emailProvider: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
  }

  void _getEmailProvider() async {
    final emailProviderId = state.emailProviderId;
    final emailProvider = await _emailProviderRepository.getOne(
      id: emailProviderId!,
    );
    final networkState = emailProvider;
    emit(
      state.copyWith(
        emailProvider: networkState,
        name: networkState.data?.name,
        type: networkState.data?.type,
        isDefault: networkState.data?.isDefault ?? true,
        apiKey: networkState.data?.apiKey,
        fromEmail: networkState.data?.fromEmail,
        fromName: networkState.data?.fromName,
        replyToEmail: networkState.data?.replyToEmail,
      ),
    );
  }

  void _createEmailProvider() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final createResult = await _emailProviderRepository.create(
      input: state.toInput(),
    );
    final createApiResponse = createResult;
    emit(state.copyWith(networkStateSave: createApiResponse));
  }

  void _updateEmailProvider() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _emailProviderRepository.update(
      id: state.emailProviderId!,
      input: state.toInput(),
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void onSave() {
    final id = state.emailProviderId;
    if (id != null) {
      _updateEmailProvider();
    } else {
      _createEmailProvider();
    }
  }

  void onApiKeyChanged(String p1) => emit(state.copyWith(apiKey: p1));

  void onFromEmailChanged(String p1) => emit(state.copyWith(fromEmail: p1));

  void onFromNameChanged(String p1) => emit(state.copyWith(fromName: p1));

  void onReplyToEmailChanged(String p1) =>
      emit(state.copyWith(replyToEmail: p1));

  void onSetAsDefault() async {
    final id = state.emailProviderId;
    if (id == null) return;

    emit(state.copyWith(networkStateSetDefault: const ApiResponse.loading()));
    final result = await _emailProviderRepository.markAsDefault(id: id);
    emit(
      state.copyWith(
        networkStateSetDefault: result.mapData((_) {}),
        isDefault: result.isLoaded ? true : state.isDefault,
      ),
    );
  }

  void onDelete() {
    final id = state.emailProviderId;
    if (id != null) {
      _deleteEmailProvider();
    }
  }

  void onNameChanged(String p1) {
    emit(state.copyWith(name: p1));
  }

  void onTypeChanged(Enum$EmailProviderType? p1) {
    emit(state.copyWith(type: p1));
  }

  void _deleteEmailProvider() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _emailProviderRepository.delete(
      id: state.emailProviderId!,
    );
    emit(state.copyWith(networkStateSave: result));
  }
}
