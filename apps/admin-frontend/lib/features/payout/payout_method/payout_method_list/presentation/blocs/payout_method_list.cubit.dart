import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_list/data/graphql/payout_method_list.graphql.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_list/data/repositories/payout_method_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'payout_method_list.state.dart';
part 'payout_method_list.cubit.freezed.dart';

class PayoutMethodListBloc extends Cubit<PayoutMethodListState> {
  final PayoutMethodListRepository _payoutMethodListRepository =
      locator<PayoutMethodListRepository>();

  PayoutMethodListBloc() : super(PayoutMethodListState());

  void onStarted() {
    _fetchPayoutMethods();
  }

  void _fetchPayoutMethods() async {
    final payoutMethodsOrError = await _payoutMethodListRepository
        .getPayoutMethods(
          paging: state.paging,
          filter: Input$PayoutMethodFilter(
            type: state.typesFilter.isEmpty
                ? null
                : Input$PayoutMethodTypeFilterComparison(
                    $in: state.typesFilter,
                  ),
            name: state.search == null
                ? null
                : Input$StringFieldComparison(like: '%${state.search}'),
          ),
          sorting: state.sorting,
        );
    final payoutMethodsState = payoutMethodsOrError;
    emit(state.copyWith(payoutMethodsState: payoutMethodsState));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchPayoutMethods();
  }
}
