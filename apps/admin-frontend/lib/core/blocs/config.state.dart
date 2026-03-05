part of 'config.bloc.dart';

@freezed
sealed class ConfigState with _$ConfigState {
  const factory ConfigState({
    @Default(ApiResponseInitial()) ApiResponse<Fragment$license> license,
    @Default(ApiResponseInitial()) ApiResponse<Fragment$Config> config,
  }) = _ConfigState;

  // factory ConfigState.fromJson(Map<String, dynamic> json) =>
  //     _$ConfigStateFromJson(json);

  factory ConfigState.fromJson(Map<String, dynamic> json) {
    return ConfigState(
      license: ApiResponse.fromJson(
        json['license'] as Map<String, dynamic>,
        (data) => Fragment$license.fromJson(data as Map<String, dynamic>),
      ),
      config: ApiResponse.fromJson(
        json['config'] as Map<String, dynamic>,
        (data) => Fragment$Config.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  // @override
  Map<String, dynamic> toJson() {
    return {
      'license': license.toJson((data) => data.toJson()),
      'config': config.toJson((data) => data.toJson()),
    };
  }

  const ConfigState._();

  bool get isUnauthenticated => !license.isLoaded;
  bool get isAuthenticatedUnconfigured =>
      license.isLoaded &&
      (config.data?.isValid == false || config.data == null);
  bool get isDone => license.isLoaded && config.data?.isValid == true;

  bool get taxiEnabled =>
      license.data?.license?.connectedApps.contains(schema.Enum$AppType.Taxi) ??
      false;
  bool get shopEnabled =>
      license.data?.license?.connectedApps.contains(schema.Enum$AppType.Shop) ??
      false;
  bool get parkingEnabled =>
      license.data?.license?.connectedApps.contains(
        schema.Enum$AppType.Parking,
      ) ??
      false;

  List<schema.Enum$AppType> get enabledApps {
    final apps = <schema.Enum$AppType>[];
    if (taxiEnabled) apps.add(schema.Enum$AppType.Taxi);
    if (shopEnabled) apps.add(schema.Enum$AppType.Shop);
    if (parkingEnabled) apps.add(schema.Enum$AppType.Parking);
    return apps;
  }

  List<Fragment$AppConfigInfo> get enabledAppConfigs {
    final apps = <Fragment$AppConfigInfo>[];
    if (taxiEnabled) {
      apps.add(
        config.data?.config?.taxi ??
            Fragment$AppConfigInfo(
              name: 'Taxi',
              color: schema.Enum$AppColorScheme.Cobalt,
            ),
      );
    }
    if (shopEnabled) {
      apps.add(
        config.data?.config?.shop ??
            Fragment$AppConfigInfo(
              name: 'Shop',
              color: schema.Enum$AppColorScheme.HyperPink,
            ),
      );
    }
    if (parkingEnabled) {
      apps.add(
        config.data?.config?.parking ??
            Fragment$AppConfigInfo(
              name: 'Parking',
              color: schema.Enum$AppColorScheme.EarthyGreen,
            ),
      );
    }
    return apps;
  }

  Fragment$AppConfigInfo appConfig(schema.Enum$AppType? appType) =>
      switch (appType) {
        schema.Enum$AppType.Taxi =>
          config.data?.config?.taxi ??
              Fragment$AppConfigInfo(
                name: 'Taxi',
                color: schema.Enum$AppColorScheme.Cobalt,
              ),
        schema.Enum$AppType.Shop =>
          config.data?.config?.shop ??
              Fragment$AppConfigInfo(
                name: 'Shop',
                color: schema.Enum$AppColorScheme.HyperPink,
              ),
        schema.Enum$AppType.Parking =>
          config.data?.config?.parking ??
              Fragment$AppConfigInfo(
                name: 'Parking',
                color: schema.Enum$AppColorScheme.EarthyGreen,
              ),
        null => Fragment$AppConfigInfo(
          name: 'All Apps',
          color: schema.Enum$AppColorScheme.ElectricIndigo,
          logo: config.data?.config?.companyLogo,
        ),
        schema.Enum$AppType.$unknown => throw Exception('Unknown app type'),
      };
}
