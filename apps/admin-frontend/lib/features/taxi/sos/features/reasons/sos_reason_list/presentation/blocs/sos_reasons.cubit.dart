import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/repositories/sos_reasson_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'sos_reasons.state.dart';
part 'sos_reasons.cubit.freezed.dart';

class SosReasonsBloc extends Cubit<SosReasonsState> {
  final SosReassonRepository _sosReassonRepository =
      locator<SosReassonRepository>();

  SosReasonsBloc() : super(SosReasonsState.initial());

  void onStarted() {
    _fetchSosReasons();
  }

  Future<void> _fetchSosReasons() async {
    emit(state.copyWith(sosReasons: const ApiResponse.loading()));

    final result = await _sosReassonRepository.getAll(
      paging: state.paging,
      filter: Input$SOSReasonFilter(
        name: (state.search?.isEmpty ?? true)
            ? null
            : Input$StringFieldComparison(like: '%${state.search}%'),
      ),
      sorting: state.sorting,
    );

    emit(state.copyWith(sosReasons: result));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchSosReasons();
  }

  void onSearchChanged(String value) {
    emit(state.copyWith(search: value));
    _fetchSosReasons();
  }
}
