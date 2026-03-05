import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/email_template/data/graphql/email_template.graphql.dart';
import 'package:admin_frontend/features/management_common/email_template/data/repositories/email_template_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'email_template_list.state.dart';
part 'email_template_list.cubit.freezed.dart';

class EmailTemplateListBloc extends Cubit<EmailTemplateListState> {
  final EmailTemplateRepository _emailTemplateRepository =
      locator<EmailTemplateRepository>();

  EmailTemplateListBloc() : super(EmailTemplateListState.initial());

  void onStarted() {
    _getEmailTemplates();
  }

  Future<void> _getEmailTemplates() async {
    emit(state.copyWith(emailTemplates: const ApiResponse.loading()));
    final emailTemplates = await _emailTemplateRepository.getAll(
      paging: state.paging,
      filter: Input$EmailTemplateFilter(
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: "%${state.searchQuery}%"),
      ),
      sort: state.sorting,
    );
    emit(state.copyWith(emailTemplates: emailTemplates));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _getEmailTemplates();
  }
}
