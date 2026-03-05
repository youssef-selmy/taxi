import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/sos/data/repositories/sos_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'sos_detail.state.dart';
part 'sos_detail.cubit.freezed.dart';

class SosDetailBloc extends Cubit<SosDetailState> {
  final SosRepository _sosRepository = locator<SosRepository>();

  SosDetailBloc() : super(SosDetailState());

  void onStarted(String sosId) {
    onSosIdChange(sosId);
    _fetchSosDetail();
  }

  Future<void> _fetchSosDetail() async {
    emit(state.copyWith(distressSignalDetail: const ApiResponse.loading()));

    final result = await _sosRepository.getOne(id: state.sosId!);

    emit(state.copyWith(distressSignalDetail: result));
  }

  void onSosIdChange(String sosId) {
    emit(state.copyWith(sosId: sosId));
  }

  void onStatusChanged(Enum$SOSStatus? status) async {
    final result = await _sosRepository.update(
      id: state.sosId!,
      update: Input$UpdateSosInput(status: status!),
    );
    emit(state.copyWith(distressSignalDetail: result));
  }
}
