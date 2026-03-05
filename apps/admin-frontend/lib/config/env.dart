import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:generic_map/generic_map.dart';
import 'package:better_localization/country_code/country_code.dart';
import 'package:better_localization/measurement/units.dart';
import 'package:latlong2/latlong.dart';

class Env {
  // API Configuration

  /// The base URL for the API, with a fallback to a local server.
  /// It removes any trailing slashes to ensure a clean URL.
  static final String apiBaseUrl = dotenv
      .get('API_BASE_URL', fallback: "https://127.0.0.1:3004")
      .replaceAll(RegExp(r'/+$'), '');

  /// Environment variable to determine the current environment.
  /// It defaults to "dev" if not set.
  /// This can be used to differentiate between development, staging, and production environments.
  static final String environment = dotenv.get('ENVIRONMENT', fallback: "dev");

  /// If true, the app will use a mock API instead of the real one.
  /// This is useful for development and testing purposes.
  /// The fallback value is set to false, meaning the app will use the real API by default.
  /// To enable the mock API, set the environment variable `USE_MOCK_API` to `true`.
  static final bool useMockApi = dotenv.getBool(
    'USE_MOCK_API',
    fallback: false,
  );

  // App Configuration

  /// Specifies whether the app is in demo mode.
  /// This mostly affects some additional testing features and UI elements such as Map Settings, UI Themes, default OTP Banner and etc.
  static final bool isDemoMode = dotenv.getBool('DEMO_MODE', fallback: false);
  static final String appName = dotenv.get(
    'APP_NAME',
    fallback: "BetterSuite Admin Panel",
  );
  static final String companyName = dotenv.get(
    'COMPANY_NAME',
    fallback: "Lume Agency",
  );

  // Firebase Configuration
  static final String firebaseMessagingVapidKey = dotenv.get(
    'FIREBASE_MESSAGING_VAPID_KEY',
    fallback: "",
  );

  // Feature Flags
  static final bool showCentralHub = dotenv.getBool(
    'SHOW_CENTRAL_HUB',
    fallback: true,
  );
  static final bool showTimeIn24HourFormat = dotenv.getBool(
    '24_HOUR_TIME_FORMAT',
    fallback: true,
  );

  // Search Configuration
  static const int placeSearchSearchRadius = 100000;

  // Localization Defaults
  static final String defaultCurrency =
      dotenv.maybeGet('DEFAULT_CURRENCY') ?? "USD";
  static final CountryCode defaultCountry =
      CountryCode.parseByIso(dotenv.maybeGet('DEFAULT_COUNTRY')) ??
      CountryCode.parseByIso("US")!;
  static final String defaultLanguage =
      dotenv.maybeGet('DEFAULT_LANGUAGE') ?? "en";
  static final MeasurementSystem defaultMeasurementSystem =
      measurementSystemFromString(dotenv.maybeGet('MEASUREMENT_SYSTEM'));

  // Location Defaults
  static final Place defaultLocation = Place(
    LatLng(
      double.parse(dotenv.maybeGet('DEFAULT_LATITUDE') ?? "37.3875"),
      double.parse(dotenv.maybeGet('DEFAULT_LONGITUDE') ?? "-122.0575"),
    ),
    "",
    "",
  );

  // Map Configuration
  static PlatformMapProviderSettings get mapProviderPlatformSettings {
    final envProvider = dotenv.maybeGet('MAP_PROVIDER');
    if (envProvider == null) {
      return PlatformMapProviderSettings(
        defaultProvider: MapProviderEnum.mapBox,
        desktopProvider: MapProviderEnum.mapBox,
        webProvider: MapProviderEnum.openStreetMaps,
      );
    }
    final parsedEnvProvider = MapProviderEnum.fromString(envProvider);
    return PlatformMapProviderSettings(defaultProvider: parsedEnvProvider);
  }

  static MapLibreOptions mapLibreOptions(bool isDarkMode) => MapLibreOptions(
    apiKey: dotenv.maybeGet('MAPLIBRE_API_KEY'),
    styleUrl: isDarkMode
        ? dotenv.maybeGet('MAPLIBRE_STYLE_DARK_URL')
        : dotenv.maybeGet('MAPLIBRE_STYLE_URL'),
  );
  static MapboxOptions mapboxOptions(bool isDarkMode) => MapboxOptions(
    accessToken: dotenv.maybeGet('MAPBOX_ACCESS_TOKEN') ?? "",
    styleTileSetId: isDarkMode ? 'dark-v11' : 'streets-v12',
  );
  static MapboxSdkOptions mapboxSdkOptions(bool isDarkMode) => MapboxSdkOptions(
    accessToken: dotenv.maybeGet('MAPBOX_ACCESS_TOKEN') ?? "",
    style: isDarkMode ? MapboxSdkStyle.dark : MapboxSdkStyle.standard,
  );
}
