part of 'settings_dispatch.cubit.dart';

@freezed
sealed class SettingsDispatchState with _$SettingsDispatchState {
  const factory SettingsDispatchState({
    required GlobalKey<FormState> formKey,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$DispatchConfig> dispatchConfig,

    Enum$DispatchStrategy? strategy,
    int? requestTimeoutSeconds,
    bool? notifyAdminOnFailure,
    int? maxSearchRadiusMeters,
    int? preDispatchBufferMinutes,

    // Scoring Config
    double? distanceWeight,
    double? driverRatingWeight,
    double? idleTimeWeight,
    double? cancelRateWeight,
    double? threshold,
    int? topN,

    // Broadcast Config
    int? broadcastWaveSize,
    int? broadcastWaveIntervalSeconds,
    int? broadcastMaxWaves,
    int? broadcastRadiusIncrementMeters,
    int? broadcastMaxCandidateCount,

    // Sequential Config
    int? sequentialPerDriverRequestTimeoutSeconds,
    int? sequentialDriverRetryLimit,
    int? sequentialMaxDriversToTest,
    bool? sequentialAvoidPreviousCandidates,

    // Radius Expansion Config
    bool? radiusExpansionEnabled,
    int? stepMeters,
    int? expansionIntervalSeconds,
    int? maxSteps,

    @Default(ApiResponseInitial()) ApiResponse<void> saveSettingsResponse,
  }) = _SettingsDispatchState;

  const SettingsDispatchState._();

  // Initial
  factory SettingsDispatchState.initial() =>
      SettingsDispatchState(formKey: GlobalKey<FormState>());

  Input$DispatchConfigInput toInput() => Input$DispatchConfigInput(
    strategy: strategy!,
    requestTimeoutSeconds: requestTimeoutSeconds!,
    notifyAdminOnFailure: notifyAdminOnFailure,
    maxSearchRadiusMeters: maxSearchRadiusMeters!,
    preDispatchBufferMinutes: preDispatchBufferMinutes!,
    scoring: Input$DriverScoringConfigInput(
      distanceWeight: (distanceWeight ?? 0) / 100,
      driverRatingWeight: (driverRatingWeight ?? 0) / 100,
      idleTimeWeight: (idleTimeWeight ?? 0) / 100,
      cancelRateWeight: (cancelRateWeight ?? 0) / 100,
      threshold: (threshold ?? 0) / 100,
      topN: topN,
    ),
    broadcastConfig: strategy == Enum$DispatchStrategy.Broadcast
        ? Input$BroadcastConfigInput(
            waveSize: broadcastWaveSize!,
            waveIntervalSeconds: broadcastWaveIntervalSeconds!,
            maxWaves: broadcastMaxWaves!,
            radiusIncrementMeters: broadcastRadiusIncrementMeters!,
          )
        : null,
    sequentialConfig: strategy == Enum$DispatchStrategy.Sequential
        ? Input$SequentialConfigInput(
            perDriverTimeoutSeconds: sequentialPerDriverRequestTimeoutSeconds!,
            maxDriversToTest: sequentialMaxDriversToTest!,
            driverRetryLimit: sequentialDriverRetryLimit!,
            avoidPreviousCandidates: sequentialAvoidPreviousCandidates!,
          )
        : null,
    radiusExpansion: radiusExpansionEnabled == true
        ? Input$RadiusExpansionConfigInput(
            enabled: radiusExpansionEnabled!,
            stepMeters: stepMeters!,
            intervalSeconds: expansionIntervalSeconds!,
            maxSteps: maxSteps!,
          )
        : null,
  );
}
