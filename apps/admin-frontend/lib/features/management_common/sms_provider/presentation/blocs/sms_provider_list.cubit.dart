import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/graphql/sms_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/repositories/sms_provider_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'sms_provider_list.state.dart';
part 'sms_provider_list.cubit.freezed.dart';

class SmsProviderListBloc extends Cubit<SmsProviderListState> {
  final SmsProviderRepository _smsProviderRepository =
      locator<SmsProviderRepository>();

  SmsProviderListBloc() : super(SmsProviderListState.initial());

  void onStarted() {
    _getSmsProviders();
  }

  Future<void> _getSmsProviders() async {
    emit(state.copyWith(smsProviders: const ApiResponse.loading()));
    final smsProviders = await _smsProviderRepository.getAll(
      paging: state.paging,
      filter: Input$SMSProviderFilter(
        name: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: "%${state.searchQuery}%"),
      ),
      sort: state.sorting,
    );
    emit(state.copyWith(smsProviders: smsProviders));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _getSmsProviders();
  }
}
