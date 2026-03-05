import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/email_template.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/email_template/data/repositories/email_template_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'email_template_details.state.dart';
part 'email_template_details.cubit.freezed.dart';

class EmailTemplateDetailsBloc extends Cubit<EmailTemplateDetailsState> {
  final EmailTemplateRepository _emailTemplateRepository =
      locator<EmailTemplateRepository>();

  EmailTemplateDetailsBloc() : super(EmailTemplateDetailsState.initial());

  void onStarted({required String? id}) {
    if (id != null) {
      emit(
        EmailTemplateDetailsState(
          emailTemplateId: id,
          emailTemplate: const ApiResponse.loading(),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
      _getEmailTemplate();
    } else {
      emit(
        EmailTemplateDetailsState(
          emailTemplate: const ApiResponse.loaded(null),
          networkStateSave: const ApiResponse.initial(),
        ),
      );
    }
  }

  void _getEmailTemplate() async {
    final emailTemplateId = state.emailTemplateId;
    final emailTemplate = await _emailTemplateRepository.getOne(
      id: emailTemplateId!,
    );
    final networkState = emailTemplate;
    emit(
      state.copyWith(
        emailTemplate: networkState,
        name: networkState.data?.name,
        eventType: networkState.data?.eventType,
        subject: networkState.data?.subject,
        contentSource:
            networkState.data?.contentSource ?? Enum$EmailContentSource.Inline,
        bodyHtml: networkState.data?.bodyHtml,
        bodyPlainText: networkState.data?.bodyPlainText,
        providerTemplateId: networkState.data?.providerTemplateId,
        isActive: networkState.data?.isActive ?? true,
        locale: networkState.data?.locale,
        cc: networkState.data?.cc,
      ),
    );
  }

  void _createEmailTemplate() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final createResult = await _emailTemplateRepository.create(
      input: state.toInput(),
    );
    emit(state.copyWith(networkStateSave: createResult));
  }

  void _updateEmailTemplate() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _emailTemplateRepository.update(
      id: state.emailTemplateId!,
      input: state.toInput(),
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void onSave() {
    final id = state.emailTemplateId;
    if (id != null) {
      _updateEmailTemplate();
    } else {
      _createEmailTemplate();
    }
  }

  void onNameChanged(String p1) => emit(state.copyWith(name: p1));

  void onEventTypeChanged(Enum$EmailEventType? p1) =>
      emit(state.copyWith(eventType: p1));

  void onSubjectChanged(String p1) => emit(state.copyWith(subject: p1));

  void onBodyHtmlChanged(String p1) => emit(state.copyWith(bodyHtml: p1));

  void onBodyPlainTextChanged(String p1) =>
      emit(state.copyWith(bodyPlainText: p1));

  void onIsActiveChanged(bool p1) => emit(state.copyWith(isActive: p1));

  void onLocaleChanged(String? p1) => emit(state.copyWith(locale: p1));

  void onCcChanged(String? p1) => emit(state.copyWith(cc: p1));

  void onContentSourceChanged(Enum$EmailContentSource? p1) =>
      emit(state.copyWith(contentSource: p1 ?? Enum$EmailContentSource.Inline));

  void onProviderTemplateIdChanged(String? p1) =>
      emit(state.copyWith(providerTemplateId: p1));

  void onDelete() {
    final id = state.emailTemplateId;
    if (id != null) {
      _deleteEmailTemplate();
    }
  }

  void _deleteEmailTemplate() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _emailTemplateRepository.delete(
      id: state.emailTemplateId!,
    );
    emit(state.copyWith(networkStateSave: result));
  }
}
