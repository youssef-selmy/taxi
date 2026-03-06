import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:better_design_system/theme/theme.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/router/app_router.dart';

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
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  // await HydratedBloc.storage.clear();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final _router = AppRouter().config(navigatorObservers: () => []);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).shortestSide < 600) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => SettingsCubit())],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "Showcase",
            themeMode: state.themeMode,
            theme: BetterTheme.fromBetterTheme(
              state.theme,
              context.isDesktop,
              false,
            ),
            darkTheme: BetterTheme.fromBetterTheme(
              state.theme,
              context.isDesktop,
              true,
            ),
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
