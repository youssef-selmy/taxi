import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/sos/data/repositories/sos_reasson_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'add_sos_reasson.state.dart';
part 'add_sos_reasson.cubit.freezed.dart';

class AddSosReassonBloc extends Cubit<AddSosReassonState> {
  final SosReassonRepository _sosReassonRepository =
      locator<SosReassonRepository>();

  AddSosReassonBloc() : super(const AddSosReassonState());

  void onStarted(String? id) {
    if (id != null) {
      _onSosReassonIdChange(id);
      _fetchSosReassonDetail();
    } else {
      emit(
        state.copyWith(
          sosReasonDetailNetwork: const ApiResponse<void>.loaded(null),
          title: null,
          sosReassonId: null,
        ),
      );
    }
  }

  Future<void> _fetchSosReassonDetail() async {
    emit(state.copyWith(sosReasonDetailNetwork: const ApiResponse.loading()));

    final result = await _sosReassonRepository.getOne(id: state.sosReassonId!);
    final networkState = result;
    emit(
      state.copyWith(
        sosReasonDetailNetwork: networkState,
        title: networkState.data?.name,
      ),
    );
  }

  void onSubmit() {
    if (state.sosReassonId == null) {
      _onAddSosReasson();
    } else {
      _onUpdateSosReasson();
    }
  }

  void _onAddSosReasson() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));

    final result = await _sosReassonRepository.create(
      input: Input$CreateOneSOSReasonInput(
        sOSReason: Input$CreateSosReasonInput(name: state.title!),
      ),
    );

    emit(state.copyWith(networkStateSave: result));
  }

  void _onUpdateSosReasson() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));

    final result = await _sosReassonRepository.update(
      input: Input$UpdateOneSOSReasonInput(
        id: state.sosReassonId!,
        update: Input$UpdateSosReasonInput(name: state.title!),
      ),
    );

    emit(state.copyWith(networkStateSave: result));
  }

  void onDeleteSosReasson() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));

    final result = await _sosReassonRepository.delete(id: state.sosReassonId!);

    emit(state.copyWith(networkStateSave: result));
  }

  void onHideSosReasson() async {
    _onChangeActiveStatus(isActive: false);
  }

  void onShowSosReasson() async {
    _onChangeActiveStatus(isActive: true);
  }

  void _onChangeActiveStatus({required bool isActive}) async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));

    final result = await _sosReassonRepository.hideReasson(
      input: Input$UpdateOneSOSReasonInput(
        id: state.sosReassonId!,
        update: Input$UpdateSosReasonInput(isActive: false),
      ),
    );

    emit(state.copyWith(networkStateSave: result));
  }

  void onReassonTitleChanged(String value) {
    emit(state.copyWith(title: value));
  }

  void _onSosReassonIdChange(String id) {
    emit(state.copyWith(sosReassonId: id));
  }
}
