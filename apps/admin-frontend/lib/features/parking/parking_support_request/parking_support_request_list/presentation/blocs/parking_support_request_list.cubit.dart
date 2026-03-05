import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/data/graphql/parking_support_request.graphql.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/data/repositories/parking_support_request_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'parking_support_request_list.state.dart';
part 'parking_support_request_list.cubit.freezed.dart';

class ParkingSupportRequestBloc extends Cubit<ParkingSupportRequestState> {
  final ParkingSupportRequestRepository _supportRequestRepository =
      locator<ParkingSupportRequestRepository>();

  ParkingSupportRequestBloc() : super(ParkingSupportRequestState.initial());

  void onStarted() {
    _fetchSupportRequestList();
  }

  Future<void> _fetchSupportRequestList() async {
    emit(state.copyWith(supportRequest: const ApiResponse.loading()));

    final supportRequestListOrError = await _supportRequestRepository.getAll(
      paging: state.paging,
      filter: Input$ParkingSupportRequestFilter(
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

  void onSortingChanged(List<Input$ParkingSupportRequestSort> value) {
    emit(state.copyWith(sortFields: value));
    _fetchSupportRequestList();
  }

  void onFilterChanged(List<Enum$ComplaintStatus> value) {
    emit(state.copyWith(filterStatus: value));
    _fetchSupportRequestList();
  }
}
