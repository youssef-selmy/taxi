import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/repositories/sos_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'sos.state.dart';

part 'sos.cubit.freezed.dart';

class SosBloc extends Cubit<SosState> {
  final SosRepository _sosRepository = locator<SosRepository>();

  SosBloc() : super(SosState.initial());

  void onStarted() {
    _fetchDistressSingals();
  }

  Future<void> _fetchDistressSingals() async {
    emit(state.copyWith(distressSignals: const ApiResponse.loading()));

    final result = await _sosRepository.getAll(
      paging: state.paging,
      filter: Input$DistressSignalFilter(
        status: state.filterStatus.isNotEmpty == true
            ? Input$SOSStatusFilterComparison($in: state.filterStatus)
            : null,
      ),
      sorting: state.sortFields,
    );

    emit(state.copyWith(distressSignals: result));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchDistressSingals();
  }

  void onSortingChanged(List<Input$DistressSignalSort> value) {
    emit(state.copyWith(sortFields: value));
    _fetchDistressSingals();
  }

  void onFilterChanged(List<Enum$SOSStatus> value) {
    emit(state.copyWith(filterStatus: value));
    _fetchDistressSingals();
  }
}
