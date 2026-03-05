part of 'configurer.bloc.dart';

@freezed
sealed class ConfigurerState with _$ConfigurerState {
  factory ConfigurerState({
    // Page
    @Default(ConfigurerPage.language) ConfigurerPage page,

    // Form Data
    required (String, String?) phoneNumber,
    @Default("") String email,
    @Default("") String firstName,
    @Default("") String lastName,
    Fragment$Media? profilePicture,
    @Default("") String password,
    @Default("") String googleMapsAdminPanelApiKey,
    @Default("") String googleMapsBackendApiKey,
    Fragment$Media? companyLogo,
    @Default("") String companyName,
    Fragment$Media? taxiLogo,
    @Default("") String taxiName,
    Enum$AppColorScheme? taxiColorPalette,
    Fragment$Media? shopLogo,
    @Default("") String shopName,
    Enum$AppColorScheme? shopColorPalette,
    Fragment$Media? parkingLogo,
    @Default("") String parkingName,
    Enum$AppColorScheme? parkingColorPalette,
    @Default("mysql") String mySqlHost,
    @Default(3306) int mySqlPort,
    @Default("root") String mySqlUser,
    @Default("defaultpassword") String mySqlPassword,
    @Default("bettersuite") String mySqlDatabase,
    @Default("127.0.0.1") String redisHost,
    @Default(6379) int redisPort,
    String? redisPassword,
    String? firebaseApiKey,
  }) = _ConfigurerState;

  // initial state
  factory ConfigurerState.initial() =>
      ConfigurerState(phoneNumber: ('US', null));

  const ConfigurerState._();

  (CountryCode, String?) get phoneNumberParsed => (
    CountryCode.parseByIso(phoneNumber.$1) ?? Env.defaultCountry,
    phoneNumber.$2,
  );

  Input$UpdateConfigInputV2 get toConfigInput => Input$UpdateConfigInputV2(
    companyName: companyName,
    companyLogo: companyLogo?.address,
    mysqlDatabase: mySqlDatabase,
    mysqlHost: mySqlHost,
    mysqlPassword: mySqlPassword,
    mysqlPort: mySqlPort,
    mysqlUser: mySqlUser,
    redisHost: redisHost,
    redisPort: redisPort,
    redisPassword: redisPassword,
    adminPanelAPIKey: googleMapsAdminPanelApiKey,
    backendMapsAPIKey: googleMapsBackendApiKey,
    firebaseProjectPrivateKey: firebaseApiKey,
    firstName: firstName,
    lastName: lastName,
    email: email,
    phoneNumber: phoneNumber.$2,
    password: password,
    taxi: Input$AppConfigInfoInput(
      logo: taxiLogo?.address,
      name: taxiName,
      color: taxiColorPalette,
    ),
    shop: Input$AppConfigInfoInput(
      logo: shopLogo?.address,
      name: shopName,
      color: shopColorPalette,
    ),
    parking: Input$AppConfigInfoInput(
      logo: parkingLogo?.address,
      name: parkingName,
      color: parkingColorPalette,
    ),
  );

