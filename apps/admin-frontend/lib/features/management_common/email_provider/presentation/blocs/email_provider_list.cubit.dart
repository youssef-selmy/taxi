import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/email_provider/data/graphql/email_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/email_provider/data/repositories/email_provider_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'email_provider_list.state.dart';
part 'email_provider_list.cubit.freezed.dart';

class EmailProviderListBloc extends Cubit<EmailProviderListState> {
  final EmailProviderRepository _emailProviderRepository =
      locator<EmailProviderRepository>();

  EmailProviderListBloc() : super(EmailProviderListState.initial());

  void onStarted() {
    _getEmailProviders();
  }

  Future<void> _getEmailProviders() async {
    emit(state.copyWith(emailProviders: const ApiResponse.loading()));
    final emailProviders = await _emailProviderRepository.getAll(
      paging: state.paging,
      filter: Input$EmailProviderFilter(
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: "%${state.searchQuery}%"),
      ),
      sort: state.sorting,
    );
    emit(state.copyWith(emailProviders: emailProviders));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _getEmailProviders();
  }
}
