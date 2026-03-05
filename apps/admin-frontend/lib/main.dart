import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/config/theme/theme.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/blocs/settings.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';

// import 'firebase_options.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb == false) {
    await FMTCObjectBoxBackend().initialise();
    await const FMTCStore('mapStore').manage.create();
  }
  await dotenv.load(
    fileName: '.env.${kReleaseMode ? 'prod' : 'dev'}',
    isOptional: true,
  );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  // await HydratedBloc.storage.clear();
  // await DefaultCacheManager().emptyCache();
  configureDependencies();
  await Hive.initFlutter();
  // if (Platform.isWindows == false && Platform.isLinux == false) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  await locator<ConfigBloc>().onStarted();
  if (dotenv.maybeGet('SENTRY_DSN') != null) {
    await SentryFlutter.init((options) {
      options.dsn = dotenv.maybeGet('SENTRY_DSN');
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    }, appRunner: () => runApp(SentryWidget(child: const MyApp())));
  } else {
    runApp(const MyApp());
  }
}

/// Parses a locale string into a Locale object.
/// Handles formats like: "en", "en_GB", "en-GB", "en_uk", "en-uk"
Locale _parseLocale(String localeString) {
  // Replace hyphens with underscores and normalize
  final normalized = localeString.replaceAll('-', '_').trim();

  // Handle special cases for common variations
  final lowerNormalized = normalized.toLowerCase();
  if (lowerNormalized == 'en_uk' || lowerNormalized == 'en_gb') {
    return const Locale('en', 'GB');
  }
  if (lowerNormalized == 'zh_cn') {
    return const Locale('zh', 'CN');
  }
  if (lowerNormalized == 'zh_tw') {
    return const Locale('zh', 'TW');
  }

  // Split by underscore
  final parts = normalized.split('_');

  if (parts.length == 1) {
    return Locale(parts[0].toLowerCase());
  } else if (parts.length >= 2) {
    return Locale(parts[0].toLowerCase(), parts[1].toUpperCase());
  }

  // Fallback
  return const Locale('en');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<SettingsCubit>()),
        BlocProvider.value(value: locator<AuthBloc>()),
        BlocProvider.value(value: locator<ConfigBloc>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return BlocBuilder<ConfigBloc, ConfigState>(
            builder: (context, stateConfig) {
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  final appColorScheme =
                      (authState.selectedAppType == null
                          ? null
                          : stateConfig
                                .appConfig(authState.selectedAppType!)
                                .color) ??
                      stateConfig.config.data?.config?.companyColor ??
                      Enum$AppColorScheme.ElectricIndigo;
                  return LocalizationConfig(
                    measurementSystem: Env.defaultMeasurementSystem,
                    defaultCurrency: Env.defaultCurrency,
                    defaultLanguage: Env.defaultLanguage,
                    defaultLatitude: Env.defaultLocation.latLng.latitude,
                    defaultLongitude: Env.defaultLocation.latLng.longitude,
                    is24HourFormat: Env.showTimeIn24HourFormat,
                    child: MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      title: Env.appName,
                      themeMode: state.themeMode,
                      theme: BetterTheme.fromBetterTheme(
                        AppTheme.fromColorScheme(appColorScheme),
                        context.isDesktop,
                        false,
                      ),
                      darkTheme: BetterTheme.fromBetterTheme(
                        AppTheme.fromColorScheme(appColorScheme),
                        context.isDesktop,
                        true,
                      ),
                      locale: _parseLocale(state.locale),
                      localizationsDelegates: S.localizationsDelegates,
                      supportedLocales: S.supportedLocales,
                      routerConfig: locator<AppRouter>().config(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
