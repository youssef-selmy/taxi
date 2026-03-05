import 'package:admin_frontend/core/graphql/fragments/dispatch_config.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/features/settings/features/settings_dispatch/domain/repositories/settings_dispatch_repository.dart';

part 'settings_dispatch.state.dart';
part 'settings_dispatch.cubit.freezed.dart';

class SettingsDispatchCubit extends Cubit<SettingsDispatchState> {
  final SettingsDispatchRepository _settingsDispatchRepository = locator();

  SettingsDispatchCubit() : super(SettingsDispatchState.initial());

  void onStarted() {
    _fetchDispatchConfig();
  }

  void _fetchDispatchConfig() async {
    final configResponse = await _settingsDispatchRepository
        .getDispatchConfig();
    final configData = configResponse.data;
    emit(
      state.copyWith(
        dispatchConfig: configResponse,
        strategy: configData?.strategy,
        requestTimeoutSeconds: configData?.requestTimeoutSeconds,
        maxSearchRadiusMeters: configData?.maxSearchRadiusMeters,
        preDispatchBufferMinutes: configData?.preDispatchBufferMinutes,
        notifyAdminOnFailure: configData?.notifyAdminOnFailure,
        // Scoring Config
        distanceWeight: (configData?.scoring?.distanceWeight ?? 0) * 100,
        driverRatingWeight:
            (configData?.scoring?.driverRatingWeight ?? 0) * 100,
        idleTimeWeight: (configData?.scoring?.idleTimeWeight ?? 0) * 100,
        cancelRateWeight: (configData?.scoring?.cancelRateWeight ?? 0) * 100,
        threshold: (configData?.scoring?.threshold ?? 0) * 100,
        topN: configData?.scoring?.topN,
        // Sequential Config
        broadcastWaveSize: configData?.broadcastConfig?.waveSize,
        broadcastWaveIntervalSeconds:
            configData?.broadcastConfig?.waveIntervalSeconds,
        broadcastMaxWaves: configData?.broadcastConfig?.maxWaves,
        broadcastRadiusIncrementMeters:
            configData?.broadcastConfig?.radiusIncrementMeters,
        // Sequential Config
        sequentialPerDriverRequestTimeoutSeconds:
            configData?.sequentialConfig?.perDriverTimeoutSeconds,
        sequentialDriverRetryLimit:
            configData?.sequentialConfig?.driverRetryLimit,
        sequentialMaxDriversToTest:
            configData?.sequentialConfig?.maxDriversToTest,
        sequentialAvoidPreviousCandidates:
            configData?.sequentialConfig?.avoidPreviousCandidates,
        // Radius Expansion Config
        radiusExpansionEnabled: configData?.radiusExpansion?.enabled,
        stepMeters: configData?.radiusExpansion?.stepMeters,
        expansionIntervalSeconds: configData?.radiusExpansion?.intervalSeconds,
        maxSteps: configData?.radiusExpansion?.maxSteps,
      ),
    );
  }

  void setStrategy(Enum$DispatchStrategy strategy) {
    emit(state.copyWith(strategy: strategy));
  }

  void setDistanceWeight(double value) {
    emit(state.copyWith(distanceWeight: value));
  }

  void setDriverRatingWeight(double value) {
    emit(state.copyWith(driverRatingWeight: value));
  }

  void setIdleTimeWeight(double value) {
    emit(state.copyWith(idleTimeWeight: value));
  }

  void setCancelRateWeight(double value) {
    emit(state.copyWith(cancelRateWeight: value));
  }

  void setThreshold(double value) {
    emit(state.copyWith(threshold: value));
  }

  void setTopN(int value) {
    emit(state.copyWith(topN: value));
  }

  void setBroadcastWaveSize(int? value) {
    emit(state.copyWith(broadcastWaveSize: value));
  }

  void setBroadcastWaveIntervalSeconds(int? value) {
    emit(state.copyWith(broadcastWaveIntervalSeconds: value));
  }

  void setBroadcastMaxWaves(int? value) {
    emit(state.copyWith(broadcastMaxWaves: value));
  }

  void setSequentialPerDriverRequestTimeoutSeconds(int? value) {
    emit(state.copyWith(sequentialPerDriverRequestTimeoutSeconds: value));
  }

  void setSequentialDriverRetryLimit(int? p1) {
    emit(state.copyWith(sequentialDriverRetryLimit: p1));
  }

  void setSequentialMaxDriversToTest(int? p1) {
    emit(state.copyWith(sequentialMaxDriversToTest: p1));
  }

  void setSequentialAvoidPreviousCandidates(bool? p1) {
    emit(state.copyWith(sequentialAvoidPreviousCandidates: p1));
  }

  void resetToDefaults() {
    emit(
      state.copyWith(
        preDispatchBufferMinutes: 30,
        distanceWeight: 40,
        driverRatingWeight: 30,
        idleTimeWeight: 20,
        cancelRateWeight: 10,
        threshold: 70,
        topN: 3,
        broadcastWaveSize: 3,
        broadcastWaveIntervalSeconds: 15,
        broadcastMaxWaves: 3,
        sequentialPerDriverRequestTimeoutSeconds: 20,
        sequentialDriverRetryLimit: 2,
        sequentialMaxDriversToTest: 15,
        sequentialAvoidPreviousCandidates: true,
        radiusExpansionEnabled: false,
        stepMeters: 500,
        expansionIntervalSeconds: 30,
        maxSteps: 5,
      ),
    );
  }

  void saveSettings() {
    _saveSettings();
  }

  Future<void> _saveSettings() async {
    emit(state.copyWith(saveSettingsResponse: ApiResponse.loading()));
    final input = state.toInput();
    final updateResponseOrError = await _settingsDispatchRepository
        .updateDispatchConfig(input);
    emit(state.copyWith(saveSettingsResponse: updateResponseOrError));
  }

  void setBroadcastRadiusIncrementMeters(int? value) {
    emit(state.copyWith(broadcastRadiusIncrementMeters: value));
  }

  void setPreDispatchBufferMinutes(int? value) {
    emit(state.copyWith(preDispatchBufferMinutes: value));
  }

  void setMaxSearchRadiusMeters(int? value) {
    emit(state.copyWith(maxSearchRadiusMeters: value));
  }

  void setRequestTimeoutSeconds(int? value) {
    emit(state.copyWith(requestTimeoutSeconds: value));
  }
}