  factory ConfigurerState.fromJson(Map<String, dynamic> json) {
    return ConfigurerState(
      page: ConfigurerPage.values.firstWhere(
        (e) => e.name == json['page'],
        orElse: () => ConfigurerPage.language,
      ),
      phoneNumber: (
        json['phoneNumber']?['countryCode'] ?? 'US',
        json['phoneNumber']?['number'],
      ),
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profilePicture: json['profilePicture'] != null
          ? Fragment$Media.fromJson(json['profilePicture'])
          : null,
      password: json['password'] ?? '',
      googleMapsAdminPanelApiKey: json['googleMapsAdminPanelApiKey'] ?? '',
      googleMapsBackendApiKey: json['googleMapsBackendApiKey'] ?? '',
      companyLogo: json['companyLogo'] != null
          ? Fragment$Media.fromJson(json['companyLogo'])
          : null,
      companyName: json['companyName'] ?? '',
      taxiLogo: json['taxiLogo'] != null
          ? Fragment$Media.fromJson(json['taxiLogo'])
          : null,
      taxiName: json['taxiName'] ?? '',
      taxiColorPalette: json['taxiColorPalette'] != null
          ? Enum$AppColorScheme.values.firstWhere(
              (e) => e.name == json['taxiColorPalette'],
            )
          : null,
      shopLogo: json['shopLogo'] != null
          ? Fragment$Media.fromJson(json['shopLogo'])
          : null,
      shopName: json['shopName'] ?? '',
      shopColorPalette: json['shopColorPalette'] != null
          ? Enum$AppColorScheme.values.firstWhere(
              (e) => e.name == json['shopColorPalette'],
            )
          : null,
      parkingLogo: json['parkingLogo'] != null
          ? Fragment$Media.fromJson(json['parkingLogo'])
          : null,
      parkingName: json['parkingName'] ?? '',
      parkingColorPalette: json['parkingColorPalette'] != null
          ? Enum$AppColorScheme.values.firstWhere(
              (e) => e.name == json['parkingColorPalette'],
            )
          : null,
      mySqlHost: json['mySqlHost'] ?? 'mysql',
      mySqlPort: json['mySqlPort'] ?? 3306,
      mySqlUser: json['mySqlUser'] ?? 'root',
      mySqlPassword: json['mySqlPassword'] ?? 'defaultpassword',
      mySqlDatabase: json['mySqlDatabase'] ?? 'bettersuite',
      redisHost: json['redisHost'] ?? '127.0.0.1',
      redisPort: json['redisPort'] ?? 6379,
      redisPassword: json['redisPassword'],
      firebaseApiKey: json['firebaseApiKey'],
    );
  }

  // @override
  Map<String, dynamic> toJson() {
    return {
      'page': page.name,
      'phoneNumber': {'countryCode': phoneNumber.$1, 'number': phoneNumber.$2},
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture?.toJson(),
      'password': password,
      'googleMapsAdminPanelApiKey': googleMapsAdminPanelApiKey,
      'googleMapsBackendApiKey': googleMapsBackendApiKey,
      'companyLogo': companyLogo?.toJson(),
      'companyName': companyName,
      'taxiLogo': taxiLogo?.toJson(),
      'taxiName': taxiName,
      'taxiColorPalette': taxiColorPalette?.name,
      'shopLogo': shopLogo?.toJson(),
      'shopName': shopName,
      'shopColorPalette': shopColorPalette?.name,
      'parkingLogo': parkingLogo?.toJson(),
      'parkingName': parkingName,
      'parkingColorPalette': parkingColorPalette?.name,
      'mySqlHost': mySqlHost,
      'mySqlPort': mySqlPort,
      'mySqlUser': mySqlUser,
      'mySqlPassword': mySqlPassword,
      'mySqlDatabase': mySqlDatabase,
      'redisHost': redisHost,
      'redisPort': redisPort,
      'redisPassword': redisPassword,
      'firebaseApiKey': firebaseApiKey,
    };
  }
}

enum ConfigurerPage {
  language,
  personalNumber,
  personalName,
  personalPassword,
  brand,
  brandCompany,
  brandApps,
  googleMaps,
  mySql,
  redis,
  firebase,
  confirmation,
}

extension ConfigurerPageX on ConfigurerPage {
  String get name {
    switch (this) {
      case ConfigurerPage.language:
        return "Panel Language";
      case ConfigurerPage.personalName:
        return "Personal Information";
      case ConfigurerPage.brand:
        return "Brand Information";
      case ConfigurerPage.googleMaps:
        return "Google Maps API";
      case ConfigurerPage.mySql:
        return "MySQL";
      case ConfigurerPage.redis:
        return "Redis";
      case ConfigurerPage.firebase:
        return "Firebase";
      case ConfigurerPage.confirmation:
        return "Confirmation";
      default:
        return "";
    }
  }

  int get pageIndex {
    switch (this) {
      case ConfigurerPage.language:
        return 0;

      case ConfigurerPage.personalNumber:
      case ConfigurerPage.personalName:
      case ConfigurerPage.personalPassword:
        return 1;

      case ConfigurerPage.brand:
      case ConfigurerPage.brandCompany:
      case ConfigurerPage.brandApps:
        return 2;

      case ConfigurerPage.googleMaps:
        return 3;
      case ConfigurerPage.mySql:
        return 4;
      case ConfigurerPage.redis:
        return 5;
      case ConfigurerPage.firebase:
        return 6;
      case ConfigurerPage.confirmation:
        return 7;
    }
  }
}
