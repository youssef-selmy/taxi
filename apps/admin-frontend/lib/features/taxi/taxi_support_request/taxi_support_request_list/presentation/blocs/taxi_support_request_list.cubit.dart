import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/data/graphql/taxi_support_request.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/data/repositories/taxi_support_request_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'taxi_support_request_list.state.dart';
part 'taxi_support_request_list.cubit.freezed.dart';

class TaxiSupportRequestBloc extends Cubit<TaxiSupportRequestState> {
  final TaxiSupportRequestRepository _supportRequestRepository =
      locator<TaxiSupportRequestRepository>();

  TaxiSupportRequestBloc() : super(TaxiSupportRequestState.initial());

  void onStarted() {
    _fetchSupportRequestList();
  }

  Future<void> _fetchSupportRequestList() async {
    emit(state.copyWith(supportRequest: const ApiResponse.loading()));

    final supportRequestListOrError = await _supportRequestRepository.getAll(
      paging: state.paging,
      filter: Input$TaxiSupportRequestFilter(
        status: state.filterStatus.isEmpty
            ? null
            : Input$ComplaintStatusFilterComparison($in: state.filterStatus),
      ),
      sorting: state.sortFields,
    );

    emit(state.copyWith(supportRequest: supportRequestListOrError));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchSupportRequestList();
  }

  void onSortingChanged(List<Input$TaxiSupportRequestSort> value) {
    emit(state.copyWith(sortFields: value));
    _fetchSupportRequestList();
  }

  void onFilterChanged(List<Enum$ComplaintStatus> value) {
    emit(state.copyWith(filterStatus: value));
    _fetchSupportRequestList();
  }
}
